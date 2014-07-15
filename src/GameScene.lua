require "Cocos2d"
require "Cocos2dConstants"

function GameScene_create()
	local scene = cc.Scene:create()
	scene:addChild(GameScene_createLayer())

	return scene
end

function GameScene_createLayer()
 	local visibleSize = cc.Director:getInstance():getVisibleSize()
    local origin = cc.Director:getInstance():getVisibleOrigin()

	local layer = cc.Layer:create()

	-- local sprite = cc.Sprite:create("menu2.png")
	-- sprite:setAnchorPoint(cc.p(0.5,0.5))

	-- local flipx  = cc.FlipX3D:create(2)
	-- local ease = cc.EaseElasticOut:create(flipx)

	-- local gridNodeTarget = cc.NodeGrid:create()
	-- --gridNodeTarget:setPosition(cc.p(1, 1))
	-- --gridNodeTarget:setPosition(cc.p(visibleSize.width / 2,
	-- --								visibleSize.height / 2))
	-- gridNodeTarget:addChild(sprite)
	-- gridNodeTarget:runAction(flipx)

	-- layer:addChild(gridNodeTarget)


 -- 	local function onTouchBegan(touch, event)
 -- 		return true
 --    end

 --    local function onTouchEnded(touch, event)
 --    	print(gridNodeTarget)
 --    	print(ease)
	-- 	local flipx  = cc.FlipX3D:create(2)
	-- 	local ease = cc.EaseElasticOut:create(flipx)

	-- 	gridNodeTarget:runAction(flipx)
 --    end

 --    local listener = cc.EventListenerTouchOneByOne:create()
 --    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
 --    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
 --    local eventDispatcher = gridNodeTarget:getEventDispatcher()
 --    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, gridNodeTarget)


 	local fontSize = 68
 	local questionCanvas = cc.ClippingNode:create()

 	local questionLabel = cc.Label:createWithTTF("45 + 435 = ?", 
											  	 "04b24.ttf",
											  	 fontSize)
 	questionCanvas:setContentSize(cc.size(visibleSize.width, questionLabel:getContentSize().height))
 	questionCanvas:setPosition(cc.p(0, visibleSize.height * 0.6))


 	local questionLabelNotVisible = cc.Label:createWithTTF("45 + 435 = ?", 
											  	 		   "04b24.ttf",
											  	 		   fontSize)

 	questionLabel:setPosition(cc.p(questionCanvas:getContentSize().width / 2,
 								   questionCanvas:getContentSize().height / 2))

 	questionLabelNotVisible:setPosition(cc.p(questionCanvas:getContentSize().width / 2,
 								             -questionCanvas:getContentSize().height / 2))

 	questionCanvas:addChild(questionLabel)
 	questionCanvas:addChild(questionLabelNotVisible)


    --创建裁剪模板，裁剪节点将按照这个模板来裁剪区域  
    local stencil = cc.DrawNode:create()  
    local rectangle = {}
    rectangle[1] = cc.p(0, 0)
    rectangle[2] = cc.p(questionCanvas:getContentSize().width, 0); 
    rectangle[3] = cc.p(questionCanvas:getContentSize().width, questionCanvas:getContentSize().height)
    rectangle[4] = cc.p(0, questionCanvas:getContentSize().height)
      
    local white = cc.c4f(1, 1, 1, 1)  
    --画一个多边形 这画一个200x200的矩形作为模板  
    stencil:drawPolygon(rectangle, 4, white, 1, white)  
    questionCanvas:setStencil(stencil)  
 	layer:addChild(questionCanvas)


 	local moveBy = cc.MoveBy:create(0.5, cc.p(0, questionLabel:getContentSize().height))

	questionLabel:runAction(moveBy)
	questionLabelNotVisible:runAction(moveBy:clone())



	return layer
end