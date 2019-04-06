constants
newDefaultTyper
	^ UGTyperMergeCombinator
		withAdaptors:
			{UGRBTyperAdaptor.
			UGRoelTyperAdaptor}