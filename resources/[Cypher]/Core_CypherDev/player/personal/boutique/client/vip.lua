PedsList = {
	
}

function OpenVIPMenu()
	if ESX.PlayerData.rank == "default" then ESX.ShowNotification('Vous n\'avez pas le grade necessaire pour ouvrir ce menu !') return end
    local VIPMenu = {
		Base = { Title = "Menu VIP", HeaderColor = {255, 255, 255}},
		Data = { currentMenu = "menu vip" },
	
		Events = {
		  onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentSlt, result)	
            if btn.action == "peds" then
                OpenMenu('peds')
			elseif btn.action == "weatints" then
				CloseMenu()
				Wait(100)
				openWeaponSkinMenu()
			elseif btn.action == "setped" then
				ParticleMaker("scr_rcbarry2", "scr_clown_appears", 0.5) 
				Citizen.Wait(100)
                SpawnPed(btn.ped)
            end	
		end
	  },
	
	  Menu = {
		["menu vip"] = {
		  b = {
		  }
		},
         ["peds"] = {
             b = {
				{name = "Mon Skin", ped = "myskin", action = "setped"},
				{name = "Tonton", ped = "a_m_y_downtown_01", action = "setped"},
				{name = "Lamar", ped = "ig_lamardavis", action = "setped"},
				{name = "Mec musclé", ped = "u_m_y_babyd", action = "setped"},
				{name = "Prêtre", ped = "ig_priest", action = "setped"},
				{name = "Prisonnier 1", ped = "u_m_y_prisoner_01", action = "setped"},
				{name = "Prisonnier 2", ped = "s_m_y_prisoner_01", action = "setped"},
				{name = "Prisonnier 3", ped = "ig_rashcosvki", action = "setped"},
				{name = "Clochard 1", ped = "u_m_y_militarybum", action = "setped"},
				{name = "Mécano 1", ped = "mp_m_waremech_01", action = "setped"},
				{name = "Mécano 2", ped = "Mp_m_weapexp_01", action = "setped"},
				{name = "Mécano 3", ped = "Mp_m_weapwork_01", action = "setped"},
				{name = "Mécano Benny's", ped = "ig_benny", action = "setped"},
				{name = "Autopsie", ped = "s_m_y_autopsy_01", action = "setped"},
				{name = "Docteur 1", ped = "s_m_m_doctor_01", action = "setped"},
				{name = "Paramedic 1", ped = "s_m_m_paramedic_01", action = "setped"},
				{name = "LSPD 1", ped = "s_m_y_cop_01", action = "setped"},
				{name = "LSPD 2 (Femme)", ped = "s_f_y_cop_01", action = "setped"},
				{name = "LSPD 3 (Desert)", ped = "csb_cop", action = "setped"},
				{name = "Dealer", ped = "s_m_y_dealer_01", action = "setped"},
				{name = "Lester", ped = "ig_lestercrest", action = "setped"},
				{name = "Mec cagoulé", ped = "g_m_m_chicold_01", action = "setped"},
				{name = "Ballas 1", ped = "g_m_y_ballaeast_01", action = "setped"},
				{name = "Ballas 2", ped = "g_m_y_ballaorig_01", action = "setped"},
				{name = "Ballas 3", ped = "ig_ballasog", action = "setped"},
				{name = "Ballas 4", ped = "g_m_y_ballasout_01", action = "setped"},
				{name = "Families 1", ped = "g_m_y_famca_01", action = "setped"},
				{name = "Families 2", ped = "g_m_y_famdnf_01", action = "setped"},
				{name = "Families 3", ped = "g_m_y_famfor_01", action = "setped"},
				{name = "Families 4 (Femme)", ped = "g_f_y_families_01", action = "setped"},
				{name = "Marabunta 1", ped = "mp_m_waremech_01", action = "setped"},
				{name = "Marabunta 2", ped = "g_m_y_salvagoon_01", action = "setped"},
				{name = "Marabunta 3", ped = "g_m_y_salvagoon_02", action = "setped"},
				{name = "Marabunta 4", ped = "g_m_y_salvagoon_03", action = "setped"},
				{name = "Vagos 1", ped = "g_m_y_mexgoon_01", action = "setped"},
				{name = "Vagos 2", ped = "g_m_y_mexgoon_02", action = "setped"},
				{name = "Vagos 3", ped = "g_m_y_mexgoon_03", action = "setped"}
             }
         },
	  }
	}

	table.insert(VIPMenu.Menu["menu vip"].b, {name = "Votre Grade : ~b~" .. ESX.PlayerData.rank})

	if ESX.PlayerData.expiration then
	table.insert(VIPMenu.Menu["menu vip"].b, {name = "Expiration du grade : ~b~" .. ESX.PlayerData.expiration})
	end
	table.insert(VIPMenu.Menu["menu vip"].b, {name = "Gérer les Teintes d'armes", action = "weatints"})	
	table.insert(VIPMenu.Menu["menu vip"].b, {name = "Gérer les Peds (Bientôt)", action = "pedsa"})		
	CreateMenu(VIPMenu)
end

function SpawnPed(pedname)
	if pedname == "myskin" then TriggerEvent('caruiskinchanger:loadSkin', ESX.PlayerData.skin) return end
    local j1 = PlayerId()
    local p1 = GetHashKey(pedname)
    RequestModel(p1)
    ESX.ShowNotification("Chargement...")
    while not HasModelLoaded(p1) do
        Wait(0)
    end
        SetPlayerModel(j1, p1)
        SetModelAsNoLongerNeeded(p1)
        Citizen.Wait(500)
		TriggerEvent('esx:restoreLoadout')
		TriggerEvent('esx:restorePermLoadout')
end


function ParticleMaker(asset, nomanim, scale)
    local PlayerCoords = ESX.PlayerData.cache.coords
    if not HasNamedPtfxAssetLoaded(asset) then
        RequestNamedPtfxAsset(asset)
        while not HasNamedPtfxAssetLoaded(asset) do
            Citizen.Wait(1)
        end
    end
    while true do
        Citizen.Wait(1)
            UseParticleFxAssetNextCall(asset)
            local part = StartParticleFxNonLoopedAtCoord(nomanim, PlayerCoords, 0.0, 0.0, 0.0, scale, false, false, false, false)
            Citizen.Wait(200)
            break
    end
end

RegisterCommand("+vipmenu", function()
    OpenVIPMenu()
end)