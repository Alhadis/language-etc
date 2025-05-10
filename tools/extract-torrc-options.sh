#!/bin/sh
set -e

#
# extract-torrc-options.sh: Read the AsciiDoc source of Tor's manual-page
# from stdin, extract the options therein using `wrangle-tor-options.sed`,
# sort the results and emit a well-formed XML document to standard output.
#
root=`realpath "${0%/*}"`
wrangler="$root/wrangle-tor-options.sed"
test -x "$wrangler"

# Convert XML result to a sorted list for terminal display
{ if [ "$1" = "--preview" ]; then
sed '
	/<option [^<>]*>/! d
	s/^[[:blank:]]*//g
	s/[[:blank:]]*$//g
	s/<option [^<>]*><samp>\([^<>]*\)<\/samp> *\(.*\)<\/option>/\2	\1/g
	s/<var>/[4;3m/g;  s/<\/var>/[24;23m/g
	s/<samp>/[1m/g;   s/<\/samp>/[22m/g
	s/<sym>/[2m/g;    s/<\/sym>/[22m/g
	s/<optional>/[2m[[22m/g
	s/<\/optional>/[2m][22m/g
	s/&ast;/*/g
	s/&lbrack;/[/g
	s/&rbrack;/]/g
' | sort -dfn
else cat; fi; } <<XML
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE torrc-options [
	<!ELEMENT torrc-options (option)*>
	<!ELEMENT option        (var|samp|sym|optional)*>
	<!ATTLIST option
		line CDATA #REQUIRED
		name CDATA #REQUIRED
	>
	<!ELEMENT optional (var|samp|sym|optional)*>
	<!ELEMENT var      (#PCDATA)>
	<!ELEMENT samp     (#PCDATA|sym)*>
	<!ELEMENT sym      (#PCDATA)>

	<!ENTITY hash "HEAD">
	<!ENTITY git  "https://gitlab.torproject.org/tpo/core/tor/">
	<!ENTITY src  "&git;-/blob/&hash;/doc/man/tor.1.txt#L">
	<!ENTITY ast    "*">
	<!ENTITY lbrack "[">
	<!ENTITY rbrack "]">
]>
<torrc-options>
`sed -nf "$wrangler" \
| paste - - \
| sed 's/^\([0-9]\{1,\}\)	<option /	<option line="\1" /g'`
</torrc-options>
XML
