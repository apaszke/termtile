on run argv
	set _config to run script alias ((path to me as text) & "::config.scpt")
	set _terminalApp to terminalApp of _config

	set _width to 1000
	set _height to 600

	if count of argv >= 2 then
		set _width to item 1 of argv
		set _height to item 2 of argv
	end if

	using terms from application "Terminal"
		tell application _terminalApp
			set size of window 0 to {_width, _height}
		end tell
	end using terms from
end run
