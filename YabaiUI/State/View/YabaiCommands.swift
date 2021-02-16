//
//  YabaiCommands.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/16/21.
//

import Foundation

/*------------------------------------------------------------------------------------------
 YABAI ascii documentation:
 ------------------------------------------------------------------------------------------
 - Section  6.1     - configuring Yabai.
 - Sections 6.2-6.7 - configuring actions to Yabai.

 https://github.com/koekeishiya/yabai/blob/master/doc/yabai.asciidoc#config
 ------------------------------------------------------------------------------------------*/

//MARK:- 6.2 Display
//
//6.2.1. General Syntax
//
//yabai -m display [<DISPLAY_SEL>] <COMMAND>
//
//6.2.2. COMMAND
//
//--focus <DISPLAY_SEL>
//Focus the given display.


//MARK:- 6.3. Space
//
//6.3.1. General Syntax
//
//yabai -m space [<SPACE_SEL>] <COMMAND>
//
//6.3.2. COMMAND
//
//--focus <SPACE_SEL>
//Focus the given space.
//
//--create
//Create a new space on the display of the selected space.
//
//--destroy
//Remove the selected space.
//
//--move <SPACE_SEL>
//Move position of the selected space to the position of the given space.
//The selected space and given space must both belong to the same display.
//
//--swap <SPACE_SEL>
//Swap the selected space with the given space.
//The selected space and given space must both belong to the same display.
//
//--display <DISPLAY_SEL>
//Send the selected space to the given display.
//
//--balance
//Adjust the split ratios of the selected space so that all windows occupy the same area.
//
//--mirror x-axis|y-axis
//Flip the tree of the selected space.
//
//--rotate 90|180|270
//Rotate the tree of the selected space.
//
//--padding abs|rel:<top>:<bottom>:<left>:<right>
//Padding added at the sides of the selected space.
//
//--gap abs|rel:<gap>
//Size of the gap that separates windows on the selected space.
//
//--toggle padding|gap|mission-control|show-desktop
//Toggle space setting on or off for the selected space.
//
//--layout bsp|stack|float
//Set the layout of the selected space.
//
//--label [<LABEL>]
//Label the selected space, allowing that label to be used as an alias in commands that take a SPACE_SEL parameter.
//If the command is called without an argument it will try to remove a previously assigned label.


//MARK:- 6.4. Window
//
//6.4.1. General Syntax
//
//yabai -m window [<WINDOW_SEL>] <COMMAND>
//
//6.4.2. COMMAND
//
//--focus <WINDOW_SEL>
//Focus the given window.
//
//--swap <WINDOW_SEL>
//Swap position of the selected window and the given window.
//
//--warp <WINDOW_SEL>
//Re-insert the selected window, splitting the given window.
//
//--stack <WINDOW_SEL>
//Stack the given window on top of the selected window.
//Any kind of warp operation performed on a stacked window will unstack it.
//
//--insert <DIR_SEL>|stack
//Set the splitting mode of the selected window.
//If the current splitting mode matches the selected mode, the action will be undone.
//
//--grid <rows>:<cols>:<start-x>:<start-y>:<width>:<height>
//Set the frame of the selected window based on a self-defined grid.
//
//--move abs|rel:<dx>:<dy>
//If type is rel the selected window is moved by dx pixels horizontally and dy pixels vertically, otherwise dx and dy will become its new position.
//
//--resize top|left|bottom|right|top_left|top_right|bottom_right|bottom_left|abs:<dx>:<dy>
//Resize the selected window by moving the given handle dx pixels horizontally and dy pixels vertically. If handle is abs the new size will be dx width and dy height and cannot be used on managed windows.
//
//--ratio rel|abs:<dr>
//If type is rel the split ratio of the selected window is changed by dr, otherwise dr will become the new split ratio. A positive/negative delta will increase/decrease the size of the left-child.
//
//--toggle float|sticky|topmost|pip|shadow|border|split|zoom-parent|zoom-fullscreen|native-fullscreen|expose
//Toggle the given property of the selected window.
//
//--layer <LAYER>
//Set the stacking layer of the selected window.
//
//--opacity <floating point number>
//Set the opacity of the selected window. The window will no longer be eligible for automatic change in opacity upon focus change.
//Specify the value 0.0 to reset back to full opacity OR have it be automatically managed through focus changes.
//
//--display <DISPLAY_SEL>
//Send the selected window to the given display.
//
//--space <SPACE_SEL>
//Send the selected window to the given space.
//
//--minimize
//Minimizes the selected window. Only works on windows that provide a minimize button in its titlebar.
//
//--deminimize
//Restores the selected window, if it is minimized. The window will only get focus if the owning application has focus.
//Note that you can also --focus a minimized window to restore it as the focused window.
//
//--close
//Closes the selected window. Only works on windows that provide a close button in its titlebar.


//MARK:- 6.5. Query
//
//6.5.1. General Syntax
//
//yabai -m query <COMMAND> [<ARGUMENT>]
//
//6.5.2. COMMAND

//--displays
//Retrieve information about displays.
//
//--spaces
//Retrieve information about spaces.
//
//--windows
//Retrieve information about windows.
//
//6.5.3. ARGUMENT
//
//--display [<DISPLAY_SEL>]
//Constrain matches to the selected display.
//
//--space [<SPACE_SEL>]
//Constrain matches to the selected space.
//
//--window [<WINDOW_SEL>]
//Constrain matches to the selected window.


//MARK:- 6.6. Rule
//
//All registered rules that match the given filter will apply to a window in the order they were added.
//If multiple rules specify a value for the same argument, the latter rule will override that value as it was applied last.
//
//6.6.1. General Syntax
//
//yabai -m rule <COMMAND>
//
//6.6.2. COMMAND
//
//--add [<ARGUMENT>]
//Add a new rule.
//
//--remove <RULE_SEL>
//Remove an existing rule with the given index or label.
//
//--list
//Output list of registered rules.
//
//6.6.3. ARGUMENT
//
//label=<LABEL>
//Label used to identify the rule with a unique name
//
//app[!]=<REGEX>
//Name of application. If ! is present, invert the match.
//
//title[!]=<REGEX>
//Title of window. If ! is present, invert the match.
//
//display=[^]<DISPLAY_SEL>
//Send window to display. If ^ is present, follow focus.
//
//space=[^]<SPACE_SEL>
//Send window to space. If ^ is present, follow focus.
//
//manage=<BOOL_SEL>
//Window should be managed (tile vs float).
//
//sticky=<BOOL_SEL>
//Window appears on all spaces.
//
//mouse_follows_focus=<BOOL_SEL>
//When focusing the window, put the mouse at its center. Overrides the global mouse_follows_focus setting.
//
//layer=<LAYER>
//Window is ordered within the given stacking layer.
//
//opacity=<FLOAT_SEL>
//Set window opacity. The window will no longer be eligible for automatic change in opacity upon focus change.
//
//border=<BOOL_SEL>
//Window should draw border.
//
//native-fullscreen=<BOOL_SEL>
//Window should enter native macOS fullscreen mode.
//
//grid=<rows>:<cols>:<start-x>:<start-y>:<width>:<height>
//Set window frame based on a self-defined grid.
//


//MARK:- 6.7. Signal
//
//A signal is a simple way for the user to react to some event that has been processed.
//Arguments are passed through environment variables.
//
//6.7.1. General Syntax
//
//yabai -m signal <COMMAND>
//
//6.7.2. COMMAND
//
//--add event=<EVENT> action=<ACTION> [label=<LABEL>] [app[!]=<REGEX>] [title[!]=<REGEX>]
//Add an optionally labelled signal to execute an action after processing an event of the given type.
//Some signals can be specified to trigger based on the application name and/or window title.
//
//--remove <SIGNAL_SEL>
//Remove an existing signal with the given index or label.
//
//--list
//Output list of registered signals.
//
//6.7.3. EVENT
//
//application_launched
//Triggered when a new application is launched.
//Eligible for app filter.
//Passes one argument: $YABAI_PROCESS_ID
//
//application_terminated
//Triggered when an application is terminated.
//Eligible for app filter.
//Passes one argument: $YABAI_PROCESS_ID
//
//application_front_switched
//Triggered when the front-most application changes.
//Passes two arguments: $YABAI_PROCESS_ID, $YABAI_RECENT_PROCESS_ID
//
//application_activated
//Triggered when an application is activated.
//Eligible for app filter.
//Passes one argument: $YABAI_PROCESS_ID
//
//application_deactivated
//Triggered when an application is deactivated.
//Eligible for app filter.
//Passes one argument: $YABAI_PROCESS_ID
//
//application_visible
//Triggered when an application is unhidden.
//Eligible for app filter.
//Passes one argument: $YABAI_PROCESS_ID
//
//application_hidden
//Triggered when an application is hidden.
//Eligible for app filter.
//Passes one argument: $YABAI_PROCESS_ID
//
//window_created
//Triggered when a window is created.
//Eligible for both app and title filter.
//Passes one argument: $YABAI_WINDOW_ID
//
//window_destroyed
//Triggered when a window is destroyed.
//Passes one argument: $YABAI_WINDOW_ID
//
//window_focused
//Triggered when a window becomes the key-window for its application.
//Eligible for both app and title filter.
//Passes one argument: $YABAI_WINDOW_ID
//
//window_moved
//Triggered when a window changes position.
//Eligible for both app and title filter.
//Passes one argument: $YABAI_WINDOW_ID
//
//window_resized
//Triggered when a window changes dimensions.
//Eligible for both app and title filter.
//Passes one argument: $YABAI_WINDOW_ID
//
//window_minimized
//Triggered when a window has been minimized.
//Eligible for both app and title filter.
//Passes one argument: $YABAI_WINDOW_ID
//
//window_deminimized
//Triggered when a window has been deminimized.
//Eligible for both app and title filter.
//Passes one argument: $YABAI_WINDOW_ID
//
//window_title_changed
//Triggered when a window changes its title.
//Eligible for both app and title filter.
//Passes one argument: $YABAI_WINDOW_ID
//
//space_changed
//Triggered when the active space has changed.
//Passes two arguments: $YABAI_SPACE_ID, $YABAI_RECENT_SPACE_ID
//
//display_added
//Triggered when a new display has been added.
//Passes one argument: $YABAI_DISPLAY_ID
//
//display_removed
//Triggered when a display has been removed.
//Passes one argument: $YABAI_DISPLAY_ID
//
//display_moved
//Triggered when a change has been made to display arrangement.
//Passes one argument: $YABAI_DISPLAY_ID
//
//display_resized
//Triggered when a display has changed resolution.
//Passes one argument: $YABAI_DISPLAY_ID
//
//display_changed
//Triggered when the active display has changed.
//Passes two arguments: $YABAI_DISPLAY_ID, $YABAI_RECENT_DISPLAY_ID
//
//mouse_down
//Triggered when a mouse button has been pressed.
//Passes two arguments: $YABAI_BUTTON, $YABAI_POINT
//
//mouse_up
//Triggered when a mouse button has been released.
//Passes two arguments: $YABAI_BUTTON, $YABAI_POINT
//
//mouse_dragged
//Triggered when the mouse is moved with one of its buttons pressed.
//Passes two arguments: $YABAI_BUTTON, $YABAI_POINT
//
//mouse_moved
//Triggered when the mouse is moved.
//Passes two arguments: $YABAI_BUTTON, $YABAI_POINT
//
//mission_control_enter
//Triggered when mission-control activates.
//
//mission_control_check_for_exit
//Triggered periodically while mission-control is active.
//
//mission_control_exit
//Triggered when mission-control deactivates.
//
//dock_did_restart
//Triggered when Dock.app restarts.
//
//menu_opened
//Triggered when a menu is opened.
//
//menu_bar_hidden_changed
//Triggered when the macOS menubar autohide setting changes.
//
//dock_did_change_pref
//Triggered when the macOS Dock preferences changes.
//
//system_woke
//Triggered when macOS wakes from sleep.
//
//daemon_message
//Triggered when yabai receives a message on its socket.
//
//6.7.4. ACTION
//
//Arbitrary command executed through /usr/bin/env sh -c
