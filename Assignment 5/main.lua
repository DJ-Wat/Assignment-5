local Background = display.newImage ("./assets/BG.jpg")
local timerT = display.newText ( "", display.contentCenterX, display.contentCenterY + 150, native.systemFont, 30 )


local playerBall = display.newImageRect ("./assets/ball2.png", 30, 30)

playerBall.x = display.contentCenterX

playerBall.y = display.contentCenterY - 100

playerBall.id = "player"

playerBall.isFixedRotation = true



local enemyBall = display.newImageRect ("./assets/ball1.png", 20, 20)

enemyBall.x = display.contentCenterX

enemyBall.y = display.contentCenterY - 200

enemyBall.id = "enemy"









local upArrow = display.newImage( "./assets/upArrow.png" )



upArrow.x = 150



upArrow.y = 330



upArrow.alpha = 0.5



upArrow.id = "up arrow"



local downArrow = display.newImage( "./assets/downArrow.png" )



downArrow.x = 150



downArrow.y = 450



downArrow.alpha = 0.5



downArrow.id = "down arrow"



local leftArrow = display.newImage( "./assets/leftArrow.png" )



leftArrow.x = 90



leftArrow.y = 390



leftArrow.alpha = 0.5



leftArrow.id = "left arrow"



local rightArrow = display.newImage( "./assets/rightArrow.png" )

 

rightArrow.x = 210



rightArrow.y = 390



rightArrow.alpha = 0.5



rightArrow.id = "right arrow"



local physics = require( "physics" )

physics.start()

physics.setGravity( 0, 0)

--physics.setDrawMode( "hybrid" )



local leftWall = display.newRect( -230, display.contentHeight / 2, 500, display.contentHeight )



leftWall:setFillColor( 0,3,10 )



physics.addBody( leftWall, "static", { 



    friction = 0.5, 



    bounce = 0.3 



    } )



leftWall.collisionType = "wall"



leftWall.id = "left wall"



local rightWall = display.newRect( 550, display.contentHeight / 2, 500, display.contentHeight )



rightWall:setFillColor( 0,3,10 )



physics.addBody( rightWall, "static", { 



    friction = 0.5, 



    bounce = 0.3 



    } )



rightWall.id = "right wall"



rightWall.collisionType = "wall"



local topWall = display.newRect( 0, -250, display.contentWidth * 2, 500 )



topWall:setFillColor( 0,3,10 )



physics.addBody( topWall, "static", { 



    friction = 0.5, 



    bounce = 0.3 



    } )



topWall.collisionType = "wall"



topWall.id = "top wall"



local bottomWall = display.newRect( 0, 250, display.contentWidth * 2, 90 )



bottomWall:setFillColor( 0,3,10 )



physics.addBody( bottomWall, "static", { 



    friction = 0.5, 



    bounce = 0.3 



    } )



bottomWall.collisionType = "wall"



bottomWall.id = "bottom wall"



physics.addBody( playerBall, "dynamic", { 



    density = 2.5, 



    friction = 0.5, 



    bounce = 0.3



    } )



physics.addBody( enemyBall, "dynamic", { 



    density = 0.5, 



    friction = 0.5, 



    bounce = 0.3



    } )



function upArrow:touch( event )



    if ( event.phase == "ended" ) then



        -- move the character up



        transition.moveBy( playerBall, { 



            x = 0, -- move 0 in the x direction 



            y = -25, -- move up 50 pixels



            time = 100 -- move in a 1/10 of a second



            } )



    end







    return true



end



function downArrow:touch( event )



    if ( event.phase == "ended" ) then



        -- move the character down



        transition.moveBy( playerBall, { 



            x = 0, -- move 0 in the x direction 



            y = 25, -- move down 50 pixels



            time = 100 -- move in a 1/10 of a second



            } )



    end







    return true



end



function leftArrow:touch( event )



    if ( event.phase == "ended" ) then



        -- move the character up



        transition.moveBy( playerBall, { 



            x = -25, -- move 50 pixels left 



            y = 0, 



            time = 100 -- move in a 1/10 of a second



            } )



    end







    return true



end



function rightArrow:touch( event )



    if ( event.phase == "ended" ) then



        -- move the character up



        transition.moveBy( playerBall, { 



            x = 25, -- move 50 pixels right



            y = 0, 



            time = 100 -- move in a 1/10 of a second



            } )



    end







    return true



end






local t = {}

function t:timer( event )

    local count = event.count
    timerT.text = (""..count)

end

local gameTimer = timer.performWithDelay( 1000, t, 0)


local function playerCollision (event)



	if ( event.phase == "began" ) then

       local obj1 = event.object1

       local obj2 = event.object2



       if (( obj1.id == "enemy" and obj2.id == "player") or

       	(obj1.id == "player" and obj2.id == "enemy")) then

       	display.remove (obj1)

       	display.remove (obj2)

       	

       	local GameOver = display.newText("Game Over", display.contentCenterX, display.contentCenterY, native.systemFont, 50)
	GameOver:setFillColor (1,0,0)
       	local timerPause = timer.pause(gameTimer)
       	timerT:setFillColor (0,1,0)
       	upArrow:removeEventListener( "touch", upArrow )

		downArrow:removeEventListener( "touch", downArrow )

		leftArrow:removeEventListener( "touch", leftArrow )

		rightArrow:removeEventListener( "touch", rightArrow )

       end

   end

end



local eSpeedX = 1

local eSpeedY = 0

print(tonumber (eSpeedX))

print(tonumber (eSpeedY))

local function enemyMove(event)

	if (enemyBall.x ~= nil) then

		enemyBall.x = enemyBall.x + eSpeedX

		enemyBall.y = enemyBall.y + eSpeedY
	end

end



local function rWallBounce(event)

	if ( event.phase == "began" ) then

       local obj1 = event.object1

       local obj2 = event.object2



       if (( obj1.id == "enemy" and obj2.id == "right wall") or

       	(obj1.id == "right wall" and obj2.id == "enemy")) then

       		eSpeedX = eSpeedX * -1

       		eSpeedY = math.random ( -4, 4 )

       		print("x:"..tonumber (eSpeedX))

			print("y:"..tonumber (eSpeedY))

       end

   end

end



local function lWallBounce(event)

	if ( event.phase == "began" ) then

       local obj1 = event.object1

       local obj2 = event.object2



       if (( obj1.id == "enemy" and obj2.id == "left wall") or

       	(obj1.id == "left wall" and obj2.id == "enemy")) then

       		eSpeedX = eSpeedX * -1

       		eSpeedY = math.random ( -4, 4 )

       		print("x:"..tonumber (eSpeedX))

			print("y:"..tonumber (eSpeedY))

       end

   end

end



local function tWallBounce(event)

	if ( event.phase == "began" ) then

       local obj1 = event.object1

       local obj2 = event.object2



       if (( obj1.id == "enemy" and obj2.id == "top wall") or

       	(obj1.id == "top wall" and obj2.id == "enemy")) then

       		eSpeedY = eSpeedY * -1

       		eSpeedX = math.random ( -4, 4 )

       		print("x:"..tonumber (eSpeedX))

			print("y:"..tonumber (eSpeedY))

       end

   end

end



local function bWallBounce(event)

	if ( event.phase == "began" ) then

       local obj1 = event.object1

       local obj2 = event.object2



       if (( obj1.id == "enemy" and obj2.id == "bottom wall") or

       	(obj1.id == "bottom wall" and obj2.id == "enemy")) then

       		eSpeedY = eSpeedY * -1

       		eSpeedX = math.random ( -4, 4 )

       		print("x:"..tonumber (eSpeedX))

			print("y:"..tonumber (eSpeedY))

       end

   end

end



upArrow:addEventListener( "touch", upArrow )

downArrow:addEventListener( "touch", downArrow )

leftArrow:addEventListener( "touch", leftArrow )

rightArrow:addEventListener( "touch", rightArrow )



Runtime:addEventListener("collision", playerCollision)

Runtime:addEventListener("collision", rWallBounce)

Runtime:addEventListener("collision", lWallBounce)

Runtime:addEventListener("collision", tWallBounce)

Runtime:addEventListener("collision", bWallBounce)

Runtime:addEventListener("enterFrame", enemyMove)
