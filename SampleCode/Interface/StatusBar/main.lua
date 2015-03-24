-- 
-- Abstract: Status Bar sample app
-- 
-- Version: 1.1
-- 
-- Copyright (C) 2010 Corona Labs Inc. All Rights Reserved.
-- 
-- Permission is hereby granted, free of charge, to any person obtaining a copy of 
-- this software and associated documentation files (the "Software"), to deal in the 
-- Software without restriction, including without limitation the rights to use, copy, 
-- modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, 
-- and to permit persons to whom the Software is furnished to do so, subject to the 
-- following conditions:
-- 
-- The above copyright notice and this permission notice shall be included in all copies 
-- or substantial portions of the Software.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
-- INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR 
-- PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE 
-- FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
-- OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
-- DEALINGS IN THE SOFTWARE.

-- Cycles through the different status bar modes, changing modes every second
--
-- Supports Graphics 2.0
------------------------------------------------------------

-- array of status bar modes
local modes = {
	display.HiddenStatusBar,
	display.DefaultStatusBar,
	display.DarkStatusBar,
	display.TranslucentStatusBar,
}

local modeNames = {
	"display.HiddenStatusBar",
	"display.DefaultStatusBar",
	"display.DarkStatusBar",
	"display.TranslucentStatusBar",
}

local background = display.newImage( "shine.png", display.contentCenterX, display.contentCenterY ) 

local label = display.newText( "Mode changes every 2 seconds", 0, 0, native.systemFontBold, 18 )
label:setFillColor( 1, 1, 1 )

-- center text
label.x = display.contentWidth*0.5
label.y = display.contentHeight*0.8

local function changeStatusBarMode( event )
	local numModes = #modes

	-- get an integer index between 1 and numModes
	local index = event.count % numModes + 1

	label.text = modeNames[index]
	display.setStatusBar( modes[index] )
end

-- call changeStatusBarMode() every second
timer.performWithDelay( 2000, changeStatusBarMode, 0 )