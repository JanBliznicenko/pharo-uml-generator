persistence
loadFromFile: aFileName
	persistence := UGTypesFilePersistence fileName: aFileName.
	knownTypes := persistence loadTypes