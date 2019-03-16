accessing
method1
	| x |
	x := (40 + 50) asString , ' of something'.
	Transcript
		show: x;
		cr.
	^ x reversed