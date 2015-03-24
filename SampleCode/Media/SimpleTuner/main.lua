-- Project: Simple Tuner
--
-- Date: November 17, 2010
--
-- Version: 1.0
--
-- File name: main.lua
--
-- Code type: SDK Test code
--
-- Author: Corona Labs
--
-- Demonstrates: This sample demonstrates using audio frequency analysis
-- 
--
-- File dependencies:
--
-- Target devices: Simulator, iOS, Android
--
-- Limitations:  Requires a microphone input; performance is platform-dependent.
--
-- Update History:
--
-- Comments: 
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

display.setStatusBar( display.HiddenStatusBar )

-- Create an object to access audio input features
local r = media.newRecording()
r:startRecording()
r:startTuner()

local noteNames = {"A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A"}

local function getNoteInfo (f1)
    note = {}
    if (f1 == 0) or (f1 ~= f1) then
        note.name = " "
        note.cents = 0
        note.index = 1
    else
        -- calculate note name 
        local n = math.floor (0.5 + (12 * math.log( f1 / 440) / math.log(2) ) % 12)
--        print ("notenum = ".. n)    
        -- calculate cents
        local nRef = math.floor (0.5 + (12 * math.log( f1 / 440) / math.log(2) ))
        local fRef = 440 * math.exp ((nRef / 12) * (math.log (2)) )-- 440 * 2^(n/12)
--        print ("fRef = ".. fRef)  
        note.index = n + 2
        note.name = noteNames[n + 1]        
        note.cents = math.floor (100 * 1200 * math.log ((f1 / fRef)) / math.log(2)) / 100
--        print ("note name = ".. note.name)    
--        print ("cents = ".. note.cents)    
    end
    return note
end


-- Create an object to hold display items
local g = display.newGroup()
local TOPMARGIN, LEFTMARGIN = 110, 20
local BOTMARGIN, RIGHTMARGIN = 110, 20
local bg = display.newImage("TunerBackground.png", centerX, centerY )
g:insert(bg)

-- frequency label and readout
local label = display.newText( "frequency", LEFTMARGIN, TOPMARGIN, nil, 22 )
label.anchorX, label.anchorY = 0.0, 0.0		-- TopLeft anchor
label:setFillColor( 1, 100/255 )
g:insert(label)

local frequency = display.newText( "0.0", _W + 40, label.y, nil, 22 )
frequency.anchorX, frequency.anchorY = 0.0, 0.0		-- TopLeft anchor
frequency:setFillColor( 1, 150/255 )

function frequency:enterFrame( event )
    local f = r:getTunerFrequency()
	frequency.text = string.format("%5.1f", f )
end
Runtime:addEventListener( "enterFrame", frequency );
g:insert(frequency)

-- tuner note label and text readout
local noteLabelSize = 160
local noteLabel = display.newText( " ", centerX, centerY + 10, nil, noteLabelSize )
noteLabel:setFillColor( 1,1, 100/255, 0 )

function noteLabel:enterFrame ( event )
    local f = r:getTunerFrequency()    
    local noteInfo = getNoteInfo (f)
    noteLabel.text = noteInfo.name
    noteLabel:setFillColor( 1, 200/255, 100/255 )
end
Runtime:addEventListener( "enterFrame", noteLabel );
g:insert(noteLabel)

-- tuner cents indicator
local centsString = "<<<<< | >>>>>"
local centsBar = display.newGroup ()
local centsBarY = frequency.y + frequency.height + 20
local dx = (display.contentWidth - 2*LEFTMARGIN) / (#centsString + 1)
for i = 1, #centsString do
    local t = display.newText (string.sub (centsString, i, i), LEFTMARGIN + i * dx, centsBarY, nil, 24)
    t:setFillColor( 50/255, 50/255, 50/255 )
    centsBar:insert(t)
end

function centsBar:enterFrame ( event )
    local f = r:getTunerFrequency()    
    local noteInfo = getNoteInfo (f)
    local bars = math.floor ( math.abs (noteInfo.cents/10) )
    for i = 1, #centsString do
        if noteInfo.name == "" then
            centsBar[i]:setFillColor(50/255,50/255,50/255)
        elseif (i == 7 and (bars <= 1) ) then 
            centsBar[i]:setFillColor(10/255,1,10/255)
        elseif (i <= 5 and noteInfo.cents < 0 and i >= 6 - bars) then
            centsBar[i]:setFillColor(1,10/255,10/255)
        elseif (i >= 9 and noteInfo.cents > 0 and i - 8 <= bars ) then          
            centsBar[i]:setFillColor(1,10/255,10/255)
        else
            centsBar[i]:setFillColor(50/255,50/255,50/255)
        end
    end
end
Runtime:addEventListener( "enterFrame", centsBar);
g:insert( centsBar )


-- volume label and readout
local volumeLabel = display.newText( "volume", LEFTMARGIN, _H - BOTMARGIN - 10, nil, 22 )
volumeLabel.anchorX, volumeLabel.anchorY = 0.0, 0.0		-- TopLeft anchor
volumeLabel:setFillColor( 1, 100/255 )
g:insert( volumeLabel )

local volume = display.newText( "0.0", centerX + 40, volumeLabel.y, nil, 22 )
volume.anchorX, volume.anchorY = 0.0, 0.0		-- TopLeft anchor
volume:setFillColor( 1, 150/255 )

function volume:enterFrame( event )
    local v = 20*math.log(r:getTunerVolume())
	volume.text = string.format("%4.2f", v )  -- convert to db
end
Runtime:addEventListener( "enterFrame", volume );
g:insert(volume)

-- volume indicator 
local function newBar()
	local bar = display.newLine( 0, 0, 1, 0 ) 
	bar:setStrokeColor( 0, 1, 100/255 )
	bar.strokeWidth = 1
	return bar
end


local volumeBar = newBar()
volumeBar.yScale =  10
volumeBar.y = volumeLabel.y - 15
volumeBar.x = LEFTMARGIN


function volumeBar:enterFrame ( event )
    local v = 20*math.log(r:getTunerVolume())    
    local MINTHRESH = 12
    local v2 = MINTHRESH + math.max (v, -MINTHRESH)
    v2 = (_W - 2 * LEFTMARGIN ) * v2 / MINTHRESH
    volumeBar.xScale =  math.max ( 8, v2 )
    if (v >= -3) then
        volumeBar:setStrokeColor( 1,  20/255, 20/255 )
    elseif (v < -3) then
        volumeBar:setStrokeColor( 20/255,  1, 20/255 )
    end
end
Runtime:addEventListener("enterFrame", volumeBar)
g:insert(volumeBar)


