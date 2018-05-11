private
createRawTypeDictionaryWith: aCollectBlock
	^ packages
		flatCollect: [ :eachPackage | 
			eachPackage classes , (eachPackage classes collect: #class)
				flatCollect: aCollectBlock
				as: Dictionary ]
		as: Dictionary