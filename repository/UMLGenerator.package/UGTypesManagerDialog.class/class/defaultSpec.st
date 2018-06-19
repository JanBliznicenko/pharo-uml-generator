specs
defaultSpec
	^ SpecLayout composed
		newRow: [ :row | 
			row
				newColumn: [ :col | col add: #accessesModel ];
				newColumn: [ :col | col add: #optionsList ] width: 250;
				newColumn: [ :col | 
					col
						newRow: [ :row2 | row2 add: #hierarchyList ];
						newRow: [ :row2 | row2 add: #typeField ] height: 24 ]
					width: 250 ]