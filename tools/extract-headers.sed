#!/usr/bin/sed -nf

1! { /^--*/ q; }
/^Example:$/ {
	:a
	N
	/^ *- \{1,\}/ {
		d
		ba
	}
	/\n *- \{1,\}/ {
		s/\n *- *\(..*\)/ \1\n/
		:b
		/\n *- \{1,\}/ {
			d
			N
			bb
		}
	}
}
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
