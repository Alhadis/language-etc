#!/bin/sh
set -e

#
# update-curl-opts: Regenerate the TSV file containing every option
# defined by the local checkout of curl(1)'s Git repository.
#
# TODO: Investigate whether `curl/src/tool_getparam.c` could be
# leveraged to help ascertain type information for new options.
#

# Terminate with an error message
die()(printf >&2 '%s\n' "$1"; exit 2)


# Sanity checks
root=`realpath "${0%/*}/.."`
ducktype="$root/tools/ducktype-curl-arg.sed"
grammar="$root/grammars/curlrc.cson"
list="$root/samples/lists/curlrc-options.tsv"
[ -s "$grammar" ] || die "$0: Missing grammar file: $grammar"
[ -f "$list"    ] || die "$0: Missing options list: $list"


# Not enough arguments
[ $# -gt 0 ] || die "Usage: $0 /path/to/cmdline-opts"

# Argument isn't a directory
cd "$1" || die "$0: Not a directory: $1"


# Checkout path was passed instead of documentation directory
# shellcheck disable=SC2015
[ -d .git ] && [ -d docs/cmdline-opts ] && cd docs/cmdline-opts || :

# Declare option groups
groups='no_parameter urls headers form_data protocols port md5 byte_range kv_colon filename numeric'
for i in $groups; do
	eval "long_optlist_$i="
	eval "short_optlist_$i="
done


# Header of list
printf '# vim: ts'='42 ft=curlrc\n' > "$list"

for i in *.d; do
	unset long short arg vars type
	vars=`sed -n "
		/^--*/ q
		/^\([A-Za-z]\{1,\}\): *\(.*\)/ {
			h
			s//\2/
			x
			s//\1/
			y/[ABCDEFGHIJKLMNOPQRSTUVWXYZ]/[abcdefghijklmnopqrstuvwxyz]/
			s/: *//
			s/$/='/
			x
			s/^<\(.*\)>$/\1/
			s/'/'\x5C\x5C''/g
			s/$/';/
			s/\n//
			G
			s/^\(.*\)\n\(.*\)/\2\1/
			p
		}
	" "$i"`
	eval "$vars"
	
	if [ "$arg" ]; then
		arg=`printf %s "$arg" | sed '
			s/^[[:blank:]]\{1,\}//
			s/[[:blank:]]\{1,\}$//
			s/[[:blank:]]\{1,\}/-/g
		' | tr '[A-Z]' '[a-z]'`
	fi
	
	case $long in
		create-file-mode|tftp-blksize) type=numeric;;
		ftp-port) type=port;;
		cookie) type=form_data;;
		*) type=`printf '%s\n' "$arg" | sed -nf "$ducktype"`
	esac
	
	[ -z "$short" ] || {
		short="-$short`printf '\xC2\xA0'`"
		[ "$arg" ] || short="${short#*t}"
	}
	[ -z "$long"  ] || long="--$long"
	printf '%s\t%s\t%s\t# %s\n' "$short" "$long" "$arg" "$type" >> "$list"
done
