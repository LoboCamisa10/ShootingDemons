Cont = 0
ScoreMax = 0

function love.load()
    Class = require "classic"
    local Player = require("player")
    local Enemy = require("enemy")
    require("bullet")

    player = Player(400, 30, 'up')
    enemy = Enemy(400, love.graphics.getHeight() - 80, "imgs/demon.png")

    --Lista de CLASSES com um CONSTRUTOR INICIANDO VARIÁVEIS das BALAS que estão sendo criadas sempre que aperta SPACE!
    ListOfBulletsPlayer = {}
    ListOfBulletsEnemy = {}

end

function love.update(dt)
    --Chama a função update do arquivo player.lua, criando a função de MOVIMENTO DO PLAYER
    player:update(dt)
    --Chama a função update do arquivo enemy.lua, criando a função de MOVIMENTO DO INIMIGO
    enemy:update(dt)

    if love.timer.getTime() % 2 < 0.02  then
        enemy:Shooting()
    end
    
    --Itera sobre a lista de balas,calcula o DELTATIME delas e atualiza o movimento delas na tela
    for number, value in ipairs(ListOfBulletsPlayer) do
        --Itera sobre a lista de balas do PLAYER chamando a função update do arquivo bullet.lua atualizando o DISPARO DO PLAYER na tela.
        value:update(dt)

        --Checa se cada bala vai ter um colisão com o INIMIGO
        value:checkCollision(enemy)
        if value.dead then
            Cont = Cont + 1
            table.remove(ListOfBulletsPlayer, number)
        end
        if Cont > ScoreMax then
            ScoreMax = Cont
        else
            ScoreMax = ScoreMax
        end
    end
    --Itera sobre a lista de balas inimigas chamando a função update do arquivo bullet.lua atualizando o DISPARO INIMIGO na tela.
    for index, value in ipairs(ListOfBulletsEnemy) do
        value:update(dt)

        --Checa se cada bala inimiga vai ter um colisão com o PLAYER
        value:checkCollision(player)
        if value.dead then
            Cont = 0
            love.load()
        end
    end
end

function love.draw()

    love.graphics.setBackgroundColor(190/255, 221/255, 211/255, 1)
    player:score(Cont, ScoreMax)--Desenha a pontuação do jogador na tela(CUIDADO, ao usar essa função, as variáveis de cont e scoreMax PRECISAM SER GLOBAIS)
    player:draw()--Desenha o jogador na tela
    enemy:draw()--Desenha o inimigo na tela
    
    --Itera sobre a lista de balas e desenha cada uma delas na tela do LOVE.
    for _, value in ipairs(ListOfBulletsPlayer) do
        value:draw()
    end

    for index, value in ipairs(ListOfBulletsEnemy) do
        value:draw()
    end
end

function love.keypressed(key)
    player:keyPressed(key)
end