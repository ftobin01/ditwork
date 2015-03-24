-- 
-- Abstract: Hello World sample app, using native iOS font 
--
-- Demonstrates iPhone5 mode with full screen access using Default-568h@2x.png
--
-- Version: 1.2
-- 
-- Sample code is MIT licensed, see http://www.coronalabs.com/links/code/license
-- Copyright (C) 2010 Corona Labs Inc. All Rights Reserved.
--
--	Supports Graphics 2.0
---------------------------------------------------------------------------------------

local centerX = display.contentCenterX
local centerY = display.contentCenterY
local _W = display.contentWidth
local _H = display.contentHeight

display.setStatusBar( display.DefaultStatusBar )

display.setDefault( "background", 200 )
print( display.screenOriginY )

local background = display.newImage( "world.jpg", centerX, centerY )

local myText = display.newText( "Hello, World!", 0, 0, native.systemFont, 40 )
myText.x = centerX
myText.y = display.contentWidth / 4
myText:setTextColor( 1, 110/255, 110/255 )

local pixels = "Pixels W/H: " .. display.pixelWidth .. ", " .. display.pixelHeight
print( pixels )

local pixText = display.newText( pixels, centerX, 200, native.systemFont, 26 )
pixText:setFillColor( 0 )

local Text1 = display.newText( "Default-568h@2x.png for iPhone5", centerX, 280, native.systemFont, 17 )
Text1:setFillColor( 0 )
