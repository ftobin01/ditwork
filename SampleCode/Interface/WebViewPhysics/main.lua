-- 
-- Abstract: WebView Physics
--
-- Demonstrates creating webView objects and attaching physics bodies to them. You
-- must build for device (or Xcode simulator) for this sample to work properly.
-- 
-- Version: 1.0 (requires Corona build 2012.730 or later)
-- 
-- Copyright (C) 2012 Corona Labs Inc. All Rights Reserved.
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
--
-- Published changes made to this software and associated documentation and module files (the
-- "Software") may be used and distributed by Corona Labs, Inc. without notification. Modifications
-- made to this software and associated documentation and module files may or may not become
-- part of an official software release. All modifications made to the software will be
-- licensed under these same terms and conditions.
--
-- Supports Graphics 2.0
------------------------------------------------------------

display.setStatusBar( display.HiddenStatusBar )

if system.getInfo( "environment" ) == "simulator" then
	native.showAlert( "Please Build for Device", "native.newWebView() does not work in the Corona Simulator. Please build for device (or Xcode simulator) for this sample to work properly.", { "OK" } )
end

local physics = require("physics")
physics.start()

local bkg = display.newImage( "bkg_cor.png", display.contentCenterX, display.contentCenterY )

local grass = display.newImage("grass.png", 160, 430 )

local grass2 = display.newImage("grass2.png", 160, 440 ) -- non-physical decorative overlay

physics.addBody( grass, "static", { friction=0.5, bounce=0.3 } )

-- callback listener function for webview objects
local function listener( event )
	local url = event.url	-- reference to currently loaded url
	
	if event.errorCode then
		native.showAlert( "Error!", event.errorMessage, { "OK" } )
	end
end

function newWebViewCrate()
	local webView = native.newWebView( 0, 0, 80, 80 )
	webView:addEventListener( 'urlRequest', listener )

	webView:request( "http://www.google.com/" )
	
	
	webView.x = 60 + math.random( 160 )
	webView.y = -100
	physics.addBody( webView, { density=0.9, friction=0.3, bounce=0.3} )
end

-- drop 10 webViews with physics
local dropViews = timer.performWithDelay( 500, newWebViewCrate, 10 )
