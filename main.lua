-- clankers can define variables here
-- test
local text = ""

-------------------------------------------

function love.load()
    
    game_running = true
    love.window.setTitle("Game")
    -- so apparently, the default window size is 800x600... idk if 600 is y or x because im autistic
    -- i want the circle guy to be in the lower section so like
    -- perfect it has to be 400..
    -- x should start in the middle so 400?
    -- nevermind love provides functions for that

    -- STORE HEIGHT AND WIDTH (OF WINDOW) IN VARIABLES
    window_X = love.graphics.getWidth()
    print(window_X)
    window_Y = love.graphics.getHeight()
    print(window_Y)

    -- MOVEMENT STUFF
    player = {}
    player.x = window_X/2
    player.y = (window_Y*2)/3 -- epik math
    player.radius = 15 
    player.speed = 5
    player.touching_border = false

    -- FALLING BALLSTUFF
    -- yo punni01 im doing ts rn
    ball = {}
    ball.radius = 15
    ball.max_x = window_X-ball.radius
    ball.min_x = 0+ball.radius
    ball.x = math.random(ball.min_x, ball.max_x)
    ball.y = 0
    ball.max_speed = 10
    ball.min_speed = 5
    ball.speed = math.random(ball.min_speed, ball.max_speed)
    print(ball.speed)
end
-- lmfao what is this wretched piece of shit
function love.update(dt)
    -- SEEDING THE BALL.SPEED RANDOM HERE
    -- The code is autistic....
    -- But it works!
    math.randomseed(os.time())
    ball.speed = math.random(3,math.random(ball.min_speed, ball.max_speed)) -- this is the autistic part of the code!
    print(ball.speed)
    -- note to self: DO *NOT* use ELSEIF statements because then the individual movements are not independent.. 

    -- set speed to < 5
    -- idk man what should the speed be?!

    

    -- hopefully boundary collisions

    
    -- how it works: 
    -- idk
    if player.x + player.radius > 800 then
        player.touching_border = true
        player.x = 800 - player.radius
    elseif player.x - player.radius < 0 then
        player.touchingborder = true
        player.x = player.radius
    end

    -- movement
    -- i fucking removed up and down movement BECAUSE i wanna make the player as autistic as me (he can only go sideways)
    if love.keyboard.isDown("lshift") then
        player.speed = 15
    else
        player.speed = 5
    end
    
    if love.keyboard.isDown("d") then
        player.x = player.x + player.speed
    end
    if love.keyboard.isDown("a") then
        player.x = player.x - player.speed
    end
    -- how do i do ts :broken_heart:
    -- ball logic here:
    -- i think
    -- idk
    --ok
    if game_running == true then
        ball.y = ball.y + ball.speed
    end
    
end

function love.draw()
    love.graphics.circle("fill",player.x,player.y,player.radius)
    love.graphics.circle("fill", ball.x, ball.y, ball.radius)
    -- boi wtf why is this not working
end 