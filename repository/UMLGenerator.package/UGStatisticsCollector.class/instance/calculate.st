converting
calculate
	{(#roel -> UGRoelTyperAdaptor new).
	(#rb -> UGRBTyperAdaptor new).
	(#j2 -> UGJ2InfererTyperAdaptor new).
	(#realtime -> UGRealTimeTyperAdaptor new).
	(#combined
		->
			(UGTyperBackupsCombinator
				withAdaptors:
					{UGRealTimeTyperAdaptor new.
					UGRoelTyperAdaptor new.
					UGRBTyperAdaptor new.
					UGJ2InfererTyperAdaptor new}))}
		do: [ :pair | self calculateTyper: pair value named: pair key ]