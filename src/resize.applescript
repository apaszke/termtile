on run argv
	global _cache
	set _cache to {}

	set ScreenUtils to load script alias ((path to me as text) & "::screenUtils.scpt")
	set _config to run script alias ((path to me as text) & "::config.scpt")

	set _terminalApp to terminalApp of _config

	set _width to 1000
	set _height to 600

	if count of argv >= 2 then
		set _width to item 1 of argv
		set _height to item 2 of argv
	end if

	-- check if it's not in fullscreen mode
	try
		tell ScreenUtils to set _screen to getScreenWithFrontmostWindowOfApp(_terminalApp)
	on error
		return
	end try

	using terms from application "Terminal"
		tell application _terminalApp
			set _bounds to bounds of window 0
			set _x to item 1 of _bounds
			set _y to item 2 of _bounds
			set bounds of window 0 to {_x, _y, _x + _width, _y + _height}
		end tell
	end using terms from
end run
