-- 
-- Abstract: Tab Bar sample app, example content screen
--  
-- Version: 2.0
-- 
-- Sample code is MIT licensed, see http://www.coronalabs.com/links/code/license
-- Copyright (C) 2010 Corona Labs Inc. All Rights Reserved.
--
-- This file is used to display the corresponding screen content when the user clicks the tab bar. 

local storyboard = require ( "storyboard" )

--Create a storyboard scene for this module
local scene = storyboard.newScene()

--Create the scene
function scene:createScene( event )
	local group = self.view
	
	--Create a text object that displays the current scene name and insert it into the scene's view
	local screenText = display.newText( "Screen 2", display.contentCenterX, display.contentCenterY, native.systemFontBold, 18 )
	screenText:setFillColor( 0 )
	group:insert( screenText )
end

--Add the createScene listener
scene:addEventListener( "createScene", scene )

return scene
