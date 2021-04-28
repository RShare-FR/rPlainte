print("^4RShare-FR - https://github.com/iTexZoz/RageUI - OpenSource Advanced UI Api^0")
ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
    
end)


function KeyboardInput(textEntry, inputText, maxLength)
    AddTextEntry('FMMC_KEY_TIP1', textEntry)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", inputText, "", "", "", maxLength)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(1.0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        return result
    else
        Citizen.Wait(500)
        return nil
    end
end



local rPlainte
RMenu.Add('rPlainte', 'main', RageUI.CreateMenu(nil, "", 10,222,"police2", "interaction_bgd"))
RMenu:Get('rPlainte', 'main'):SetSubtitle("~b~Remplissez votre plainte :")
RMenu:Get('rPlainte', 'main').EnableMouse = false
RMenu:Get('rPlainte', 'main').Closed = function()
	rPlainte = false
end


function IsDateCorrect(date)
    if (string.match(date, "^%d+%p%d+%p%d%d%d%d$")) then
        local d, m, y = string.match(date, "(%d+)%p(%d+)%p(%d+)")
        d, m, y = tonumber(d), tonumber(m), tonumber(y)
        local dm2 = d*m*m
        if  d>31 or m>12 or dm2==0 or dm2==116 or dm2==120 or dm2==124 or dm2==496 or dm2==1116 or dm2==2511 or dm2==3751 then
            if dm2==116 and (y%400 == 0 or (y%100 ~= 0 and y%4 == 0)) then
                return true
            else
                return false
            end
        else
            return true
        end
    else
        return false
    end
end




function openPlainte()
	if not rPlainte then
        rPlainte = true
        local telephone = nil 
        local contre = nil
        local nprenom = nil
        local date = nil
        local texte = nil
        RageUI.Visible(RMenu:Get('rPlainte', 'main'), true)
        
	Citizen.CreateThread(function()
        while rPlainte do
            
			Citizen.Wait(1)
                RageUI.IsVisible(RMenu:Get('rPlainte', 'main'), true, true, true, function()
                    RageUI.ButtonWithStyle("Numéro de téléphone :", nil ,{RightLabel = telephone}, true, function(Hovered, Active, Selected) 
                        if (Selected) then 
                        local phone = KeyboardInput('Exemple : 555-8174', "", 8)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0);
                           Citizen.Wait(1)
                        end
                        if (GetOnscreenKeyboardResult()) then
                            telephone = GetOnscreenKeyboardResult()
                            if telephone == nil then
                               ESX.ShowNotification('~r~Vous devez entrer un numéro de téléphone.')
                            end
                        end 
                    end 
                end)
                    RageUI.ButtonWithStyle("Prénom et nom :", nil ,{RightLabel = nprenom}, true, function(Hovered, Active, Selected) 
                        if (Selected) then 
                        local name = KeyboardInput('Exemple : Jhon Aaron', "", 20)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0);
                           Citizen.Wait(1)
                        end
                        if (GetOnscreenKeyboardResult()) then
                            nprenom = GetOnscreenKeyboardResult()
                            if nprenom == nil then
                               ESX.ShowNotification('~r~Vous devez entrer un prénom et un nom.')
                            end
                        end 
                    end 
                end)
                RageUI.ButtonWithStyle("Contre :", nil ,{RightLabel = contre}, true, function(Hovered, Active, Selected) 
                                if (Selected) then 
                                local acontre = KeyboardInput('Exemple : Pablo Escobar', "", 20)
                                while (UpdateOnscreenKeyboard() == 0) do
                                    DisableAllControlActions(0);
                                Citizen.Wait(1)
                                end
                                if (GetOnscreenKeyboardResult()) then
                                contre = GetOnscreenKeyboardResult()
                                if contre == nil then
                                ESX.ShowNotification('~r~Vous devez entrer une personne contre qui vous voulez porter plainte.')
                            end
                        end 
                    end 
                end)
                    RageUI.ButtonWithStyle("Date des faits :", nil ,{RightLabel = date}, true, function(Hovered, Active, Selected) 
                            if (Selected) then 
                            local adate = KeyboardInput('Exemple : 14/11/2020', "", 20)
                            while (UpdateOnscreenKeyboard() == 0) do
                                DisableAllControlActions(0);
                               Citizen.Wait(1)
                            end
                            if (GetOnscreenKeyboardResult()) then
                                date = GetOnscreenKeyboardResult()
                                if date == nil then
                                   ESX.ShowNotification('~r~Vous devez entrer une date')
                                end
                            end 
						end 
                    end)
                    RageUI.ButtonWithStyle("Faîts :", nil ,{RightLabel = ''}, true, function(Hovered, Active, Selected) 
                        if (Selected) then 
                        local desc = KeyboardInput('Il faut decrire ce qu\'il c\'est passer.', "", 800)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0);
                           Citizen.Wait(1)
                        end
                        if (GetOnscreenKeyboardResult()) then
                            texte = GetOnscreenKeyboardResult()
                            if texte == nil then
                               ESX.ShowNotification('~r~Vous devez entrer un texte')
                            end
                        end 
                    end 
                end)
                    numeroplainte = math.random(0, 999999)
                    RageUI.ButtonWithStyle("Enregistrer", nil ,{RightLabel = '', Color = { BackgroundColor = RageUI.ItemsColour.Green }}, true, function(Hovered, Active, Selected)
                        if (Selected) then 
                            local troll = GetPlayerName(PlayerId())
                                if (telephone == nil or telephone == '~b~') then
                                ESX.ShowNotification('~r~Veuillez remplir votre numéro de téléphone.')
                                elseif (nprenom == nil or nprenom == '~b~') then
                                ESX.ShowNotification('~r~Veuillez remplir vôtre ~r~nom et prénom~s~.')
                                elseif (contre == nil or contre == '~b~') then
                                ESX.ShowNotification('~r~Vous avez oublié une case..')
                                elseif (date == nil or date == '~b~') then
                                ESX.ShowNotification('~r~Veuillez remplir la date.')
                                elseif (texte == nil or texte == '~b~') then
                                ESX.ShowNotification('~r~Veuillez remplir une description.')
                                else
                                TriggerServerEvent('plaintelspd', numeroplainte, telephone, nprenom, contre, date, texte, troll)
                                RageUI.CloseAll()
                                rPlainte = false
                                ESX.ShowNotification('~b~Votre plainte a bien été enrengister. \nUn agent vous contactera.')
                            end
						end 
					end)
				end)
			end
		end)
	end
end





-- Marker à la police



Citizen.CreateThread(function()
    while true do
        local interval = 1
        local pos = GetEntityCoords(PlayerPedId())
        local dest = vector3(440.87, -981.12, 30.68)
        local distance = GetDistanceBetweenCoords(pos, dest, true)

        if distance > 2 then
            interval = 200
        else
            interval = 1
            DrawMarker(22, 440.87, -981.12, 30.68, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 160, 0, 0, 170, 1, 1, 2, 0, nil, nil, 0)
            if distance < 1 then  
                AddTextEntry("HELP", "Appuyez sur ~INPUT_CONTEXT~ ~s~pour porter plainte.")
                DisplayHelpTextThisFrame("HELP", false)
                if IsControlJustPressed(1, 51) then
                    openPlainte()
                end
            end
        end
        Citizen.Wait(interval)
    end
end)
