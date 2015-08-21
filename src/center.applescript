on run argv
	global _cache
	set _cache to {}

	set ScreenUtils to load script alias ((path to me as text) & "::screenUtils.scpt")
	set _config to run script alias ((path to me as text) & "::config.scpt")

	set _terminalApp to terminalApp of _config

	try
		tell ScreenUtils to set _screen to getScreenWithFrontmostWindowOfApp(_terminalApp)
	on error
		return
	end try

	using terms from application "Terminal"
		tell application _terminalApp
			-- Terminal is kind of wierd
			if _terminalApp = "Terminal"
				set originY of _screen to 23
			end if

			set _bounds to bounds of window 0
			set _windowWidth to (item 3 of _bounds) - (item 1 of _bounds)
			set _windowHeight to (item 4 of _bounds) - (item 2 of _bounds)
			set _upperW to (originX of _screen) + ((width of _screen) - _windowWidth) / 2
			set _upperH to (originY of _screen) + ((height of _screen) - _windowHeight) / 2
			set _lowerW to _upperW + _windowWidth
			set _lowerH to _upperH + _windowHeight
			set bounds of window 0 to {_upperW, _upperH, _lowerW, _lowerH}
		end tell
	end using terms from
end run
