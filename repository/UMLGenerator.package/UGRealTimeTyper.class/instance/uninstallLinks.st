api
uninstallLinks
	self links do: #uninstall.
	links := OrderedCollection new.
	linkedPackages := Set new.