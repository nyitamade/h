-- Moonsploit

local player = game.Players.LocalPlayer
local input = game:GetService("UserInputService")
local run = game:GetService("RunService")

local SPEED = 300
local bodyVelocity = nil

input.InputBegan:Connect(function(key)
    if key.KeyCode ~= Enum.KeyCode.F then
        return
    end

    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
        return
    end

    local root = player.Character.HumanoidRootPart

    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    bodyVelocity.Parent = root
end)

run.RenderStepped:Connect(function()
    if not bodyVelocity then return end

    local camera = workspace.CurrentCamera
    local direction = Vector3.new(0, 0, 0)

    if input:IsKeyDown(Enum.KeyCode.W) then direction = direction + camera.CFrame.LookVector end
    if input:IsKeyDown(Enum.KeyCode.S) then direction = direction - camera.CFrame.LookVector end
    if input:IsKeyDown(Enum.KeyCode.A) then direction = direction - camera.CFrame.RightVector end
    if input:IsKeyDown(Enum.KeyCode.D) then direction = direction + camera.CFrame.RightVector end
    if input:IsKeyDown(Enum.KeyCode.Space) then direction = direction + Vector3.new(0, 1, 0) end
    if input:IsKeyDown(Enum.KeyCode.LeftControl) then direction = direction - Vector3.new(0, 1, 0) end

    if direction.Magnitude > 0 then
        bodyVelocity.Velocity = direction.Unit * SPEED
    else
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    end
end)
