#!/bin/sh
set -e

# Terminate with an error message
die()(printf >&2 '%s\n' "$1"; exit 2)


# Sanity checks
root=`realpath "${0%/*}/.."`
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
	unset long short arg vars
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
	
	type=`printf '%s\n' "$arg" | sed -n '
		# Normalise input
		s/[-@[:blank:]]//g
		/^$/ { s/^/no_parameter/p; q; }
		
		# Filename-type argument
		s/^data[|\/]\(..*\)/\1/
		s/^directory$/dir/
		s/^filename$/file/
		s/^filepath/file/
		s/^dirname$/dir/
		s/^dirpath/dir/
		s/^pathname/path/
		s/^data$//; s/^path$//; s/^file$//; s/^dir$//
		/^$/ { s/^/filename/p; q; }
		
		# URLs
		s/^\(ur[li]\)s/\1/
		s/^\(address\)es/\1/
		s/^uri$/url/
		s/^address$/url/
		s/^url$//
		/^$/ { s/^/urls/p; q; }
		
		# Header(s)
		s/^header\(s\)\{0,1\}\(\/@[^[:blank:]]*\)\{0,1\}/header/
		s/^header$//
		/^@/ { s/^/headers/p; q; }
	'`
	
	[ -z "$short" ] || {
		short="-$short`printf '\xC2\xA0'`"
		[ "$arg" ] || short="${short#*t}"
	}
	[ -z "$long"  ] || long="--$long"
	printf '%s\t%s\t%s\t# %s\n' "$short" "$long" "$arg" "$type" >> "$list"
done
