#!/usr/bin/sed -nf

#
# wrangle-tor-options.sed: Wrangle the AsciiDoc source that the Tor project
# uses to document each `torrc` directive in detail. This approach is messy,
# but trying to parse Asciidoctor's HTML or DocBook output is much messier.
#

# Delete everything up to and including the “#conf-format” anchor
1, /^\[\[conf-format\]\]/d

# Strip anchors embedded in each option section’s heading
s/^\[\[[^[:space:]]\{1,\}\]\]  *\(.*::$\)/\1/

# Now the mess begins
/^\(\*\*[^[:space:]#]\{1,\}\*\*\)[[:space:]]\{1,\}\(.*\)::$/ {
	# Separate name and arguments by cut(1)-friendly delimiter
	s//\2	\1/
	
	# Ad-hoc fixes for errors in upstream document
	/OverloadStatistics/ {
		s/^\*0\*\*[|]/**0**|/g
		s/ \*0\*\*[|]/ **0**|/g
	}
	s/\['address'/[__address__/g
	s/ __ \(fingerprint__\)/ __\1/
	s/ socks4[|]socks5 / **socks4**|**socks5** /g
	s/ exec / **exec** /g
	s/\[options\]/[__options__]/g
	s/\([ []\)\(orport=\)/\1**\2**/g
	s/\([ []\)\(weight=\)/\1**\2**/g
	s/\([ []\)\(ipv6=\)/\1**\2**/g
	s/\([ []\)\(id=\)/\1**\2**/g
	s/\([][]\)\([-:\/]\)/\1**\2**/g
	s/\*\* \* \*\*/**\&ast;**/g
	
	# Trim fields of leading and trailing spaces
	s/ *	 */	/g;
	
	# Highlight italic (variable/placeholder) text
	s/__\(\([^_|]*_[^_|]\)*[^_|]*\)__/<var>\1<\/var>/g
	s/_\([^_|]\{1,\}\)_/<var>\1<\/var>/g

	# Highlight bold (literal) text
	s/\*\*\*\*//g
	s/\*\*\(\([^*|]*\*[^*|]\)*[^*|]*\)\*\*/<samp>\1<\/samp>/g

	# Escape literal square brackets
	:a
	/\(<samp>[^<>]*\)\[\([^<>]*<\/samp>\)/ {
		s//\1\&lbrack;\2/
		ta
	}
	/\(<samp>[^<>]*\)\]\([^<>]*<\/samp>\)/ {
		s//\1\&rbrack;\2/
		ta
	}

	# Highlight optional argument groups
	:b
	/\[\([^][]*\)\]/ {
		s//<optional>\1<\/optional>/g
		bb
	}

	# Highlight metacharacters
	s/[,|]/<sym>&<\/sym>/g
	
	# Highlight variable argument indicator
	s/\([^.]\)\.\.\.\([^.]\)/\1<sym>…<\/sym>\2/g; # A…Z
	s/\.\.\.\([^.]\)/<sym>…<\/sym>\1/g;           # …Z
	s/\([^.]\)\.\.\./\1<sym>…<\/sym>/g;           # A…
	s/\.\.\./<sym>…<\/sym>/g;                     # …

	# Expand text substitutions
	s/{dbl_}/__/g
	s/{empty}//g

	s/^\([^	]\{1,\}\)	\([^	]\{1,\}\)$/<option>\2 \1<\/option>/g
	s/^<option>\(<samp>\([^<>]*\)<\/samp>\)/<option name="\2">\1/g
	=
	p
}
/^== SIGNALS/q
/^== FILES/q
