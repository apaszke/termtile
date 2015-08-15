on run argv
	set _screenSize to run script alias ((path to me as text) & "::getAvailableScreenSize.scpt")
	set _config to run script alias ((path to me as text) & "::config.scpt")
	
	set _marginV to marginV of _config
	set _marginH to marginH of _config
	set _terminalApp to terminalApp of _config
	set _screenWidth to width of _screenSize
	set _screenHeight to height of _screenSize
	
	using terms from application "Terminal"
		tell application _terminalApp
			set _b to bounds of window 0
			set _windowWidth to (item 3 of _b) - (item 1 of _b)
			set _windowHeight to (item 4 of _b) - (item 2 of _b)
			set _upperW to (_screenWidth - _windowWidth) / 2
			set _upperH to (_screenHeight - _windowHeight) / 2
			set _lowerW to (_screenWidth + _windowWidth) / 2
			set _lowerH to (_screenHeight + _windowHeight) / 2
			set bounds of window 0 to {_upperW, _upperH, _lowerW, _lowerH}
		end tell
	end using terms from
end run
