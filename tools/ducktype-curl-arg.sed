#!/usr/bin/sed -nf

# Normalise input
s/[-@[:blank:]]//g
/^$/ { s/^/no_parameter/p; q; }

# Form-data
s/^[^=]\{1,\}=[^=]\{1,\}$/form/
s/^formstring$/form/
s/^telnetoption$/form/
/^form$/ { s//form_data/p; q; }

# MD5 checksum
s/^md5hash$/md5/
s/^md5sum$/md5/
/^md5$/ { p; q; }

# Protocol(s)
/^protocols*$/ { s//protocols/p; q; }

# Range
s/^num\/range$//
s/^byterange$//
s/^range$//
/^$/ { s/^/range/p; q; }

# Generic/untyped string
s/^data[|\/]\(..*\)/\1/
s/^algorithm\(list\)\{1,\}$/str/
s/^cipher\(list\)\{1,\}$/str/
s/^listofciphers$/str/
s/^directory$/dir/
s/^filename$/file/
s/^filepath/file/
s/^dirname$/dir/
s/^dirpath/dir/
s/^name$/str/
s/^user$/str/
s/^pathname/path/
s/^data$//; s/^path$//; s/^file$//; s/^dir$//
s/^string$//; s/^str$//
/^$/ { s/^/string/p; q; }

# Numeric argument
s/^max\(.\)/\1/
s/^min\(.\)/\1/
s/^fractional\(.\)/\1/
s/^\(connect\)\{0,1\}timeout$/num/
s/^bytes$/num/
s/^count$/num/
s/^filesize$/num/
s/^seconds$/num/
s/^minutes$/num/
s/^number$/num/
s/^offset$/num/
s/^redirs$/num/
s/delay$/num/
s/speed$/num/
s/requestrate$/num/
s/rate$/num/
s/time$/num/
s/size$/num/
/^num$/ { s/$/eric/p; q; }

# Colon-delimited values
s/^[^:]\{1,\}\(:[^:]\{1,\}\)\{1,\}$/kv_colon/
/^kv_colon$/ { p; q; }

# URLs
s/^noproxy\(list\)\{0,1\}$/url/
s/^\(ur[li]\)s/\1/
s/^\(address\)es/\1/
s/^uri$/url/
s/^address$/url/
s/^url$//
/^$/ { s/^/urls/p; q; }

# Header(s)
s/^proxyheaders*$/header/
s/^header\(s\)\{0,1\}\(\/.*\)\{0,1\}$/header/
s/^header$//
/^$/ { s/^/headers/p; q; }

# Assume anything else is a string
s/.*/string/p; q
