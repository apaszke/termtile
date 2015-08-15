on run argv
	set _screenSize to run script alias ((path to me as text) & "::getAvailableScreenSize.scpt")
	set _config to run script alias ((path to me as text) & "::config.scpt")

	set _marginV to marginV of _config
	set _marginH to marginH of _config
	set _terminalApp to terminalApp of _config
	set _width to width of _screenSize
	set _height to height of _screenSize

	set _directions to parseArguments(argv)
	if (count of _directions) < 1 then
		return -1
	end if

	using terms from application "Terminal"
		tell application _terminalApp
			if (count of _directions) = 1 then
				set _direction to item 1 of _directions
				if _direction = up then
					set bounds of window 0 to {0, 0, _width, _height / 2 - _marginV}
				else if _direction = down then
					set bounds of window 0 to {0, _height / 2 + _marginV, _width, _height}
				else if _direction = left then
					set bounds of window 0 to {0, 0, _width / 2 - _marginV, _height}
				else (* _direction = right *)
					set bounds of window 0 to {_width / 2 + _marginH, 0, _width, _height}
				end if
			else
				set _horizontal to horizontal of _directions
				set _vertical to vertical of _directions
				if _vertical = up and _horizontal = left then
					set bounds of window 0 to {0, 0, _width / 2 - _marginH, _height / 2 - _marginV}
				else if _vertical = up and _horizontal = right then
					set bounds of window 0 to {_width / 2 + _marginH, 0, _width, _height / 2 - _marginV}
				else if _vertical = down and _horizontal = left then
					set bounds of window 0 to {0, _height / 2 + _marginV, _width / 2 - _marginH, _height}
				else if _vertical = down and _horizontal = right then
					set bounds of window 0 to {_width / 2 + _marginH, _height / 2 + _marginV, _width, _height}
				end if
			end if
		end tell
	end using terms from
end run

on parseArguments(argv)
	if (count of argv) < 1 then
		return {}
	end if

	set _horizontal to false
	set _vertical to false

	if item 1 of argv = "up" then
		set _vertical to up
	else if item 1 of argv = "down" then
		set _vertical to down
	else if item 1 of argv = "left" then
		set _horizontal to left
	else if item 1 of argv = "right" then
		set _horizontal to right
	end if

	if (count of argv) > 1 then
		if item 2 of argv = "left" then
			set _horizontal to left
		else if item 2 of argv = "right" then
			set _horizontal to right
		end if
	end if

	if _horizontal = false and _vertical = false then
		return {}
	else if _horizontal = false then
		return {_vertical}
	else if _vertical = false then
		return {_horizontal}
	end if

	return {horizontal:_horizontal, vertical:_vertical}
end parseArguments
