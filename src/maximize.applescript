set _screenSize to run script alias ((path to me as text) & "::getAvailableScreenSize.scpt")
set _config to run script alias ((path to me as text) & "::config.scpt")
set _terminalApp to terminalApp of _config

set _width to width of _screenSize
set _height to height of _screenSize

using terms from application "Terminal"
	tell application _terminalApp
		set bounds of window 0 to {0, 0, _width, _height}
	end tell
end using terms from
