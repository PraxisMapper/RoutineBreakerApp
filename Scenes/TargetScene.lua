local composer = require( "composer" )
local scene = composer.newScene()

local targetImg = {}
local targetInfo = {}

--Target Scene:
--may take options for picking a target
--show a picture and info on the target

function GotoOptions()
    composer.gotoScene("Scenes.PlaceOptionsScene")
end

function GetTarget()
    print('calling target')
    local url = serverURL .. "UnRoutine/Target/" .. RemovePlus(currentPlusCode)
    print(url)
    --QueueCall(url, "PUT", TargetListener, normalParams)
    network.request(url, "PUT", TargetListener, normalParams)
end

function TargetListener(event)
    print('target responded.')
    if (event.response ~= "") then
        local placeData = json.decode(event.response)
        print(dump(placeData))
        if (placeData.Name == 'No Place Found') then
            targetInfo.text = "No viable targets with current parameters"
            targetLoc.text = ''
            return
        end
        targetInfo.text = 'Name: ' .. placeData.Name
        targetLoc.text = 'Location: ' ..placeData.Location
        GetTargetImage(placeData.PlaceId)
    else
        targetInfo.text = "No Target Currently Set"
    end
end

function GetTargetImage(placeId)
    print('getting target image')
    local params = GetImageDownloadParams(placeId .. '.png', system.TemporaryDirectory)
    local url = serverURL .. "UnRoutine/Image/" .. placeId
    --print(url)
    network.request(url, "GET", TargetImageListener, params)
end

function TargetImageListener(event)
    --received an image, save it and set it as the fill.
    print('image listener called')
    if (NetCallCheck(event.status)) then
        print('received image')
        local pieces = Split(event.url, '/')
        local placeId = pieces[#pieces]
        PaintOneTile(targetImg, placeId .. '.png', system.TemporaryDirectory, false) --reused from other apps!
    end
end

function IgnorePlace(privacyId)
end

function IgnorePlaceListener(event)
end
 
function TargetGPSCallback(event)
    local url = serverURL .. "UnRoutine/Enter/" .. RemovePlus(currentPlusCode)
    QueueCall(url, "PUT", handler, normalParams)
end

function EnterCallback(event)
end
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    local label1 = display.newText({ parent = sceneGroup, text = "Your Current Target:", x = 20, y = 20})
    label1.anchorX = 0
    label1.anchorY = 0

    targetImg = display.newRect(sceneGroup, display.contentCenterX, 80, 900, 900) --x y w h
    targetImg.anchorY = 0

    targetInfo = display.newText({parent = sceneGroup, text = "Loading...", x = 20, y = 1000})
    targetInfo.anchorX = 0
    targetInfo.anchorY = 0

    targetLoc = display.newText({parent = sceneGroup, text = "", x = 20, y = 1100})
    targetLoc.anchorX = 0
    targetLoc.anchorY = 0

    local testLabel = display.newText({parent = sceneGroup, text = "Try Get Target", x = 20, y = 1200})
    testLabel.anchorX = 0
    testLabel.anchorY = 0
    testLabel:addEventListener("tap", GetTarget)

    local optionsLabel = display.newText({parent = sceneGroup, text = "View Options", x = 20, y = 1300})
    optionsLabel.anchorX = 0
    optionsLabel.anchorY = 0
    optionsLabel:addEventListener("tap", GotoOptions)
 
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        currentGpsCallback = TargetGPSCallback
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        GetTarget()
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        currentGpsCallback = nil
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
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