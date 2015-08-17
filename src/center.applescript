on run argv
	global _cache
	set _cache to {}

	set ScreenUtils to load script alias ((path to me as text) & "::screenUtils.scpt")
	set _config to run script alias ((path to me as text) & "::config.scpt")


	set _terminalApp to terminalApp of _config

	using terms from application "Terminal"
		tell application _terminalApp
			set _bounds to bounds of window 0
		end tell
	end using terms from

	tell ScreenUtils to set _screen to getScreenWithBounds(_bounds)

	using terms from application "Terminal"
		tell application _terminalApp
			set _windowWidth to (item 3 of _bounds) - (item 1 of _bounds)
			set _windowHeight to (item 4 of _bounds) - (item 2 of _bounds)
			set _upperW to (originX of _screen) + ((width of _screen) - _windowWidth) / 2
			-- it stays on the same screen so originY has to be ignored...
			set _upperH to ((height of _screen) - _windowHeight) / 2
			set _lowerW to _upperW + _windowWidth
			set _lowerH to _upperH + _windowHeight
			set bounds of window 0 to {_upperW, _upperH, _lowerW, _lowerH}
		end tell
	end using terms from
end run
