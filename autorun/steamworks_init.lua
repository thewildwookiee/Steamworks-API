AddCSLuaFile("steamworks_init.lua")

if (SERVER) then
	include("steamworks/server.lua")
else
	include("steamworks/client.lua")
end