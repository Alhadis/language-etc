loop_
	_atomic_name
		loop_
			_level_scheme
			_level_energy
				loop_
					_function_exponent
					_function_coefficient
	hydrogen
		"(2) -> [2]"   -0.485813
			1.3324838E+01    1.0
			2.0152720E-01    1.0 stop_
		"(2) -> [2]"   -0.485813
			1.3326990E+01    1.0
			2.0154600E-01    1.0 stop_
		"(2) -> [1]"   -0.485813
			1.3324800E-01    2.7440850E-01
			2.01528705-01    8.2122540E-01 stop_
		"(3) -> [2]"   -0.496979
			4.5018000E+00    1.5628500E-01
			6.8144400E-01    9.0469100E-01
			1.5139800E-01    1.0000000E+01 stop_
		stop_

data_example
save_phenyl
	_object_class molecular_fragment
	loop_
		_atom_identity_node 
		_atom_identity_symbol
		1 C   2 C   3 C   4 C   5 C   6 C
save_

loop_ _molecular_fragments $ethyl $phenyl $methyl

global_
	_category chemistry
	_note """I have NFI what any of this data means."""

global_
	_note "Multiple "global_" blocks are permitted, à la CSS."


# Contrived examples of ref-tables
_xref1 ${"block":"molecule_B","frame": "ethyl"}$
_xref2 ${
	"block": "molecule_C",
	"frame": "methyl"
}$

_xrefs [
	${"block": synthesis, "item": "_sample.shape"}$,
	${"block": "experiment", "frame": fragment_1, "item": "_molecular.weight"}$,
	${"source": "blat.cif"}$,
	${"source": "archive/data/blat.cif"}$,
	${"source": "file:///iucr.org/CIF/archive/data/blat.cif"}$
]
