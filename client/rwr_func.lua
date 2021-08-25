RWR = nil

Citizen.CreateThread(function()
  while RWR == nil do
    TriggerEvent('RWRCore:getSharedObject', function(obj) RWR = obj end)
    Citizen.Wait(1000)
  end
end)

local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

-- Ortam Seslerini Kapatır / Disable the Ambient Sounds

CreateThread(function()   
    StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE");
    SetAudioFlag("PoliceScannerDisabled",true);
end)


-- Polis araçlarının silah vermesini kapatır / 

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        id = PlayerId()
        DisablePlayerVehicleRewards(id)
    end
end)

-- CROSSHAIR Siler / Remove crosshair
Citizen.CreateThread(function()
	local isSniper = false
	while true do
Citizen.Wait(0)
	local ped = GetPlayerPed(-1)
	local currentWeaponHash = GetSelectedPedWeapon(ped)
	if currentWeaponHash == 100416529 then
	isSniper = true
	elseif currentWeaponHash == 205991906 then
	isSniper = true
 elseif currentWeaponHash == -952879014 then
	isSniper = true
 elseif currentWeaponHash == GetHashKey('WEAPON_HEAVYSNIPER_MK2') then
	isSniper = true
 else
	isSniper = false
		end
			if not isSniper then
			HideHudComponentThisFrame(14)
		end
	end
end)

-- Araç Dışı Minimap Kapatır / Disable minimap

Citizen.CreateThread(function()
    Citizen.Wait(10000)

    while true do
        local sleepThread = 500

        local radarEnabled = IsRadarEnabled()

        if not IsPedInAnyVehicle(PlayerPedId()) and radarEnabled then
            DisplayRadar(false)
        elseif IsPedInAnyVehicle(PlayerPedId()) and not radarEnabled then
            DisplayRadar(true)
        end

        Citizen.Wait(sleepThread)
    end
end)

-- NPC'lerin silahlarını siler / Remove NPC weapons

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
		
        for ped in EnumeratePeds() do
            if DoesEntityExist(ped) then
				if Config.NoGuns == true then
					if (GetEntityModel(ped) == GetHashKey(model)) then
						RemoveAllPedWeapons(ped, true)
					end
				end
				if Config.NoDrops == true then
					if (GetEntityModel(ped) == GetHashKey(model)) then
						SetPedDropsWeaponsWhenDead(ped,false) 
					end
				end
			end
		end
    end
end)

-- NPCLERDEN YERE DUSEN SILAHLARI SILER / Remove NPC Gun Drops
Citizen.CreateThread(function()
    while true do
      Citizen.Wait(10000)
      RemoveAllPickupsOfType(0xDF711959)
      RemoveAllPickupsOfType(0xF9AFB48F)
      RemoveAllPickupsOfType(0xA9355DCD)
    end
end)
  
-- PVP 
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		SetCanAttackFriendly(GetPlayerPed(-1), true, false)
		NetworkSetFriendlyFireOption(true)
	end
end)

-- PAUSE MENU NAME
function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
  AddTextEntry('FE_THDR_GTAO', '~p~RWR ~w~Core~y~/')
end)

-- ACIL SERVISLERI KAPATIR
Citizen.CreateThread(function()
	while true do
		Wait(1)
		for i = 1, 12 do
			EnableDispatchService(i, false)
		end
		SetPlayerWantedLevel(PlayerId(), 0, false)
		SetPlayerWantedLevelNow(PlayerId(), false)
		SetPlayerWantedLevelNoDrop(PlayerId(), 0, false)
	end
end)

-- PD SILER / Remove PD
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        local playerPed = GetPlayerPed(-1)
        local playerLocalisation = GetEntityCoords(playerPed)
            ClearAreaOfCops(playerLocalisation.x, playerLocalisation.y, playerLocalisation.z, 400.0)
    end
end)

-- [CTRL] Çömelme / Crouch
local crouched = false

Citizen.CreateThread( function()
    while true do 
        Citizen.Wait( 1 )

        local ped = GetPlayerPed( -1 )

        if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
            DisableControlAction( 0, 36, true ) -- INPUT_DUCK  

            if ( not IsPauseMenuActive() ) then 
                if ( IsDisabledControlJustPressed( 0, 36 ) ) then 
                    RequestAnimSet( "move_ped_crouched" )

                    while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do 
                        Citizen.Wait( 100 )
                    end 

                    if ( crouched == true ) then 
                        ResetPedMovementClipset( ped, 0 )
                        crouched = false 
                    elseif ( crouched == false ) then
                        SetPedMovementClipset( ped, "move_ped_crouched", 0.25 )
                        crouched = true 
                    end 
                end
            end 
        end 
    end
end)

-- [B] Parmakla Gösterme / Pointing
local mp_pointing = false
local keyPressed = false

local function startPointing()
    local ped = GetPlayerPed(-1)
    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do
        Wait(1000)
    end
    SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
    SetPedConfigFlag(ped, 36, 1)
    Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")
end

local function stopPointing()
    local ped = GetPlayerPed(-1)
    Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
    if not IsPedInjured(ped) then
        ClearPedSecondaryTask(ped)
    end
    if not IsPedInAnyVehicle(ped, 1) then
        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
    end
    SetPedConfigFlag(ped, 36, 0)
    ClearPedSecondaryTask(PlayerPedId())
end

local once = true
local oldval = false
local oldvalped = false

Citizen.CreateThread(function()
    while true do
        Wait(1)

        if once then
            once = false
        end

        if not keyPressed then
            if IsControlPressed(0, 29) and not mp_pointing and IsPedOnFoot(PlayerPedId()) then
                Wait(200)
                if not IsControlPressed(0, 29) then
                    keyPressed = true
                    startPointing()
                    mp_pointing = true
                else
                    keyPressed = true
                    while IsControlPressed(0, 29) do
                        Wait(50)
                    end
                end
            elseif (IsControlPressed(0, 29) and mp_pointing) or (not IsPedOnFoot(PlayerPedId()) and mp_pointing) then
                keyPressed = true
                mp_pointing = false
                stopPointing()
            end
        end

        if keyPressed then
            if not IsControlPressed(0, 29) then
                keyPressed = false
            end
        end
        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) and not mp_pointing then
            stopPointing()
        end
        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) then
            if not IsPedOnFoot(PlayerPedId()) then
                stopPointing()
            else
                local ped = GetPlayerPed(-1)
                local camPitch = GetGameplayCamRelativePitch()
                if camPitch < -70.0 then
                    camPitch = -70.0
                elseif camPitch > 42.0 then
                    camPitch = 42.0
                end
                camPitch = (camPitch + 70.0) / 112.0

                local camHeading = GetGameplayCamRelativeHeading()
                local cosCamHeading = Cos(camHeading)
                local sinCamHeading = Sin(camHeading)
                if camHeading < -180.0 then
                    camHeading = -180.0
                elseif camHeading > 180.0 then
                    camHeading = 180.0
                end
                camHeading = (camHeading + 180.0) / 360.0

                local blocked = 0
                local nn = 0

                local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
                nn,blocked,coords,coords = GetRaycastResult(ray)

                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", camPitch)
                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", camHeading * -1.0 + 1.0)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", blocked)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)

            end
        end
    end
end)

-- Araç İtekleme / Push the vehicle
local First = vector3(0.0, 0.0, 0.0)
local Second = vector3(5.0, 5.0, 5.0)

local Vehicle = {Coords = nil, Vehicle = nil, Dimension = nil, IsInFront = false, Distance = nil}
Citizen.CreateThread(function()
    Citizen.Wait(2000)
    while true do
        local ped = PlayerPedId()
        local closestVehicle, Distance = RWR.Functions.GetClosestVehicle()
        local vehicleCoords = GetEntityCoords(closestVehicle)
        local dimension = GetModelDimensions(GetEntityModel(closestVehicle), First, Second)
        if Distance < 6.0  and not IsPedInAnyVehicle(ped, false) then
            Vehicle.Coords = vehicleCoords
            Vehicle.Dimensions = dimension
            Vehicle.Vehicle = closestVehicle
            Vehicle.Distance = Distance
            if GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle), GetEntityCoords(ped), true) > GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle) * -1, GetEntityCoords(ped), true) then
                Vehicle.IsInFront = false
            else
                Vehicle.IsInFront = true
            end
        else
            Vehicle = {Coords = nil, Vehicle = nil, Dimensions = nil, IsInFront = false, Distance = nil}
        end
        Citizen.Wait(5000)
    end
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(5)
        local ped = PlayerPedId()
        if Vehicle.Vehicle ~= nil then
 
                if IsVehicleSeatFree(Vehicle.Vehicle, -1) and GetVehicleEngineHealth(Vehicle.Vehicle) <= Config.DamageNeeded then
                    -- RWR.DrawText3D({x = Vehicle.Coords.x, y = Vehicle.Coords.y, z = Vehicle.Coords.z}, 'Press [~g~SHIFT~w~] and [~g~E~w~] to push the vehicle', 0.4)
                end
     

            if IsControlPressed(0, Keys["LEFTSHIFT"]) and IsVehicleSeatFree(Vehicle.Vehicle, -1) and not IsEntityAttachedToEntity(ped, Vehicle.Vehicle) and IsControlJustPressed(0, Keys["E"])  and GetVehicleEngineHealth(Vehicle.Vehicle) <= Config.DamageNeeded then
                NetworkRequestControlOfEntity(Vehicle.Vehicle)
                local coords = GetEntityCoords(ped)
                if Vehicle.IsInFront then    
                    AttachEntityToEntity(PlayerPedId(), Vehicle.Vehicle, GetPedBoneIndex(6286), 0.0, Vehicle.Dimensions.y * -1 + 0.1 , Vehicle.Dimensions.z + 1.0, 0.0, 0.0, 180.0, 0.0, false, false, true, false, true)
                else
                    AttachEntityToEntity(PlayerPedId(), Vehicle.Vehicle, GetPedBoneIndex(6286), 0.0, Vehicle.Dimensions.y - 0.3, Vehicle.Dimensions.z  + 1.0, 0.0, 0.0, 0.0, 0.0, false, false, true, false, true)
                end

                RWR.Streaming.RequestAnimDict('missfinale_c2ig_11')
                TaskPlayAnim(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
                Citizen.Wait(2000)

                local currentVehicle = Vehicle.Vehicle
                 while true do
                    Citizen.Wait(5)
                    if IsDisabledControlPressed(0, Keys["A"]) then
                        TaskVehicleTempAction(PlayerPedId(), currentVehicle, 11, 1000)
                    end

                    if IsDisabledControlPressed(0, Keys["D"]) then
                        TaskVehicleTempAction(PlayerPedId(), currentVehicle, 10, 1000)
                    end

                    if Vehicle.IsInFront then
                        SetVehicleForwardSpeed(currentVehicle, -1.0)
                    else
                        SetVehicleForwardSpeed(currentVehicle, 1.0)
                    end

                    if HasEntityCollidedWithAnything(currentVehicle) then
                        SetVehicleOnGroundProperly(currentVehicle)
                    end

                    if not IsDisabledControlPressed(0, Keys["E"]) then
                        DetachEntity(ped, false, false)
                        StopAnimTask(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0)
                        FreezeEntityPosition(ped, false)
                        break
                    end
                end
            end
        end
    end
end)

-- NPC Araçlarını Kitler / Lock NPC Vehicles
Citizen.CreateThread(function()
    while true do
        Wait(0)
        local ped = GetPlayerPed(-1)
        if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId(ped))) then
            local veh = GetVehiclePedIsTryingToEnter(PlayerPedId(ped))
            local lock = GetVehicleDoorLockStatus(veh)
            if lock == 7 then
                SetVehicleDoorsLocked(veh, 2)
            end
            local pedd = GetPedInVehicleSeat(veh, -1)
            if pedd then
                SetPedCanBeDraggedOut(pedd, false)
            end
        end
    end
 end)

-- Basit Blip Oluşturma / Creating a Simple Blip // CFG
Citizen.CreateThread(function()
    for _, info in pairs(Blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, info.scale)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)

-- NPC Settings / Npc Ayarları
Citizen.CreateThread(function()
    while true do
        Citizen.Await(0)
        SetVehicleDensityMultiplierThisFrame(Config.TrafficDensity) -- Trafik yoğunlu / Traffic Density
        SetRandomVehicleDensityMultiplierThisFrame(Config.RandomVehicle) -- Rastgele araçlar (otoparktan araç çıkması vs) / Random Vehicles

        SetPedDensityMultiplierThisFrame(Config.PedDensity) -- Ped Yoğunluğu / Ped Density
        SetScenarioPedDensityMultiplierThisFrame(Config.PedScenario, Config.PedScenario1)  -- Rastgele NPC/PEDS senaryoları -- Random NPC/PEDS Scenario
        
        SetGarbageTrucks(Config.GarbageTruck) -- Rastgele ortaya çıkan çöp kamyonları [true/false] / Random Garbage Truck
        SetRandomBoats(Config.RandomBoats) -- Rastgele denizde/suda tekne çıkması [true/false] / Random Boats
        SetCreateRandomCops(Config.RandomPolice) -- Rastgele polisler (araç/yaya)[true/false] / Random Police
        SetCreateRandomCopsNotOnScenarios(Config.RandomPolice) -- Rastgele polisler (senaryo değil)[true/false] / Random Police Not on Scenarios
        SetCreateRandomCopsOnScenarios(Config.RandomPolice) -- Rastgele polisler (senaryo)[true/false] / Random Police Scenario

    end
end)

--  Silah Hasarları / Weapon Damages
Citizen.CreateThread(function()
    while true do
	    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.5)
    	Wait(0)
    	N_0x4757f00bc6323cfe(GetHashKey("WEAPON_NIGHTSTICK"), 0.5) 
        Wait(0)
        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_APPISTOL"), 6.5)
        Wait(0)
        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_CARBINERIFLE"), 0.5)
        Wait(0)
        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SMG"), 0.5)
        Wait(0)
        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PUMPSHOTGUN"), 0.5)
        Wait(0)
        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_ASSAULTRIFLE"), 0.5)
        Wait(0)
        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_REVOLVER"), 0.2)
        Wait(0)
        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_GUSENBERG"),0.5)
        Wait(0)
        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PISTOL"), 0.5)
        Wait(0)
        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MICROSMG"), 0.5)
        Wait(0)
        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SMOKEGRENADE"), 0)
        Wait(0)
        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BZGAS"), 0.1)
        Wait(0)
        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BAT"), 0.1)
        Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
	local ped = PlayerPedId()
        if IsPedArmed(ped, 6) then
	   DisableControlAction(1, 140, true)
       	   DisableControlAction(1, 141, true)
           DisableControlAction(1, 142, true)
        end
    end
end)

-- Silah Sekmeleri / Weapon Recoils
local recoils = {
	[416676503] = 0.34,
	[-957766203] = 0.22,
	[970310034] = 0.17,  
}

Citizen.CreateThread(function()
	while true do 
    Citizen.Wait(0)
        local ply = PlayerPedId()
        SetPedSuffersCriticalHits(ply, false)

        if IsPedArmed(ply, 6) then
			DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        elseif IsPedArmed(ply, 1) then
            N_0x4757f00bc6323cfe(GetHashKey("WEAPON_FLASHLIGHT"), 0.1)   
        else
            N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.35)
		end
		
        if IsPedShooting(ply) then      
            local _,wep = GetCurrentPedWeapon(ply)
            local _,cAmmo = GetAmmoInClip(ply, wep)
			
            local GamePlayCam = GetFollowPedCamViewMode()
            local Vehicled = IsPedInAnyVehicle(ply, false)
            local MovementSpeed = math.ceil(GetEntitySpeed(ply))

            if MovementSpeed > 69 then
                MovementSpeed = 69
            end
            Citizen.Wait(50)
            local _,wep = GetCurrentPedWeapon(ply)
            if wep ~= 126349499 then
                local group = GetWeapontypeGroup(wep)
                local p = GetGameplayCamRelativePitch()
                local cameraDistance = #(GetGameplayCamCoord() - GetEntityCoords(ply))

                local recoil = math.random(100,140+MovementSpeed)/100
                local rifle = false

                if group == 970310034 then
                    rifle = true
                end

                if cameraDistance < 5.3 then
                    cameraDistance = 1.5
                else
                    if cameraDistance < 8.0 then
                        cameraDistance = 4.0
                    else
                        cameraDistance = 7.0
                    end
                end

                if Vehicled then
                    recoil = recoil + (recoil * cameraDistance)
                else
                    recoil = recoil * 0.8
                end

                if GamePlayCam == 4 then
                    recoil = recoil * 0.7
                    if rifle then
                        recoil = recoil * 0.1
                    end
                end

                if rifle then
                    recoil = recoil * 0.7
                end

                local rightleft = math.random(4)
                local h = GetGameplayCamRelativeHeading()
                local hf = math.random(10,40+MovementSpeed)/100

                if Vehicled then
                    hf = hf * 2.0
                end

                if rightleft == 1 then
                    SetGameplayCamRelativeHeading(h+hf)
                elseif rightleft == 2 then
                    SetGameplayCamRelativeHeading(h-hf)
                end 
            
                local set = p+recoil

                SetGameplayCamRelativePitch(set,0.8)   
            end 	       	
        end
        
	end
end)

-- [Z] Bayılmak / Ragdolling
Citizen.CreateThread(function()

	local isRagdolling = 0

 	while true do
 		Citizen.Wait(0)
 		if IsControlJustPressed(1, 20) then
			 isRagdolling = (isRagdolling + 1) % 2
			 ClearAllHelpMessages()	
		end
 		if isRagdolling == 1 then
			SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
			SetTextComponentFormat("STRING")
			AddTextComponentString('Ayağa kalkmak için ~INPUT_MULTIPLAYER_INFO~ basın') -- Press ~INPUT_MULTIPLAYER_INFO~ for get up
			DisplayHelpTextFromStringLabel(0, 1, 1, -1)
 		end
 	end
end)

--- Discord Rich
Citizen.CreateThread(function()
	while true do
		SetDiscordAppId(BotAppID)

		SetDiscordRichPresenceAsset('RWRCore')
        
        SetDiscordRichPresenceAssetText('RWRCore')
       
        SetDiscordRichPresenceAssetSmall('RWRCore')

        SetDiscordRichPresenceAssetSmallText('RWRCore')

        SetDiscordRichPresenceAction(0, "Discord", "https://discord.gg/")
        SetDiscordRichPresenceAction(1, "Download", "https://github.com/RaweRwe/rwr-core")

		Citizen.Wait(30000)
	end
end)

--- 