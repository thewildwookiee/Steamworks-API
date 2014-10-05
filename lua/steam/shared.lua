include("enums.lua")

-- Localized Functions
local FETCH = http.Fetch

local jDEC 	= util.JSONToTable
local jENC 	= util.TableToJSON

steam 		= steam or {}
steam.API 	= "179B7845272B1A5BA03238192A9DBBBE"

steam.URL	= "http://api.steampowered.com/"

--[[

	Description:
	Makes the Steam library print in its own format.
	
	Arguments:
	... (various arguments, separated by commas)
	
	Returns:
	nil

	Example:
	steam.print(512,"string",true)

--]]

local COLOR_STEAM = Color(150,200,255)

function steam.print(...)

	args = {...}

	MsgC(COLOR_STEAM,"[",COLOR_WHITE,"steamworks",COLOR_STEAM,"]",COLOR_WHITE,": ")
	Msgc(unpack(args))

end

--[[

	Description:
	Utilizes Steam's API to grab info via a 64 bit SteamID.
	
	Arguments:
	string SteamID64
	function callback
	
	Returns:
	table summary

	Example:
	steam.GetPlayerSummary("76561197998857914",function(response)

		if (CLIENT) then
			util.LibraryPrint(steam,"Hi, "..response.personaname.."!")
			util.LibraryPrint(steam,"Your real name is: "..response.realname..".")
			util.LibraryPrint(steam,"Your profile URL is: "..response.profileurl..".")
			util.LibraryPrint(steam,"You are currently playing: "..response.gameextrainfo..".")
		
		end

	end)

--]]

function steam.GetPlayerSummary(SteamID64,callback)

	steam.print("Fetching player summary...")

	local FETCH_TIME = SysTime()

	FETCH(steam.URL.."/ISteamUser/GetPlayerSummaries/v0002/?key="..steam.API.."&steamid="..tostring(SteamID64).."&format=json",

--		OnSuccess
		function(body,len,headers,code)

			local json = body and jDEC(tostring(body)) or {}

			steam.print("Fetched player summary!")
			callback(json.response.players and json.response.players[1] or {})

		end,

--		OnFailure
		function(error)
			steam.print("Failed to retrieve player summary.")
		end

	)

end

--[[

	Description:
	Utilizes Steam's API to grab info via a 64 bit SteamID.
	
	Arguments:
	string SteamID64
	function callback
	
	Returns:
	table friends

	Example:
	steam.GetFriendList("76561197998857914",function(response)

	end)

--]]

function steam.GetFriendList(SteamID64,callback)

	FETCH(steam.URL.."ISteamUser/GetFriendList/v0001/?key="..steam.API.."&steamid="..tostring(SteamID64).."&format=json",

--		OnSuccess
		function(body,len,headers,code)
			callback(jDEC(body))
		end,

--		OnFailure
		function(error)
			steam.print("Failed to retrieve friend list.")
	    end

    )
end

--[[

	Description:
	Utilizes Steam's API to grab info via a 64 bit SteamID.
	
	Arguments:
	string SteamID64
	function callback
	
	Returns:
	table bans

	Example:
	steam.GetPlayerBans("76561197998857914",function(response)

	end)

--]]

function steam.GetPlayerBans(SteamID64,callback)

	FETCH(steam.URL,"ISteamUser/GetPlayerBans/v1/?key="..steam.API.."&steamid="..SteamID64.."&format=json"

--		OnSuccess
		function(body,len,headers,code)
			callback(jDEC(body))
		end,

--		OnFailure
		function(error)
			steam.print("Failed to retrieve player bans.")
	    end
	)

end

--[[

	Description:
	Utilizes Steam's API to grab info via a 64 bit SteamID.
	
	Arguments:
	string SteamID64
	function callback
	
	Returns:
	table level (?)

	Example:
	steam.GetPlayerLevel("76561197998857914",function(response)

	end)

--]]

function steam.GetPlayerLevel(SteamID64,callback)

	FETCH(steam.URL,"IPlayerService/GetSteamLevel/v1/?key="..steam.API.."&steamid="..SteamID64.."&format=json"

--		OnSuccess
		function(body,len,headers,code)
			callback(jDEC(body))
		end,

--		OnFailure
		function(error)
			steam.print("Failed to retrieve player level.")
	    end
	)

end

--[[

	Description:
	Utilizes Steam's API to grab info via a 64 bit SteamID.
	
	Arguments:
	string SteamID64
	function callback
	string API_SERVICE
	string API_NAME
	string API_VERSION
	
	Returns:
	table data

	Example:
	steam.FetchData("76561197998857914","ISteamUser","GetPlayerSummaries","0002",function(response)

	end)

--]]

function steam.FetchData(SteamID64,callback,API_SERVICE,API_NAME,API_VERSION)

	FETCH(steam.URL,API_SERVICE.."/"..API_NAME.."/v"..API_VERSION.."/?key="..steam.API.."&steamid="..SteamID64.."&format=json"

--		OnSuccess
		function(body,len,headers,code)
			callback(jDEC(body))
		end,

--		OnFailure
		function(error)
			steam.print("Failed to retrieve data.")
	    end
	)

end