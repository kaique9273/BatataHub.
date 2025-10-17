--#version: 3.1
-- ================================================
-- 🌟 Batata Hub v1.0 | Criador: Lk (coringakaio)
-- Totalmente compatível com Delta, Fluxus e Codex
-- ================================================

-- 🔔 Função de notificação (console + tela)
local function notify(title, text, duration)
    -- Console
    print("[🔹 " .. title .. "] " .. text)
    -- Notificação visual
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 6
        })
    end)
end

-- Carrega WindUI
local success, WindUI = pcall(function()
    return loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua", true))()
end)

if not success then
    warn("[BatataHub] ❌ Falha ao carregar WindUI.")
    notify("❌ Erro", "Falha ao carregar WindUI.", 6)
    return
end

-- Cria janela principal
local Window = WindUI:CreateWindow({
    Title = "Batata Hub v1.0",
    Icon = "door-open",
    Author = "Owner Lk",
    Folder = "BatataHub",
    Size = UDim2.fromOffset(580, 520),
    MinSize = Vector2.new(560, 400),
    MaxSize = Vector2.new(850, 600),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = false,
    ScrollBarEnabled = true,
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            print("[BatataHub] Botão de usuário clicado.")
        end,
    },
})

-- Notificação e log inicial
notify("✅ BatataHub", "Painel carregado com sucesso!\nVersão 1.0 - Criador: Lk", 6)

-- ================================================
-- 📘 ABA DE INFORMAÇÕES
-- ================================================
local InfoTab = Window:Tab({
    Title = "Informações",
    Icon = "info",
    Locked = false,
})

InfoTab:Paragraph({Title = "👤 Criador: Lk"})
InfoTab:Paragraph({Title = "💬 Discord: coringakaio"})
InfoTab:Paragraph({Title = "📦 Versão: 1.0"})
InfoTab:Paragraph({Title = "📌 Script Batata Hub totalmente customizado"})
InfoTab:Paragraph({Title = "✨ Funcionalidades:\n- Speed ajustável\n- Super Jump\n- Noclip\n- Estilo Moderno (Drip)"})
InfoTab:Paragraph({Title = "⚙️ Compatível com:\n- Delta\n- Fluxus\n- Codex"})
InfoTab:Paragraph({Title = "💡 Dica: use com cuidado e divirta-se!"})

InfoTab:Button({
    Title = "📋 Copiar Discord",
    Callback = function()
        if setclipboard then
            setclipboard("coringakaio")
            notify("📋 Copiado", "Seu Discord foi copiado!", 4)
        else
            warn("[BatataHub] Seu executor não suporta copiar texto.")
        end
    end,
})

InfoTab:Button({
    Title = "🔗 Copiar Link do Servidor",
    Callback = function()
        local link = "https://discord.gg/seuservidor"
        if setclipboard then
            setclipboard(link)
            notify("🔗 Copiado", "Link do servidor copiado!", 4)
        end
    end,
})

-- ================================================
-- 🧍 ABA PLAYER
-- ================================================
local PlayerTab = Window:Tab({
    Title = "Player",
    Icon = "user",
    Locked = false,
})

PlayerTab:Paragraph({
    Title = "🎮 Controle seu personagem",
    Content = "Use os sliders para ajustar Speed e Jump em tempo real."
})

-- Configurações iniciais
local cfg = {
    speedValue = 70,
    jumpValue = 50,
    speedEnabled = false,
    jumpEnabled = false,
    noclip = false
}

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid")

-- Funções de atualização
local function updateSpeed()
    if humanoid then
        humanoid.WalkSpeed = cfg.speedEnabled and cfg.speedValue or 16
    end
end

local function updateJump()
    if humanoid then
        humanoid.JumpPower = cfg.jumpEnabled and cfg.jumpValue or 50
    end
end

-- Toggles e Sliders
PlayerTab:Toggle({
    Title = "⚡ Ativar Speed",
    Default = false,
    Callback = function(state)
        cfg.speedEnabled = state
        updateSpeed()
        notify("⚡ Speed", state and "Speed ativado!" or "Speed desativado.", 4)
    end,
})

PlayerTab:Slider({
    Title = "Velocidade",
    Step = 1,
    Value = { Min = 20, Max = 120, Default = cfg.speedValue },
    Callback = function(value)
        cfg.speedValue = value
        updateSpeed()
        print("[BatataHub] Velocidade ajustada para: " .. value)
    end,
})

PlayerTab:Toggle({
    Title = "🦘 Ativar Super Jump",
    Default = false,
    Callback = function(state)
        cfg.jumpEnabled = state
        updateJump()
        notify("🦘 Super Jump", state and "Ativado!" or "Desativado.", 4)
    end,
})

PlayerTab:Slider({
    Title = "Força do Pulo",
    Step = 1,
    Value = { Min = 10, Max = 200, Default = cfg.jumpValue },
    Callback = function(value)
        cfg.jumpValue = value
        updateJump()
        print("[BatataHub] Força do pulo: " .. value)
    end,
})

-- ================================================
-- 🫥 ABA NOCLIP
-- ================================================
local TrollTab = Window:Tab({
    Title = "Noclip",
    Icon = "ghost",
    Locked = false,
})

TrollTab:Toggle({
    Title = "🫥 Ativar Noclip",
    Default = false,
    Callback = function(value)
        cfg.noclip = value
        notify("🫥 Noclip", value and "Noclip ativado!" or "Noclip desativado.", 4)
        print("[BatataHub] Noclip está:", value)
    end,
})

game:GetService("RunService").Stepped:Connect(function()
    if cfg.noclip and player.Character then
        for _, part in ipairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- ================================================
print("[✅ BatataHub] Carregado com sucesso! Última atualização: " .. os.date("%d/%m/%Y %H:%M:%S"))
notify("✅ BatataHub", "Carregado com sucesso!\nData: " .. os.date("%d/%m/%Y %H:%M:%S"), 6)
