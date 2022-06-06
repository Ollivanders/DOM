#!/usr/bin/env osascript

tell application id "com.apple.systempreferences"
	reveal pane id "com.apple.preference.keyboard"
end tell

tell application "System Events"
	tell process "System Preferences"
		set currentState to value of attribute "AXValue" of pop up button 2 of tab group 1 of window "Keyboard"
		if currentState is "Expanded Control Strip" then
			set newState to "App Controls with Control Strip"
			tell pop up button 2 of tab group 1 of window "Keyboard"
				perform action "AXShowMenu"
				tell menu 1
					click menu item newState
				end tell
			end tell
		else if currentState is "App Controls with Control Strip" then
			set newState to "F1, F2, etc. Keys"
			tell pop up button 2 of tab group 1 of window "Keyboard"
				perform action "AXShowMenu"
				tell menu 1
					click menu item newState
				end tell
			end tell
		else if currentState is "F1, F2, etc. Keys" then
			set newState to "Expanded Control Strip"
			tell pop up button 2 of tab group 1 of window "Keyboard"
				perform action "AXShowMenu"
				tell menu 1
					click menu item newState
				end tell
			end tell
		end if
	end tell
end tell

quit application "System Preferences"