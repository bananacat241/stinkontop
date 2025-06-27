
-- onnii's Whitelist Loader with API Key + HWID check
local http = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local hwid = tostring(game:GetService("RbxAnalyticsService"):GetClientId())
local key = getgenv().Key

local success, response = pcall(function()
    return game:HttpGet("https://lttn-repli.replit.dev/validate?key=" .. key .. "&hwid=" .. hwid)
end)

if not success or not response then
    LocalPlayer:Kick("⚠️ Không thể kết nối tới hệ thống xác minh.")
    return
end

if response:lower():sub(1, 4) == "kick" then
    local reason = response:match("%((.-)%)") or "UNAUTHORIZED"
    LocalPlayer:Kick(reason)
    return
end

local execute = loadstring(response)
if typeof(execute) == "function" then
    execute()
else
    LocalPlayer:Kick("⚠️ Script phản hồi không hợp lệ.")
end
