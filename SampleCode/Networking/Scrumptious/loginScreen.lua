-- 
-- Project: Facebook Connect scrumptious sample app
--
-- Date: August 19, 2013
--
-- Version: 1.0
--
-- File name: loginScreen.lua
--
-- Author: Corona Labs
--
-- Abstract: Presents the Facebook Connect login dialog, and then posts to the user's stream
-- (Also demonstrates the use of external libraries.)
--
-- Demonstrates: Facebook library, widget
--
-- File dependencies: facebook.lua
--
-- Target devices: Simulator and Device (iOS only)

--
-- Comments:
-- Requires API key and application secret key from Facebook. To begin, log into your Facebook
-- account and add the "Developer" application, from which you can create additional apps.
--
-- IMPORTANT: Please ensure your app is compatible with Facebook Single Sign-On or your
--			  Facebook implementation will fail! See the following blog post for more details:
--			  http://www.coronalabs.com/links/facebook-sso
--
-- Sample code is MIT licensed, see http://www.coronalabs.com/links/code/license
-- Copyright (C) 2010 Corona Labs Inc. All Rights Reserved.
--
-- Supports Graphics 2.0
---------------------------------------------------------------------------------------

local facebook = require( "facebook" )
local json = require( "json" )
local widget = require( "widget" )
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

function scene:createScene( event )
	local group = self.view
	
	local appId = nil			-- Add the Facebook App ID string here
	local fbCommand = nil
	local GET_USER_INFO = "getInfo"
	local spinner, loginButton
	
	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 73/255, 103/255, 165/255 )
	group:insert( background ) 

	local scrumptiousLogo = display.newImageRect( "assets/scrumptious_logo_large.png", 100, 100 )
	scrumptiousLogo.x = 20 + scrumptiousLogo.contentWidth * 0.5
	scrumptiousLogo.y = 50 + scrumptiousLogo.contentHeight * 0.5
	group:insert( scrumptiousLogo )
	
	local scrumptiousLabel = display.newText( "Scrumptious", 0, 0, native.systemFontBold, 24 )
	scrumptiousLabel.x = scrumptiousLogo.x + scrumptiousLogo.contentWidth * 0.5 + scrumptiousLabel.contentWidth * 0.5 + 20
	scrumptiousLabel.y = scrumptiousLogo.y - 20
	scrumptiousLabel:setFillColor( 138/255, 215/255, 1 )
	group:insert( scrumptiousLabel )
	
	local getStartedText = display.newText( "To get started, login\n using Facebook", 240, 220, display.contentWidth, 0, native.systemFont, 18 )
	group:insert( getStartedText )

	-- Display an Alert box if no app ID is set
	if not appId then	
			-- Handle the response from showAlert dialog boxbox
		--
		local function onComplete( event )
			if event.index == 1 then
				system.openURL( "http://developers.facebook.com/docs/guides/canvas/" )
			end
		end

		native.showAlert( "Error", "To develop for Facebook Connect, you need to get an API key and application secret. This is available from Facebook's website.",
			{ "Learn More", "Cancel" }, onComplete )
	end
	
	-- Facebook listener
	local function facebookListener( event )
		if "request" == event.type then		

			if event.isError then
				native.showAlert( "Request Error", "Error trying to get the current user", { "OK" } )
				spinner.isVisible = false
				return
			end

			local response = json.decode( event.response )

			if response then
				storyboard.userData.firstName = response.first_name
				storyboard.userData.lastName = response.last_name
				storyboard.userData.id = response.id
			end
		
			local function networkListener( event )
				if event.isError then
					native.showAlert( "Network Error", "Download of profile picture failed, please check your network connection", { "OK" } )
				else
					print( "Profile picture downloaded successfully" )
				end
				
				loginButton.isVisible = false
				spinner.isVisible = false
				
				-- Go to the main screen
				storyboard.gotoScene( "mainScreen", "crossFade" )
				
				-- Show the storyboard navBar group
				storyboard.navBarGroup.isVisible = true
			end
			
			-- Download the profile picture
			local path = system.pathForFile( storyboard.userData.firstName .. storyboard.userData.lastName .. storyboard.userData.id .. ".png", system.TemporaryDirectory )
			local picDownloaded = io.open( path )

			if not picDownloaded then
				network.download( "http://graph.facebook.com/" .. storyboard.userData.id .. "/picture", "GET", networkListener, storyboard.userData.firstName .. storyboard.userData.lastName .. storyboard.userData.id .. ".png", system.TemporaryDirectory )
			else
				loginButton.isVisible = true
				spinner.isVisible = false
				
				-- Go to the main screen
				storyboard.gotoScene( "mainScreen", "crossFade" )
				
				-- Show the storyboard navBar group
				storyboard.navBarGroup.isVisible = true
			end
		
		-- After a successful login event, send the FB command
		-- Note: If the app is already logged in, we will still get a "login" phase
	    elseif "session" == event.type then
	        -- event.phase is one of: "login", "loginFailed", "loginCancelled", "logout"
				
			if event.phase ~= "login" then
				-- Exit if login error
				return
			end
			
			-- Request the current logged in user's info
			if fbCommand == GET_USER_INFO then
				facebook.request( "me" )
			end
	    end
	
		return true
	end


	-- Create a spinner
	spinner = widget.newSpinner
	{
	}
	spinner.isVisible = false
	group:insert( spinner )

	-- Login function
	local function loginUser( event )
		if appId then	
			-- only call login if the app ID is defined
			event.target.isVisible = false
			spinner.isVisible = true
			spinner:start()
			-- call the login method of the FB session object, passing in a handler
			-- to be called upon successful login.
			fbCommand = GET_USER_INFO
			facebook.login( appId, facebookListener )
		end
	end
	
	-- Create a button to login the user
	loginButton = widget.newButton
	{
		width = 120,
		height = 59,
		label = "Login",
		onRelease = loginUser,
	}
	loginButton.x = display.contentCenterX
	loginButton.y = display.contentCenterY + 80
	group:insert( loginButton )

	spinner.x = loginButton.x
	spinner.y = loginButton.y
end

scene:addEventListener( "createScene", event )

return scene
