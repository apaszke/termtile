set _config to run script alias ((path to me as text) & "::config.scpt")

set _terminalApp to terminalApp of _config

if (offset of "iTerm" in _terminalApp) is not 0 then
	-- key code 36 is the return key
	tell application "System Events" to key code 36 using command down
else
	tell application "System Events" to keystroke "f" using {command down, control down}
end if
