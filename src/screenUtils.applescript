global _cache
set _cache to {}

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

	tell application "System Events"
		tell dock preferences
			set _autohide to autohide
		end tell
	end tell

	set _aspath to ((path to me as text) & "::getScreenInfo")
	set _utilpath to POSIX path of _aspath

	set _lines to paragraphs of (do shell script _utilpath)
	set _dockHeight to word 1 of (item 2 of _lines) as number
	set _dockScreen to word 2 of (item 2 of _lines) as number

	set _screens to {}

	set _linesOffset to 3
	repeat (item 1 of _lines as number) times
		set _screenIndex to _linesOffset - 2
		set _screenInfo to split(item _linesOffset of _lines, " ")
		set _originX to item 1 of _screenInfo as integer
		set _originY to item 2 of _screenInfo as integer
		set _width to item 3 of _screenInfo as integer
		set _height to item 4 of _screenInfo as integer
		(* HANDLE DOCK *)
		(* TODO: RETHINK *)
		if _dockScreen = _screenIndex then
			set _height to _height - _dockHeight
		end if
		(* END HANDLING DOCK *)
		set _screens to _screens & {{screenIndex:_screenIndex, originX:_originX, originY:_originY, width:_width, height:_height}}
		set _linesOffset to _linesOffset + 1
	end repeat

	set _result to {dock:{autohide:_autohide, height:_dockHeight, screenIndex:_dockScreen}, screens:_screens}
	set _cache to _cache & {getAllScreens:_result}

	return _result
end getAllScreens

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
		set _alertResponse to display alert "Something wierd happened. " message "Your window appears to be entirely off screen. Please post an issue on GitHub attaching a screenshot and a brief description." as critical buttons {"Go to GitHub", "Never mind"} default button "Go to GitHub"
		if button returned of _alertResponse = "Go to Github" then
			tell application "Safari" to open location "https://github.com/apaszke/termtile/issues"
		end if
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
