tell application "Finder"
	set _b to bounds of window of desktop
	set _width to item 3 of _b
	set _height to item 4 of _b
end tell

set _dockWidth to 0
set _dockHeight to 0
tell application "System Events"
	tell dock preferences
		set _autohide to autohide
		set _screenEdge to screen edge
		
		if not _autohide then
			if _screenEdge is bottom then
				set _dockHeight to 90
			else
				set _dockWidth to 90
			end if
		end if
	end tell
end tell

set _width to _width - _dockWidth
set _height to _height - _dockHeight

return {width:_width, height:_height}
