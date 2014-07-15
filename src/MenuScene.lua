require "Cocos2d"
require "Cocos2dConstants"

require "util"
require "GameScene"

function MenuScene_create()
	local sceneMenu = cc.Scene:create()
	sceneMenu:addChild(MenuScene_createLayer())

	return sceneMenu
end

function MenuScene_createLayer()
    local visibleSize = cc.Director:getInstance():getVisibleSize()
    local origin = cc.Director:getInstance():getVisibleOrigin()

	local layer = cc.Layer:create()

	-- local bg = cc.Sprite:create("farm.jpg")
	-- bg:setPosition(origin.x + visibleSize.width / 2 + 80, origin.y + visibleSize.height / 2)
	-- layer:addChild(bg)


	local titleLable = cc.Label:createWithTTF("Mental Arithmetic Master", 
											  "04b24.ttf",
											  68,
											  cc.size(visibleSize.width/3, 0),
											  cc.TEXT_ALIGNMENT_CENTER,
											  cc.VERTICAL_TEXT_ALIGNMENT_CENTER)
	titleLable:setPosition(cc.p(visibleSize.width * 0.5, visibleSize.height * 0.7))
	layer:addChild(titleLable)
 	


	local startLabel = cc.Label:createWithTTF("Start!", 
											  "04b24.ttf",
											  48)
	startLabel:setPosition(cc.p(visibleSize.width * 0.5, visibleSize.height * 0.25))
	layer:addChild(startLabel)

 	local function onTouchBegan(touch, event)
 		if(cc.rectContainsPoint(startLabel:getBoundingBox(), touch:getLocation())) then
 			local zoomAction = cc.ScaleTo:create(0.1, 1.2);
 		startLabel:runAction(zoomAction)
 		end
 		return true
    end

    local function onTouchEnded(touch, event)
 		local zoomAction = cc.ScaleTo:create(0.1, 1.0);
 		startLabel:runAction(zoomAction)

 		if(cc.rectContainsPoint(startLabel:getBoundingBox(), touch:getLocation())) then
 			print("Enter Next Scene")
 			cc.Director:getInstance():replaceScene(GameScene_create())
 		end
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = startLabel:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, startLabel)

	return layer
end
