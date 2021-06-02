Highlighting for dot-files, `/etc/*` configs, and program-specific manifests
============================================================================

Syntax highlighting for various configs and file-formats too specific to warrant
their own repositories. Basically, a junk-drawer for any language grammar I felt
an itch to write, or those I've written for [GitHub Linguist][1].

Feel free to install this in Atom, but don't complain about the mess it'll make
of your [`grammar-selector`](https://github.com/atom/grammar-selector)'s menu…


Installing in Atom
------------------
You'll need [Git][2], because I don't plan on ever publishing this to `atom.io`:

~~~shell
# On Unix-like platforms
cd ~/.atom/packages && git clone https://github.com/Alhadis/language-etc.git
~~~

~~~batchfile
:: For Windows users
cd %HOMEPATH%\.atom\packages
git clone "https://github.com/Alhadis/language-etc.git"
~~~

To stay updated, run `language-etc:update` or add this to `~/.atom/config.cson`:

~~~coffee
"language-etc":
	autoUpdate: true
~~~


Supported formats
-----------------
* [x] [`.curlrc`](https://curl.haxx.se/docs/manpage.html#-K)
* [x] [`.env`](https://github.com/motdotla/dotenv)
* [x] [`.gitattributes`](https://git-scm.com/docs/gitattributes)
* [x] [`.gitconfig`](https://git-scm.com/docs/git-config)
* [x] [`.gitignore`](https://git-scm.com/docs/gitignore)
* [x] [`.hgignore`](https://www.mercurial-scm.org/wiki/.hgignore)
* [x] [`.inputrc`](https://goo.gl/cCvKes)
* [x] [`.mailmap`](https://git-scm.com/docs/git-check-mailmap)
* [ ] [`.mailrc`](https://www.ibm.com/support/knowledgecenter/ssw_aix_71/filesreference/mailrc.html)
* [x] [`.nanorc`](https://www.nano-editor.org/dist/v2.1/nanorc.5.html)
* [x] [`.npmrc`](https://docs.npmjs.com/files/npmrc)
* [ ] [`.tmux.conf`](https://wiki.archlinux.org/index.php/tmux#Configuration)
* [x] [`.wgetrc`](https://goo.gl/KRoNsn)
* [x] [Checksum lists](https://en.wikipedia.org/wiki/sha1sum)
* [x] [`CODEOWNERS`](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/about-code-owners)
* [x] [Coccinelle/SmPL](http://coccinelle.lip6.fr/docs/index.html)
* [ ] [Connection Control Language](https://en.wikipedia.org/wiki/Softmodem "/Library/Modem Scripts/*.ccl")
* [x] [DirectX 3D File](https://bit.ly/2VVCfff)
* [x] [`dosbox.conf`](https://www.dosbox.com/wiki/Dosbox.conf)
* [x] [Futhark](https://futhark.readthedocs.io/en/latest/language-reference.html)
* [x] [LCOV tracefiles](https://linux.die.net/man/1/geninfo)
* [ ] [LDAP schemas](https://ldap.com/understanding-ldap-schema/ "/etc/openldap/schema/*.schema")
* [ ] [LDIF / LDAP Data Interchange Format](https://openldap.org/software/man.cgi?query=LDIF "/etc/openldap/schema/openldap.ldif")
* [x] [Host databases](https://en.wikipedia.org/wiki/Hosts_(file))
* [ ] [Hunspell dictionaries](https://github.com/hunspell/hunspell/blob/master/man/hunspell.5)
* [x] [M4/Autotools](http://wolfram.schneider.org/bsd/7thEdManVol2/m4/m4.pdf)
* [x] [`man.conf`](https://man.openbsd.org/man.conf.5)
* [x] [`mocha.opts`](https://mochajs.org/#mochaopts)
* [x] [NEON](https://ne-on.org/)
* [x] [NWScript](https://en.wikipedia.org/wiki/NWScript)
* [x] [Object Data Instance Notation](https://git.io/JvetL)
* [x] [OpenBSD package manifests](https://man.openbsd.org/package.5)
* [ ] [`pf.os`](http://man.openbsd.org/pf.os)
* [x] [Record jars](http://www.catb.org/esr/writings/taoup/html/ch05s02.html#id2906931)
* [ ] [Sandbox profiles](https://github.com/malus-security/sandblaster "/usr/share/sandbox/*.sb")
* [x] [ShellCheck configs](https://github.com/koalaman/shellcheck/blob/58783ab3/shellcheck.1.md#rc-files)
* [x] [Sieve](http://sieve.info/)
* [x] [SSH configs](https://www.ssh.com/ssh/config/)
* [ ] [STEP-Files](https://en.wikipedia.org/wiki/ISO_10303-21)
* [x] [StringTemplate](https://www.stringtemplate.org/)
* [ ] [`sudoers`](https://linux.die.net/man/5/sudoers)
* [x] [SVG](https://developer.mozilla.org/en-US/docs/Web/SVG/Element)
* [x] [Tags files](https://en.wikipedia.org/wiki/Ctags#Tags_file_formats)
* [ ] [Terminfo](http://invisible-island.net/ncurses/ncurses.faq.html#which_terminfo)
* [ ] [`ttys`](http://man.openbsd.org/ttys)
* [x] [Unicode database files](https://www.unicode.org/Public/UNIDATA/)
* [x] [Unicode name-lists](http://www.unicode.org/Public/UCD/latest/ucd/NamesList.html)


[Referenced Links]:_____________________________________________________________
[1]: https://github.com/github/linguist
[2]: https://git-scm.com/downloads
