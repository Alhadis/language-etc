all: curlrc

# Update list of curl(1) options
curlrc: samples/lists/curlrc-options.tsv

samples/lists/curlrc-options.tsv: tools/curl/.git
	tools/update-curl-opts.sh $(^D)/docs/cmdline-opts > $@

# Checkout curl(1)'s latest revision from upstream
tools/curl:
	if test -d $@ && test -d $@/.git; \
	then git -C $@ pull; \
	else git clone --depth=1 https://github.com/curl/curl.git $@; \
	fi

tools/curl/.git: tools/curl
	touch $@
	test -d $@/../docs/cmdline-opts



# Nuke untracked files and build artefacts
clean:
	rm -rf tools/curl

.PHONY: clean
