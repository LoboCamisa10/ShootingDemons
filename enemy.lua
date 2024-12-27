local Bullet = require("bullet")

local Enemy = Bullet:extend()

function Enemy:new(x, y, image)
    self.image = love.graphics.newImage(image)
    -- local window_height = love.graphics.getHeight()
    self.x = x --or 400
    self.y = y --or window_height - 80
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.speed = 100
end

function Enemy:Shooting(_)
    table.insert(ListOfBulletsEnemy, Bullet(self.x, self.y, "imgs/punho.png", 1, 0.2, 'up'))
end

function Enemy:update(dt)
    self.x = self.x + self.speed * dt

    local window_width = love.graphics.getWidth()
    -- Faz o inimigo ir e vir ao encostar no limite da janela do Love.
    if self.x < 0 then
        self.x = 0
        self.speed = -self.speed
    elseif self.x + self.width > window_width then
        self.x = window_width - self.width
        self.speed = -self.speed
    end
end

function Enemy:draw()
    --Cria uma borda colorida ao redor da imagem do personagem para enxergar o "HITBOX"
    -- local old_c = {}
    -- old_c.r, old_c.g, old_c.b, old_c.a = love.graphics.getColor()

    -- love.graphics.setColor(0, 0, 255)
    -- love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    -- love.graphics.setColor(old_c.r, old_c.g, old_c.b, old_c.a)

    love.graphics.draw(self.image, self.x, self.y)
end

return Enemy