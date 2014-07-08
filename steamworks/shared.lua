steamworks 		= steamworks or {}

steamworks.URL	= "http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=%s&steamids=%s"
steamworks.API 	= "" -- Not gonna leave mine in there... :V

--[[

	Description:
	Utilizes Steam's API to grab info via a 64 bit SteamID.

	Function:
	steamworks.GetPlayerSummary
	
	Arguments:
	string SteamID64
	function callback
	
	Returns:
	table summary

--]]

function steamworks.GetPlayerSummary(SteamID64,callback)

	local fetch = string.format(steamworks.URL,tostring(steamworks.API),tostring(SteamID64))
	local time	= SysTime()

	local success = function(body,len,headers,code)

		local json = body and util.JSONToTable(tostring(body)) or {}

		if callback then
			util.LibraryPrint(steamworks,"Fetched player summary in "..math.round(SysTime() - time,4).." seconds.")
			callback(json.response.players and json.response.players[1] or {})
		end

	end

	local failure = function(error)
		util.LibraryPrint(steamworks,"Failed to retrieve player summary.")
	end
	
	util.LibraryPrint(steamworks,"Fetching player summary...")
	http.Fetch(fetch,success,failure)

end

--[[
	Example API usage
--]]

--[[

local Kirkenz = "76561197998857914"

steamworks.GetPlayerSummary(Kirkenz,function(response)

	if (CLIENT) then
		util.LibraryPrint(steamworks,"Hi, "..response.personaname.."!")
		util.LibraryPrint(steamworks,"Your real name is: "..response.realname..".")
		util.LibraryPrint(steamworks,"Your profile URL is: "..response.profileurl..".")
		util.LibraryPrint(steamworks,"You are currently playing: "..response.gameextrainfo..".")
	
	end

end)

--]]