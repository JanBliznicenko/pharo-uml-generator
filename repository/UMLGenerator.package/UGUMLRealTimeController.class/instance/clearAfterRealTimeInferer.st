uml - generation
clearAfterRealTimeInferer
	"removes current metalinks (stops current types logging)"
	UGRealTimeTyper default uninstallLinks.
	"forces metalinks to be removed"
	UGRealTimeTyper resetDefault.
	analyzedPackage ifNotNil: [ :arg | 
		analyzedPackage asPackage classes do: #recompile ]