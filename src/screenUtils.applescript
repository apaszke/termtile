global _cache
set _cache to {}

property MIN_DOCK_SIZE : 10
-- for dock at the bottom
property DEFAULT_DOCK_HEIGHT : 80
-- for vertical dock
property DEFAULT_DOCK_WIDTH : 60

on split(_str, _delimiter)
	set _oldDelimiters to AppleScript's text item delimiters
	set AppleScript's text item delimiters to _delimiter
	set _arr to every text item of _str
	set AppleScript's text item delimiters to _oldDelimiters
	return _arr
end split

on getAllScreens()
	try
		set _tmp to getAllScreens of _cache
		return _tmp
	end try

	set _aspath to ((path to me as text) & "::getScreenInfo")
	set _utilpath to POSIX path of _aspath

	set _lines to paragraphs of (do shell script _utilpath)
	set _dockLeft to word 1 of (item 2 of _lines) as number
	set _dockBottom to word 2 of (item 2 of _lines) as number
	set _dockRight to word 3 of (item 2 of _lines) as number
	set _dockScreen to word 4 of (item 2 of _lines) as number

	-- getScreenInfo sometimes malfunctions
	if _dockLeft < MIN_DOCK_SIZE and _dockBottom < MIN_DOCK_SIZE and _dockRight < MIN_DOCK_SIZE then
		set _dockScreen to 0
	end if

	-- autohide will be set in handleDock (it can't append)
	set _dockInfo to {autohide:-1, offsetLeft:_dockLeft, offsetBottom:_dockBottom, offsetRight:_dockRight, screenIndex:_dockScreen}

	set _screens to {}

	set _linesOffset to 3
	repeat (item 1 of _lines as number) times
		set _screenIndex to _linesOffset - 2
		set _screenInfo to split(item _linesOffset of _lines, " ")
		set _originX to item 1 of _screenInfo as integer
		set _originY to item 2 of _screenInfo as integer
		set _width to item 3 of _screenInfo as integer
		set _height to item 4 of _screenInfo as integer
		set _currentScreen to {screenIndex:_screenIndex, originX:_originX, originY:_originY, width:_width, height:_height}

		handleDock(_currentScreen, _dockInfo)

		set _screens to _screens & {_currentScreen}
		set _linesOffset to _linesOffset + 1
	end repeat

	set _result to {dock:_dockInfo, screens:_screens}
	set _cache to _cache & {getAllScreens:_result}

	return _result
end getAllScreens

on handleDock(_screen, _dock)
	tell application "System Events"
		tell dock preferences
			set _dockAutohide to autohide
			set _dockPosition to screen edge
			-- there constants are out of scope later... thx AppleScript
			set _bottom to bottom
			set _left to left
			set _right to right
		end tell
	end tell

	set autohide of _dock to _dockAutohide

	if not _dockAutohide then
		-- if _dockScreen = 0 then the second condition is always false,
		-- but I'm leaving it for better readability
		if screenIndex of _dock > 0 and screenIndex of _dock = screenIndex of _screen then
			set height of _screen to (height of _screen) - (offsetBottom of _dock)
			set width of _screen to (width of _screen) - (offsetLeft of _dock) - (offsetRight of _dock)
			set originX of _screen to (originX of _screen) + (offsetLeft of _dock)
		end if
		(* AppleScript fallback *)
		if screenIndex of _dock = 0 then
			if _dockPosition = _bottom then
				set height of _screen to (height of _screen) - DEFAULT_DOCK_HEIGHT
				set offsetBottom of _dock to DEFAULT_DOCK_HEIGHT
			else if _dockPosition = _left then
				set originX of _screen to DEFAULT_DOCK_HEIGHT
				set width of _screen to (width of _screen) - DEFAULT_DOCK_HEIGHT
				set offsetLeft of _dock to DEFAULT_DOCK_HEIGHT
			else if _dockPosition = _right then
				set width of _screen to (width of _screen) - DEFAULT_DOCK_HEIGHT
				set offsetRight of _dock to DEFAULT_DOCK_HEIGHT
			end if
		end if
	end if
end handleDock

on getScreenWithCoordinates(_x, _y)
	set _screenInfo to getAllScreens()
	set _screens to screens of _screenInfo
	set _index to 1
	repeat (count of _screens) times
		set _screen to item _index of _screens
		if (originX of _screen) <= _x and _x < (originX of _screen) + (width of _screen) then
			if (originY of _screen) <= _y and _y < (originY of _screen) + (height of _screen) then
				return _screen
			end if
		end if
		set _index to _index + 1
	end repeat

	-- use less or equal if scrict inequalities don't return any screen
	set _index to 1
	repeat (count of _screens) times
		set _screen to item _index of _screens
		if (originX of _screen) <= _x and _x <= (originX of _screen) + (width of _screen) then
			if (originY of _screen) <= _y and _y <= (originY of _screen) + (height of _screen) then
				return _screen
			end if
		end if
		set _index to _index + 1
	end repeat

	return {}
end getScreenWithCoordinates

on getScreenWithBounds(_bounds)
	set _lx to item 1 of _bounds
	set _ly to item 2 of _bounds
	set _rx to item 3 of _bounds
	set _ry to item 4 of _bounds
	set _result to getScreenWithCoordinates(_lx, _ly)
	if _result = {} then
		set _result to getScreenWithCoordinates(_rx, _ry)
	end if

	if _result = {} then
		-- silence warning if fullscreen
		if not _ly < 20 then
			set _alertResponse to display alert "Something wierd happened. " message "Your window appears to be entirely off screen. Please post an issue on GitHub attaching a screenshot and a brief description." as critical buttons {"Go to GitHub", "Never mind"} default button "Go to GitHub"
			if button returned of _alertResponse = "Go to Github" then
				tell application "Safari" to open location "https://github.com/apaszke/termtile/issues"
			end if
		end if
		error "getScreenWithBounds: No screen found for bounds {" & _lx & ", " & _ly & ", " & _rx & ", " & _ry & "}" number 501
	end if

	return _result
end getScreenWithBounds

on getScreenWithFrontmostWindowOfApp(_appName)
	using terms from application "Terminal"
		tell application _appName
			set _bounds to bounds of window 0
		end tell
	end using terms from

	return getScreenWithBounds(_bounds)
end getScreenWithFrontmostWindowOfApp
