local cartas = {
    "acdcfd",
    "8d0e5a",
    "41bc9b",
    "e6ae25",
    "0b10b4",
    "098025",
    "c046b7"
}

local posicoesOriginais = {}
local indiceAtual = 1

function onLoad()
    Wait.time(function()
        for i, guid in ipairs(cartas) do
            local carta = getObjectFromGUID(guid)
            if carta then
                posicoesOriginais[guid] = carta.getPosition()
            end
        end
        print("Posições originais das cartas foram salvas.")
    end, 2)

    Wait.time(function()
        -- Adicionar o botão "MOVER" após o atraso de 2.5 segundos
        local carta = getObjectFromGUID("2f88d1")
        if carta then
            carta.createButton({
                click_function = "onClickMover",
                function_owner = self,
                label = "<- MOVE",
                position = {carta.getPosition().x - 12.55, carta.getPosition().y + 2.5, carta.getPosition().z - 1.5},
                rotation = {0, 0, 0},
                width = 1150,
                height = 150,
                font_size = 120,
            })
        else
            print("Carta não encontrada. Verifique o GUID.")
        end

        -- Adicionar o botão "Reset" após o atraso de 2.5 segundos
        self.createButton({
            click_function = "onClickReset",
            function_owner = self,
            label = "Reset",
            position = {0, 1, 0}, -- Ajuste a posição conforme necessário
            rotation = {0, 0, 0},
            width = 200,
            height = 80,
            font_size = 50,
        })
    end, 2.5)
end

function onClickMover()
    local cartaMovida = getObjectFromGUID("2f88d1")
    local cartaAlvo = getObjectFromGUID(cartas[indiceAtual])

    if cartaMovida and cartaAlvo then
        local posicaoMovida = cartaMovida.getPosition()
        local posicaoAlvo = cartaAlvo.getPosition()

        cartaMovida.setPositionSmooth(posicaoAlvo)
        cartaAlvo.setPositionSmooth(posicaoMovida)

        indiceAtual = (indiceAtual % #cartas) + 1

        Wait.time(function()
            cartaAlvo.flip()
        end, 0.5)
    else
        print("Cartas não encontradas. Verifique os GUIDs.")
    end
end

function onClickReset()
    for guid, posicaoOriginal in pairs(posicoesOriginais) do
        local carta = getObjectFromGUID(guid)
        if carta then
            carta.setPositionSmooth(posicaoOriginal)
        end
    end
    print("Cartas restauradas para suas posições originais.")
end