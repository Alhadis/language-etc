"use strict";

module.exports = {
	disposables: null,
	isUpdating: false,
	name: require(__dirname + "/package.json").name,
	
	/** Package configuration schema */
	config: {
		autoUpdate: {
			type: "boolean",
			title: "Auto-update",
			description: "Fetch changes from upstream at startup.",
			default: false,
			order: 1,
		},
		linkScopes: {
			order: 2,
			type: "array",
			items: {type: "string"},
			title: "Hyperlink scopes",
			description: "Scope selectors for tokens whose contents can be opened by the `link:open` command.",
			default: [
				"constant.other.reference.link",
				"markup.link",
				"markup.underline.link",
				"string.other.link",
			],
		},
	},
	
	/**
	 * Activate package and handle event subscriptions.
	 * @api private
	 */
	activate(){
		this.isUpdating = false;
		this.disposables = new (require("atom").CompositeDisposable)(
			atom.config.observe(this.name + ".autoUpdate", value => value && this.update()),
			atom.commands.add("atom-workspace", `${this.name}:update`, this.update.bind(this, true)),
			atom.commands.add("atom-text-editor", "link:open", this.openLink.bind(this)),
		);
	},
	
	/**
	 * Deactivate package.
	 * @api private
	 */
	deactivate(){
		this.disposables && this.disposables.dispose();
		this.disposables = null;
		this.isUpdating = false;
	},
	
	/**
	 * Intercept a `link:open` command.
	 * @param {CustomEvent} event
	 * @api private
	 */
	openLink(event){
		const editor = atom.workspace.isTextEditor(event.currentTarget)
			? event.currentTarget
			: atom.workspace.getActiveTextEditor();
		if(!editor) return;
		for(const {cursor} of editor.getSelectionsOrderedByBufferPosition()){
			const position = cursor.getBufferPosition();
			const token    = editor.tokenizedBuffer.tokenForPosition(position);
			const links    = atom.config.get("language-etc.linkScopes");
			
			// Open ShellCheck's wiki entry for the error-code under the cursor
			if(token && token.scopes.includes("markup.underline.link.error-code.shellcheckrc")){
				const {shell} = require("electron");
				shell.openExternal("https://www.shellcheck.net/wiki/" + token.value.toUpperCase());
				event.stopImmediatePropagation();
			}
			
			// Well-formed URLs not scoped by `language-hyperlink`
			else if(links.some(scope => token.matchesScopeSelector(scope))){
				const {fileURLToPath, parse} = require("url");
				const url = parse(token.value);
				switch(url.protocol){
					case "http:":
					case "https:": {
						const {shell} = require("electron");
						shell.openExternal(url.href);
						break;
					}
					case "file:":
						atom.workspace.open(fileURLToPath(url.href));
						break;
					default:
						continue;
				}
				event.stopImmediatePropagation();
			}
		}
	},
	
	/**
	 * Parse porcelain output from git-status(1).
	 * @param {String} input
	 * @return {Object}
	 * @api public
	 */
	parseStatus(input){
		input = String(input || "");
		const result = {__proto__: null};
		const header = /^# branch\.(\S+)\s+([^\r\n]+)$/gm;
		let match;
		while(match = header.exec(input)){
			const key = match[1];
			let value = match[2].trim().split(/\s+/);
			switch(key){
				case "ab":
					result.ahead  = Number(value[0]);
					result.behind = Number(value[1]);
					break;
				case "oid":
					value = value.slice(0, 8); // Fall-through
				default:
					result[key] = value.length < 2 ? value[0] : value;
			}
		}
		if(result.ab){
			const [ahead, behind] = result.ab.map(Number);
			Object.assign(result, {ahead, behind});
		}
		return result;
	},
	
	/**
	 * Download the latest changes from upstream.
	 * @param {Boolean} [verbose=false]
	 * @return {Promise.<Notification|void>}
	 * @api public
	 */
	async update(verbose = false){
		if(this.isUpdating)
			return verbose
				? atom.notifications.addWarning("An update is already in progress.")
				: undefined;
		this.isUpdating = true;
		
		const {name} = this;
		const pkg = await atom.packages.loadPackage(this.name);
		let alert;
		
		// Helper functions
		const exec = require("child_process")["exec"][require("util").promisify.custom];
		const $ = async (...x) => (await exec(String.raw(...x), {cwd: pkg.path})).stdout;
		
		// Update HEAD and retrieve branch status
		const output = await $ `git fetch && git status --branch --porcelain=v2`;
		if(output){
			const {ahead, behind, oid: oid1} = this.parseStatus(output);
			if(oid1 && 0 === ahead && behind < 0){
				await $ `git pull`;
				const {oid: oid2} = this.parseStatus(await $ `git status --branch --porcelain=v2`);
				alert = atom.notifications.addSuccess(
					`Updated \`${name}\` from ${oid1} to ${oid2}`,
					{detail: "Restart Atom for the updates to take effect."},
				);
			}
		}
		else if(verbose)
			alert = atom.notifications.addInfo(`\`${name}\` is already up-to-date.`);
		
		this.isUpdating = false;
		return alert;
	},
};
