local composer = require( "composer" )
local scene = composer.newScene()
local widget = require("widget")

--options
--For this demo, this only lets you toggle which category of place you want as your target destinations.
--the total available choices are those in the suggestedGameplay style set:
-- water, wetland, park, beach, university, natureReserve, cemetry, retail, artsCulture, tourism, historical, trail

local switches = {}
local radios = {}

local chkShort
local chkMedium
local chkLong

local chkArtsCulture
local chkBeach
local chkCemetery
local chkHistoric
local chkNatureReserve
local chkPark
local chkRetail
local chkTourism
local chkTrail
local chkUniversity
local chkWater
local chkWetlands

function BackToTarget()
    composer.gotoScene("Scenes.TargetScene")
end

function SetNewOptions(event)
    print(listProps(event))
    local available = ''
    for i,v in ipairs(switches) do 
        if v.isOn then
            available = available .. '-' .. v.id
        end
    end

    for i,v in ipairs(radios) do 
        if v.isOn then
            available = available .. '~' .. v.id
        end
    end

    local url = serverURL .. "UnRoutine/Options/" .. available
    print(url)
    network.request(url, "PUT", SetOptionsListener, normalParams)
    print('sending options to server')
end

function SetOptionsListener(event)
    --confirmed settings are updated.
    print('settings saved')
    print(dump(event))
end

-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    local options = {
        width = 256,
        height = 256,
        numFrames = 2,
        sheetContentWidth = 512,
        sheetContentHeight = 256
    }
    local checkboxSheet = graphics.newImageSheet("themables/checkbox.png", options)

    local lblTypes = display.newText({parent = sceneGroup, text = "Target Categories", x = display.contentCenterX, y = 30})
    local lblTypes = display.newText({parent = sceneGroup, text = "Trip Length", x = display.contentCenterX, y = 1300})

    local lblWater = display.newText({parent = sceneGroup, text = "Water", x = 190, y = 140})
    lblWater.anchorX = 0
    chkWater = widget.newSwitch({ left = 50, top = 70, width= 128, height=128, style = "checkbox", id = "water", onRelease = SetNewOptions, sheet = checkboxSheet, frameOff = 1, frameOn = 2})
    table.insert(switches, chkWater)
    sceneGroup:insert(chkWater)

    local lblWetlands = display.newText({parent = sceneGroup, text = "Wetlands", x = 190, y = 340})
    lblWetlands.anchorX = 0
    chkWetlands = widget.newSwitch({ left = 50, top = 270, width= 128, height=128, style = "checkbox", id = "wetlands", onRelease = SetNewOptions, sheet = checkboxSheet, frameOff = 1, frameOn = 2})
    table.insert(switches, chkWetlands)
    sceneGroup:insert(chkWetlands)

    local lblPark = display.newText({parent = sceneGroup, text = "Park", x = 190, y = 540})
    lblPark.anchorX = 0
    chkPark = widget.newSwitch({ left = 50, top = 470, width= 128, height=128, style = "checkbox", id = "park", onRelease = SetNewOptions, sheet = checkboxSheet, frameOff = 1, frameOn = 2})
    table.insert(switches, chkPark)
    sceneGroup:insert(chkPark)
 
    local lblBeach = display.newText({parent = sceneGroup, text = "Beach", x = 190, y = 740})
    lblBeach.anchorX = 0
    chkBeach = widget.newSwitch({ left = 50, top = 670, width= 128, height=128, style = "checkbox", id = "beach", onRelease = SetNewOptions, sheet = checkboxSheet, frameOff = 1, frameOn = 2})
    table.insert(switches, chkBeach)
    sceneGroup:insert(chkBeach)

    local lblUniversity = display.newText({parent = sceneGroup, text = "University", x = 190, y = 940})
    lblUniversity.anchorX = 0
    chkUniversity = widget.newSwitch({ left = 50, top = 870, width= 128, height=128, style = "checkbox", id = "university", onRelease = SetNewOptions, sheet = checkboxSheet, frameOff = 1, frameOn = 2})
    table.insert(switches, chkUniversity)
    sceneGroup:insert(chkUniversity)

    local lblNatureReserve = display.newText({parent = sceneGroup, text = "NatureReserve", x = 190, y = 1140})
    lblNatureReserve.anchorX = 0
    chkNatureReserve = widget.newSwitch({ left = 50, top = 1070, width= 128, height=128, style = "checkbox", id = "natureReserve", onRelease = SetNewOptions, sheet = checkboxSheet, frameOff = 1, frameOn = 2})
    table.insert(switches, chkNatureReserve)
    sceneGroup:insert(chkNatureReserve)

    local lblCemetery = display.newText({parent = sceneGroup, text = "Cemetery", x = 740, y = 140})
    lblCemetery.anchorX = 0
    chkCemetery = widget.newSwitch({ left = 600, top = 70, width= 128, height=128, style = "checkbox", id = "cemetery", onRelease = SetNewOptions, sheet = checkboxSheet, frameOff = 1, frameOn = 2})
    table.insert(switches, chkCemetery)
    sceneGroup:insert(chkCemetery)

    local lblRetail = display.newText({parent = sceneGroup, text = "Retail", x = 740, y = 340})
    lblRetail.anchorX = 0
    chkRetail = widget.newSwitch({ left = 600, top = 270, width= 128, height=128, style = "checkbox", id = "retail", onRelease = SetNewOptions, sheet = checkboxSheet, frameOff = 1, frameOn = 2})
    table.insert(switches, chkRetail)
    sceneGroup:insert(chkRetail)

    local lblArtsCulture = display.newText({parent = sceneGroup, text = "ArtsCulture", x = 740, y = 540})
    lblArtsCulture.anchorX = 0
    chkArtsCulture = widget.newSwitch({ left = 600, top = 470, width= 128, height=128, style = "checkbox", id = "artsCulture", onRelease = SetNewOptions, sheet = checkboxSheet, frameOff = 1, frameOn = 2})
    table.insert(switches, chkArtsCulture)
    sceneGroup:insert(chkArtsCulture)

    local lblTourism = display.newText({parent = sceneGroup, text = "Tourism", x = 740, y = 740})
    lblTourism.anchorX = 0
    local chkTourism = widget.newSwitch({ left = 600, top = 670, width= 128, height=128, style = "checkbox", id = "tourism", onRelease = SetNewOptions, sheet = checkboxSheet, frameOff = 1, frameOn = 2})
    table.insert(switches, chkTourism)
    sceneGroup:insert(chkTourism)

    local lblHistoric = display.newText({parent = sceneGroup, text = "Historic", x = 740, y = 940})
    lblHistoric.anchorX = 0
    local chkHistoric = widget.newSwitch({ left = 600, top = 870, width= 128, height=128, style = "checkbox", id = "historical", onRelease = SetNewOptions, sheet = checkboxSheet, frameOff = 1, frameOn = 2})
    table.insert(switches, chkHistoric)
    sceneGroup:insert(chkHistoric)

    local lblTrail = display.newText({parent = sceneGroup, text = "Trail", x = 740, y = 1140})
    lblTrail.anchorX = 0
    chkTrail = widget.newSwitch({ left = 600, top = 1070, width= 128, height=128, style = "checkbox", id = "trail", onRelease = SetNewOptions, sheet = checkboxSheet, frameOff = 1, frameOn = 2})
    table.insert(switches, chkTrail)
    sceneGroup:insert(chkTrail)

    local radioGroup = display.newGroup()
    local lblShort = display.newText({parent = sceneGroup, text = "15 min walk, 1-2km", x = 220, y = 1400})
    lblShort.anchorX = 0
    chkShort = widget.newSwitch({ left = 50, top = 1330, width= 128, height=128, style = "radio", id = "1", onRelease = SetNewOptions, sheet = checkboxSheet, frameOff = 1, frameOn = 2})
    table.insert(radios, chkShort)

    local lblMedium = display.newText({parent = sceneGroup, text = "15-30 min drive, 14-28km", x = 220, y = 1550})
    lblMedium.anchorX = 0
    chkMedium = widget.newSwitch({ left = 50, top = 1500, width= 128, height=128, style = "radio", id = "2", onRelease = SetNewOptions, sheet = checkboxSheet, frameOff = 1, frameOn = 2})
    table.insert(radios, chkMedium)

    local lblLong = display.newText({parent = sceneGroup, text = "30-120 min drive, 50-200km", x = 220, y = 1700})
    lblLong.anchorX = 0
    chkLong = widget.newSwitch({ left = 50, top = 1650, width= 128, height=128, style = "radio", id = "3", onRelease = SetNewOptions, sheet = checkboxSheet, frameOff = 1, frameOn = 2})
    table.insert(radios, chkLong)

    radioGroup:insert(chkShort)
    radioGroup:insert(chkMedium)
    radioGroup:insert(chkLong)
    sceneGroup:insert(radioGroup)

    local lblExit = display.newText({parent = sceneGroup, text = "Return", x = display.contentCenterX, y = 1850})
    lblExit:addEventListener("tap", BackToTarget)
end
 
function BackListener(event)
    if (event.keyName == "back" and event.phase == "up") then
        composer.gotoScene("Scenes.TargetScene")
        return true
    end
    return false
end

function GetOptions()
    MakeUnqueuedRequest('Unroutine/Options', GetOptionsListener)
end

function GetOptionsListener(event)
    print(dump(event))

    local optionsData = json.decode(event.response)
    
    if optionsData.distancePref == "1" then
        chkShort:setState({isOn = true})
    elseif optionsData.distancePref == "2" then
        chkMedium:setState({isOn = true})
    else
        chkLong:setState({isOn = true})
    end

    if optionsData.categories:find("water") ~= nil then chkWater:setState({isOn = true}) end
    if optionsData.categories:find("wetlands") ~= nil then chkWetlands:setState({isOn = true}) end
    if optionsData.categories:find("park") ~= nil then chkPark:setState({isOn = true}) end
    if optionsData.categories:find("beach") ~= nil then chkBeach:setState({isOn = true}) end
    if optionsData.categories:find("university") ~= nil then chkUniversity:setState({isOn = true}) end
    if optionsData.categories:find("natureReserve") ~= nil then chkNatureReserve:setState({isOn = true}) end
    if optionsData.categories:find("cemetery") ~= nil then chkCemetery:setState({isOn = true}) end
    if optionsData.categories:find("retail") ~= nil then chkRetail:setState({isOn = true}) end
    if optionsData.categories:find("artsCulture") ~= nil then chkArtsCulture:setState({isOn = true}) end
    if optionsData.categories:find("tourism") ~= nil then chkTourism:setState({isOn = true}) end
    if optionsData.categories:find("historical") ~= nil then chkHistoric:setState({isOn = true}) end
    if optionsData.categories:find("trail") ~= nil then chkTrail:setState({isOn = true}) end

    composer.hideOverlay()
end
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
    
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        --set checkboxes to match options on server. download options after login
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        Runtime:addEventListener("key", BackListener)

        composer.showOverlay("Overlays.LoadingOverlay")
        GetOptions()

        
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        Runtime:removeEventListener("key", BackListener)
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene