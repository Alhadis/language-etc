<div>  <\n>
$! <multi-valued-attribute; separator=expr> !$

$[foo, bar]$
$template(argument-list)$

$(expr)(argument-list)$
$attribute:template(argument-list)$

$attribute:(expr)(argument-list)$
$[]$
$attribute:t1(argument-list): ... :tN(argument-list)$
$attribute:{x | anonymous-template}$
$a1,a2,...,aN:{argument-list | anonymous-template}$
$attribute:t1(), t2(),...,tN()$
\< or \> xor \$
$\ $, $\n$, $\t$, $\r$
$\uFEFF$
$\\$
$! comment !$
$attr.(expr)$

$names,phones:{ n,p | $n$: $p$}$
$["a","b"]:{v | $v$=$i$;}$


$if(boolexpr1)$          subtemplate
$elseif(A || boolexpr2)$ subtemplate2
...
$elseif(boolexprN)$ subtemplateN
$else$              defaultsubtemplate
$endif$

$method(name="f", body={x=1;}, cleanup={printf("leaving <name>");})$

$first(attr)$	The first or only element of attr. You can combine operations to say things like first(rest(names)) to get second element.
$length(attr)$	Return the length of a mult-valued attribute or 1 if it is single attribute. If attribute is null return 0. Strings are not special; i.e., length("foo") is 1 meaning "1 attribute". Nulls are counted in lists so a list of 300 nulls is length 300. If you don't want to count nulls, use length(strip(list)).
$strlen(attr)$	Return the length of a string attribute; runtime error if not string.
$last(attr)$	The last or only element of attr.
$rest(attr)$	All but the first element of attr. Returns nothing if is single valued.
$reverse(attr)$	Return a list with the same elements as v but in reverse order. null values are NOT stripped out. Use reverse(strip(v)) to do that.
$trunc(attr)$	Returns all elements but last element.
$strip(attr)$	Return a new list w/o null values.
$trim(attr)$	Trim whitespace from back/front of a string; runtime error if not string.
