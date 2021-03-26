let main(n: i64): vector i64 = iota n

-- Character literals
'b' 'a' 'r' ' ' ''

-- Type parameters
'b   '~b   '^b
'ba  '~ba  '^ba
'bar '~bar '^bar

-- Type bindings
type  foo       = []
type~ foo 'bar  = []t
type^ foo '~bar = []t
type  foo '^bar = []t

-- Unhighlighted
'
'bar'
