

local DISCORD_WEBHOOK = "INSERER VOTRE DISCORD WEBHOOK - INSERT YOUR DISCORD WEBHOOK"
local DISCORD_NAME = "Centrale LSPD"
local DISCORD_IMAGE = "https://i.imgur.com/rnMbgUi.png"


function GetIDFromSource(Type, ID)
    local IDs = GetPlayerIdentifiers(ID)
    for k, CurrentID in pairs(IDs) do
        local ID = stringsplit(CurrentID, ':')
        if (ID[1]:lower() == string.lower(Type)) then
            return ID[2]:lower()
        end
    end
    return nil
end

function stringsplit(input, seperator)
	if seperator == nil then
		seperator = '%s'
	end
	
	local t={} ; i=1
	
	for str in string.gmatch(input, '([^'..seperator..']+)') do
		t[i] = str
		i = i + 1
	end
	
	return t
end

function sendToDiscord(name, message, color)
  local connect = {
        {
            ["color"] = color,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "RShare-FR - 2020/2021",
            },
        }
    }
  PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end




RegisterServerEvent('plaintelspd')
AddEventHandler('plaintelspd',function(numeroplainte, telephone, nprenom, contre, date, texte, troll)
    sendToDiscord("Centrale LSPD", '```Numéro de téléphone : ' ..telephone.. '\n\nPrénom et nom : ' ..nprenom.. '\n\nÀ l\'encontre de : ' ..contre.. '\n\nDate des faîts : ' ..date.. '\n\nDescription : ' ..texte.. '\n\nNuméro de plainte : ' ..numeroplainte.. '\n\n\n(Utiliser en cas de troll) Pseudo Steam : ' ..troll..'```', 16711680)
end)

