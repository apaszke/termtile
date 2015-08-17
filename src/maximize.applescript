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
log _screen

using terms from application "Terminal"
	tell application _terminalApp
		-- ignoring originY because window stays the same...
		set bounds of window 0 to {originX of _screen, 0, (originX of _screen) + (width of _screen), height of _screen}
	end tell
end using terms from
