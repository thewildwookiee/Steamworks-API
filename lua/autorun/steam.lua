AddCSLuaFile("steam.lua")

if (SERVER) then
	include("steam/server.lua")
else
	include("steam/client.lua")
end