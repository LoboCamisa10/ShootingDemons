local Bullet = require("bullet")

local Player = Bullet:extend()

function Player:new(x, y, image, y_direction)
    -- Player.super.new(self, x, y, image,y_direction)
    self.image = love.graphics.newImage('imgs/tanjiro.png')
    self.x = x --or 400
    self.y = y --or 30
    self.speed = 400
    self.width = self.image:getWidth()
    self.height = self.image.getHeight(self.image)
end

--Cria e adiciona uma nova bala na ListOfBulletsPlayer em main.lua
function Player:keyPressed(key)
    if key == "space" then
        table.insert(ListOfBulletsPlayer, Bullet(self.x, self.y, "imgs/katana.png", 1, 0,'down'))
    end
end

function Player:score(Cont, ScoreMax)
    -- Set the color to red (RGB: 1, 0, 0) and fully opaque
    love.graphics.setColor(0, 0, 0)  -- Red color

    -- Draw the text
    love.graphics.print("Acertos: ".. Cont, 5, 5, 0, 1.3, 1.1)
    love.graphics.print("Pontuação Máxima: ".. ScoreMax, 5, 23, 0, 1.3, 1.1)

    -- Reset color to white (default)
    love.graphics.setColor(1, 1, 1)  -- Reset to white

end

function Player:draw()
    --Cria uma borda colorida ao redor da imagem do personagem para enxergar o "HITBOX"
    -- local old_c = {}
    -- old_c.r, old_c.g, old_c.b, old_c.a = love.graphics.getColor()

    -- love.graphics.setColor(255, 0, 0)
    -- love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    -- love.graphics.setColor(old_c.r, old_c.g, old_c.b, old_c.a)

    love.graphics.draw(self.image, self.x, self.y)
end

function Player:update(dt)
    if love.keyboard.isDown("left") then
        self.x = self.x - self.speed * dt
    elseif love.keyboard.isDown("right") then
        self.x = self.x + self.speed * dt
    end
    --Pega a largura da janela do LOVE(ou seja, o limite do lado direito da janela do love)
    local window_width = love.graphics.getWidth()

    if self.x < 0 then
        self.x = 0

    elseif self.x + self.width > window_width then
        self.x = window_width - self.width
    end
end

return Player