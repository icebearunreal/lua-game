-- clankers can define variables here
-- test
local text = ""

-------------------------------------------

function love.load()
    game = {}
    game.gameState = "splash"
    game.not_dead = true
    game.score = 0
    love.window.setTitle("Catch em balls bruh")
    -- so apparently, the default window size is 800x600... idk if 600 is y or x because im autistic
    -- i want the circle guy to be in the lower section so like
    -- perfect it has to be 400..
    -- x should start in the middle so 400?
    -- nevermind love provides functions for that
    
    math.randomseed(os.time())

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
    
    -- multiple ball prelogic
    balls = {}
    spawnTimer = 0
    spawnDelay = 2
    
    -- 😑😑😑
    local firstBall = {
        radius = ball.radius,
        x = math.random(ball.min_x, ball.max_x),
        y = ball.y,
        speed = math.random(ball.min_speed, ball.max_speed)
    }
    table.insert(balls, firstBall)
    
    -- Splash screen variables
    splashScreenTimer = 0
    splashScreenDuration = 3
end

-- lmfao what is this wretched piece of shit
function love.update(dt)
    if game.gameState == "splash" then
        splashScreenTimer = splashScreenTimer + dt
        if splashScreenTimer >= splashScreenDuration then
            game.gameState = "running"
        end
        return
    end

    if game.gameState == "gameOver" then
        return
    end

    -- fix the timing
    spawnTimer = spawnTimer + dt 
    if spawnTimer >= spawnDelay then
        local newBall = {
            radius = ball.radius,
            x = math.random(ball.min_x, ball.max_x),
            y = -ball.radius,
            speed = math.random(ball.min_speed, ball.max_speed)
        }
        table.insert(balls, newBall)
        spawnTimer = 0
    end
    -- SEEDING THE BALL.SPEED RANDOM HERE
    -- The code is autistic....
    -- But it works!
    -- This was removed because it should only be called once in love.load()
    -- ball.speed = math.random(3,math.random(ball.min_speed, ball.max_speed)) -- this is the autistic part of the code!
    -- print(ball.speed)

    -- note to self: DO *NOT* use ELSEIF statements because then the individual movements are not independent.. 

    -- set speed to < 5
    -- idk man what should the speed be?!
    
    -- hopefully boundary collisions
    if player.x + player.radius > window_X then
        player.touching_border = true
        player.x = window_X - player.radius
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
    -- logic to have more than 1 ball and like spawn em and shi
    -- ok
    for i = #balls, 1, -1 do
        local currentBall = balls[i]
        if game.gameState == "running" then
            currentBall.y = currentBall.y + currentBall.speed
        end
        
        -- Collision detection
        local distance = math.sqrt((player.x - currentBall.x)^2 + (player.y - currentBall.y)^2)
        local combined_radius = player.radius + currentBall.radius
        if distance < combined_radius then
            game.gameState = "gameOver"
        end

        -- Check if ball is off screen
        if currentBall.y > window_Y + currentBall.radius then
            table.remove(balls, i)
            game.score = game.score + 1
        end
    end
end

function love.draw()
    if game.gameState == "splash" then
        love.graphics.printf("Dodge em balls bruh\n\nStarting in " .. tostring(math.ceil(splashScreenDuration - splashScreenTimer)) .. " seconds...", 0, window_Y / 2, window_X, "center")
    elseif game.gameState == "running" or game.gameState == "gameOver" then
        love.graphics.circle("fill",player.x,player.y,player.radius)
        -- boi wtf why is this not working
        -- its owrking
        -- the thang was im autistic
        -- ok i think we gotta draw balls in a loop
        for i, currentBall in ipairs(balls) do
            -- !!!!! thank you reddit
            love.graphics.circle("line", currentBall.x, currentBall.y, currentBall.radius)
        end
        
        love.graphics.printf("your score:" .. tostring(game.score), 10, 10, window_X, "left")

        if game.gameState == "gameOver" then
            love.graphics.printf("GGs chat you died!", 0, window_Y / 2, window_X, "center")
        end
    end
end
