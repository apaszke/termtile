set _config to run script alias ((path to me as text) & "::config.scpt")
set _terminalApp to terminalApp of _config

using terms from application "Terminal"
	tell application _terminalApp
		set size of window 0 to {1000, 600}
	end tell
end using terms from
