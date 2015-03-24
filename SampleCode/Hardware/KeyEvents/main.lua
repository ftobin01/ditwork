-- Project: KeyEvents
--
-- File name: main.lua
--
-- Author: Corona Labs
--
-- Abstract:	Demonstrates how to handle key events.
--
-- Demonstrates: 
--
-- File dependencies: build.settings
--
-- Target devices: Android (no Simulator or iOS)
--
-- Update History:
--	9/09/2013	1.2		Added support for Windows. Modified key event handler.
--	7/14/2011	1.1		Added "volumeUp" exception code / removed splash screen
--	7/12/2011	1.0		Initial version
--
-- Sample code is MIT licensed, see http://www.coronalabs.com/links/code/license
-- Copyright (C) 2011 Corona Labs Inc. All Rights Reserved.
--
-- Supports Graphics 2.0
---------------------------------------------------------------------------------------

local centerX = display.contentCenterX
local centerY = display.contentCenterY
local _W = display.contentWidth
local _H = display.contentHeight

display.setDefault( "background", 80/255 )

-- Create a title message at the top of the screen.
--
local title = display.newText( "Press a key or button", centerX, 40, nil, 20 )

-- Create a text label at the center of the screen for display key event info.
--
local textOptions =
{
	text = "Waiting for key event...",
	x = centerX,
	y = centerY,
	fontSize = 20,
	align = "center",
}
local eventTxt = display.newText( textOptions )

-- Check that we are running on Android or Windows
--
local platformName = system.getInfo("platformName")
if "Android" ~= platformName and "Win" ~= platformName then
	eventTxt.text = "Build for Android Device!"
end

-- The Key Event Listener
--
local function onKeyEvent( event )
	-- Print which key was pressed down/up to the log.
	local message = "'" .. event.keyName .. "' is " .. event.phase
	print( message )

	-- Display the key event's information onscreen.
	if event.device then
		message = event.device.displayName .. "\n" .. message
	end
	eventTxt.text = message

	-- If the "back" key was pressed on Android, then prevent it from backing out of the app.
	-- We do this by returning true, telling the operating system that we are overriding the key.
	if (event.keyName == "back") and (platformName == "Android") then
		return true
	end

	-- Return false to indicate that this app is *not* overriding the received key.
	-- This lets the operating system execute its default handling of this key.
	return false
end

-- Add the key callback
Runtime:addEventListener( "key", onKeyEvent );

