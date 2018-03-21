public - importer
addMethod: aMethod to: umlClass classSide: aBoolean
	| umlMethod |
	umlMethod := OPUMLOperation new.
	umlMethod name: aMethod selector.
	umlMethod isStatic: aBoolean.
	umlClass ownedOperations add: umlMethod