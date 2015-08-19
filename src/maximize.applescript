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
		-- ignoring originY because window stays on the same screen...
		set bounds of window 0 to {originX of _screen, 0, (originX of _screen) + (width of _screen), height of _screen}
	end tell
end using terms from
