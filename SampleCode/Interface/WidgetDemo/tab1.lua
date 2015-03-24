--*********************************************************************************************
--
-- ====================================================================
-- Corona SDK "Widget" Sample Code
-- ====================================================================
--
-- File: main.lua
--
-- Version 2.0
--
-- Copyright (C) 2013 Corona Labs Inc. All Rights Reserved.
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
--*********************************************************************************************

local widget = require( "widget" )
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- create a constant for the left spacing of the row content
local LEFT_PADDING = 10

-- Our scene
function scene:createScene( event )
	local group = self.view
	
	-- Forward reference for our tableView
	local tableView = nil
	
	-- Text to show which item we selected
	local itemSelected = display.newText( "You selected item ", 0, 0, native.systemFontBold, 28 )
	itemSelected:setFillColor( 0 )
	itemSelected.x = display.contentWidth + itemSelected.contentWidth
	itemSelected.y = display.contentCenterY - itemSelected.contentHeight
	group:insert( itemSelected )
	
	-- Function to return to the list
	local function goBack( event )
		--Transition in the list, transition out the item selected text and the back button

		-- The table x origin refers to the center of the table in Graphics 2.0, so we translate with half the object's contentWidth
		transition.to( tableView, { x = tableView.contentWidth * 0.5, time = 400, transition = easing.outExpo } )
		transition.to( itemSelected, { x = display.contentWidth + itemSelected.contentWidth, time = 400, transition = easing.outExpo } )
		transition.to( event.target, { x = display.contentWidth + event.target.contentWidth, time = 400, transition = easing.outQuad } )
	end
	
	-- Back button
	local backButton = widget.newButton
	{
		width = 198,
		height = 59,
		label = "Back",
		onRelease = goBack,
	}
	backButton.x = display.contentWidth + backButton.contentWidth
	backButton.y = itemSelected.y + itemSelected.contentHeight + backButton.contentHeight
	group:insert( backButton )
	
	-- Listen for tableView events
	local function tableViewListener( event )
		local phase = event.phase
		
		print( "Event.phase is:", event.phase )
	end

	-- Handle row rendering
	local function onRowRender( event )
		local phase = event.phase
		local row = event.row
		
		-- in graphics 2.0, the group contentWidth / contentHeight are initially 0, and expand once elements are inserted into the group.
		-- in order to use contentHeight properly, we cache the variable before inserting objects into the group

		local groupContentHeight = row.contentHeight

		local rowTitle = display.newText( row, "Row " .. row.index, 0, 0, nil, 14 )

		-- in Graphics 2.0, the row.x is the center of the row, no longer the top left.
		rowTitle.x = LEFT_PADDING

		-- we also set the anchorX of the text to 0, so the object is x-anchored at the left
		rowTitle.anchorX = 0

		print(rowTitle.x)
		rowTitle.y = groupContentHeight * 0.5
		rowTitle:setFillColor( 0, 0, 0 )
	end
	
	-- Handle row updates
	local function onRowUpdate( event )
		local phase = event.phase
		local row = event.row
		
		--print( row.index, ": is now onscreen" )
	end
	
	-- Handle touches on the row
	local function onRowTouch( event )
		local phase = event.phase
		local row = event.target
				
		if "release" == phase then
			--Update the item selected text
			itemSelected.text = "You selected item " .. row.index
			
			--Transition out the list, transition in the item selected text and the back button

			-- The table x origin refers to the center of the table in Graphics 2.0, so we translate with half the object's contentWidth
			transition.to( tableView, { x = - tableView.contentWidth, time = 400, transition = easing.outExpo } )
			transition.to( itemSelected, { x = display.contentCenterX, time = 400, transition = easing.outExpo } )
			transition.to( backButton, { x = display.contentCenterX, time = 400, transition = easing.outQuad } )
		end
	end
	
	-- Create a tableView
	tableView = widget.newTableView
	{
		top = 32,
		width = 320, 
		height = 400,
		listener = tableViewListener,
		onRowRender = onRowRender,
		onRowUpdate = onRowUpdate,
		onRowTouch = onRowTouch,
	}
	group:insert( tableView )
	
	-- Create 100 rows
	for i = 1, 100 do
		local isCategory = false
		local rowHeight = 40
		local rowColor = 
		{ 
			default = { 1, 1, 1 },
			over = { 30/255, 144/255, 1 },
		}
		local lineColor = { 220/255, 220/255, 220/255 }
		
		-- Make some rows categories
		if i == 25 or i == 50 or i == 75 then
			isCategory = true
			rowHeight = 24
			rowColor = 
			{ 
				default = { 150/255, 160/255, 180/255, 200/255 },
			}
		end
		
		-- Insert the row into the tableView
		tableView:insertRow
		{
			isCategory = isCategory,
			rowHeight = rowHeight,
			rowColor = rowColor,
			lineColor = lineColor,
		}
	end
end

scene:addEventListener( "createScene" )

return scene