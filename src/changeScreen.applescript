on run argv
	global _cache
	set _cache to {}

	set ScreenUtils to load script alias ((path to me as text) & "::screenUtils.scpt")
	set _config to run script alias ((path to me as text) & "::config.scpt")

	set _terminalApp to terminalApp of _config

	tell ScreenUtils to set _screens to (screens of getAllScreens())
	if (count of _screens) < 2 then
		return
	end if

	try
		tell ScreenUtils to set _currentScreen to getScreenWithFrontmostWindowOfApp(_terminalApp)
	on error
		return
	end try

	using terms from application "Terminal"
		tell application _terminalApp
			if true then --(item 1 of argv) = "next" then
				tell me to set _newScreen to getNextScreen(_screens, _currentScreen)
				set _bounds to bounds of window 0
				set _windowWidth to (item 3 of _bounds) - (item 1 of _bounds)
				set _windowHeight to (item 4 of _bounds) - (item 2 of _bounds)
				if _windowHeight > height of _newScreen then
					set _windowHeight to height of _newScreen
				end if
				if _windowWidth > width of _newScreen then
					set _windowWidth to width of _newScreen
				end if

				-- Terminal handles the originY in a kind of relative way
				if _terminalApp = "Terminal" then
					set originY of _newScreen to (originY of _newScreen - originY of _currentScreen)
				end if

				set bounds of window 0 to {originX of _newScreen, originY of _newScreen, (originX of _newScreen) + _windowWidth, (originY of _newScreen) + _windowHeight}
			end if
		end tell
	end using terms from
end run

on getNextScreen(_screens, _currentScreen)
	set _nextIndex to ((screenIndex of _currentScreen) + 1)
	if _nextIndex > (count of _screens) then
		set _nextIndex to 1
	end if
	return item _nextIndex of _screens
end getNextScreen
