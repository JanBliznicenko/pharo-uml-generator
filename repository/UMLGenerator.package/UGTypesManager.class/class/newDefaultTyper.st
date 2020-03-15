constants
newDefaultTyper
	^ UGTyperMergeCombinator
		withAdaptors:
			{UGRBTyperAdaptor new.
			UGRoelTyperAdaptor new}