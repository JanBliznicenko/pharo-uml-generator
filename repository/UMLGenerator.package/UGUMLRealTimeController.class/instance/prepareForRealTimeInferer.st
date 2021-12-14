uml - generation
prepareForRealTimeInferer
	"This file has to be deleted otherwise the interferers won't be started."
	self class typeInfo asFileReference deleteIfAbsent: [ "Do nothing" ].
	"Remove links from previous realtime interferer usage."
	self clearAfterRealTimeInferer.
	"adds metalinks (starts logging types)"
	UGRealTimeTyper default addLinksToPackageNamed: analyzedPackage.