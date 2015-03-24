-- Project: EventSound
--
-- Date: August 19, 2010
--
-- Version: 1.1
--
-- File name: main.lua
--
-- Author: Corona Labs
--
-- Abstract: Simulates a metronome that beeps every second
--
-- Demonstrates: media.playEventSound, switching formats based on device type
--
-- File dependencies: none
--
-- Target devices: Simulator and Device
--
-- Limitations:
--
-- Update History:
--	v1.1
--		Detects Android device and switches to MP3 sound file (from CAF)
--
-- Comments: CAF file for IOS device; MP3 for Android devices
--
-- Sample code is MIT licensed, see http://www.coronalabs.com/links/code/license
-- Copyright (C) 2010 Corona Labs Inc. All Rights Reserved.
--
-- Supports Graphics 2.0
---------------------------------------------------------------------------------------

local centerX = display.contentCenterX
local centerY = display.contentCenterY
local _W = display.contentWidth
local _H = display.contentHeight

-- Forward references
local soundID
	
-- Determine the platform type
-- "iPhoneOS" or "Android" or "Mac OS X"
--
local isAndroid = "Android" == system.getInfo("platformName")
local isSimulator = "simulator" == system.getInfo("environment")

-- Preload the sound file (needed for Android)
--
if isAndroid or isSimulator then
--	print("MP3")
	soundID = media.newEventSound( "beep_mp3.mp3" )		-- for Android
else
--	print("CAF")
	soundID = media.newEventSound( "beep_caf.caf" )		-- for IOS
end

-- Play sound
--
local playBeep = function()
	media.playEventSound( soundID )
end

-- Displays App title
title = display.newText( "Event Sound", centerX, 30, "Verdana-Bold", 20 )
title:setFillColor( 1, 1, 0 )

msg = display.newText( "Listen for sound every 1 second", centerX, centerY, "Verdana-Bold", 14 )

-- Set up timer to play sound every second
--
timer.performWithDelay( 1000, playBeep, 0 )

