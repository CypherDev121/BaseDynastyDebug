Config.DefaultWeaponTints = {
	[0] = "skin par défaut",
	[1] = "skin vert",
	[2] = "skin or",
	[3] = "skin rose",
	[4] = "skin arpmée",
	[5] = "skin lspd",
	[6] = "skin orange",
	[7] = "skin platinium"
}

Config.Weapons = {
	{
		name = 'WEAPON_PISTOL',
		label = "pistolet",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_PISTOL_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_PISTOL_CLIP_02')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_PI_FLSH')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_PI_SUPP_02')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_PISTOL_VARMOD_LUXE')}
		}
	},
	{
		name = 'WEAPON_NAVYREVOLVER',
		label = "pistolet navy",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			
		}
	},
	{
		name = 'WEAPON_GADGETPISTOL',
		label = "pistolet cayo perico",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_PISTOL_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_PISTOL_CLIP_02')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_PI_FLSH')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_PI_SUPP_02')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_PISTOL_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_COMBATPISTOL',
		label = "pistolet de combat",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_COMBATPISTOL_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_COMBATPISTOL_CLIP_02')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_PI_FLSH')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_PI_SUPP')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER')}
		}
	},

	{
		name = 'WEAPON_APPISTOL',
		label = "pistolet automatique",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_APPISTOL_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_APPISTOL_CLIP_02')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_PI_FLSH')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_PI_SUPP')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_APPISTOL_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_PISTOL50',
		label = "pistolet calibre 50",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_PISTOL50_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_PISTOL50_CLIP_02')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_PI_FLSH')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_PISTOL50_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_SNSPISTOL',
		label = "pistolet sns",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_SNSPISTOL_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_SNSPISTOL_CLIP_02')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_SNSPISTOL_VARMOD_LOWRIDER')}
		}
	},

	{
		name = 'WEAPON_HEAVYPISTOL',
		label = "pistolet lourd",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_HEAVYPISTOL_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_HEAVYPISTOL_CLIP_02')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_PI_FLSH')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_PI_SUPP')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_HEAVYPISTOL_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_VINTAGEPISTOL',
		label = "pistolet vintage",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_VINTAGEPISTOL_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_VINTAGEPISTOL_CLIP_02')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_PI_SUPP')}
		}
	},

	{
		name = 'WEAPON_MACHINEPISTOL',
		label = "pistolet mitrailleur",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_MACHINEPISTOL_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_MACHINEPISTOL_CLIP_02')},
			{name = 'clip_drum', label = "chargeur tambour", hash = GetHashKey('COMPONENT_MACHINEPISTOL_CLIP_03')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_PI_SUPP')}
		}
	},

	{name = 'WEAPON_REVOLVER', label = "revolver", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_PISTOL')}},
	{name = 'WEAPON_MARKSMANPISTOL', label = "pistolet marksman", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_PISTOL')}},
	{name = 'WEAPON_DOUBLEACTION', label = "revolver double action", components = {}, ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_PISTOL')}},

	{
		name = 'WEAPON_SMG',
		label = "smg",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_SMG')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_SMG_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_SMG_CLIP_02')},
			{name = 'clip_drum', label = "chargeur tambour", hash = GetHashKey('COMPONENT_SMG_CLIP_03')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = "viseur", hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO_02')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_PI_SUPP')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_SMG_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_ASSAULTSMG',
		label = "smg d'assaut",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_SMG')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_ASSAULTSMG_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_ASSAULTSMG_CLIP_02')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = "viseur", hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER')}
		}
	},

	{
		name = 'WEAPON_MICROSMG',
		label = "micro smg",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_SMG')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_MICROSMG_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_MICROSMG_CLIP_02')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_PI_FLSH')},
			{name = 'scope', label = "viseur", hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_MICROSMG_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_MINISMG',
		label = "mini smg",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_SMG')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_MINISMG_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_MINISMG_CLIP_02')}
		}
	},

	{
		name = 'WEAPON_COMBATPDW',
		label = "arme de défense personnelle",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_SMG')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_COMBATPDW_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_COMBATPDW_CLIP_02')},
			{name = 'clip_drum', label = "chargeur tambour", hash = GetHashKey('COMPONENT_COMBATPDW_CLIP_03')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'grip', label = "poignée", hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'scope', label = "viseur", hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL')}
		}
	},

	{
		name = 'WEAPON_PUMPSHOTGUN',
		label = "fusil à pompe",
		ammo = {label = "obus", hash = GetHashKey('AMMO_SHOTGUN')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_SR_SUPP')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_PUMPSHOTGUN_VARMOD_LOWRIDER')}
		}
	},

	{
		name = 'WEAPON_SAWNOFFSHOTGUN',
		label = "carabine à canon scié",
		ammo = {label = "obus", hash = GetHashKey('AMMO_SHOTGUN')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_SAWNOFFSHOTGUN_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_ASSAULTSHOTGUN',
		label = "carabine d\'assaut",
		ammo = {label = "obus", hash = GetHashKey('AMMO_SHOTGUN')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_ASSAULTSHOTGUN_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_ASSAULTSHOTGUN_CLIP_02')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_AR_SUPP')},
			{name = 'grip', label = "poignée", hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')}
		}
	},

	{
		name = 'WEAPON_BULLPUPSHOTGUN',
		label = "carabine bullpup",
		ammo = {label = "obus", hash = GetHashKey('AMMO_SHOTGUN')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'grip', label = "poignée", hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')}
		}
	},

	{
		name = 'WEAPON_HEAVYSHOTGUN',
		label = "fusil à pompe lourd",
		ammo = {label = "obus", hash = GetHashKey('AMMO_SHOTGUN')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_HEAVYSHOTGUN_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_HEAVYSHOTGUN_CLIP_02')},
			{name = 'clip_drum', label = "chargeur tambour", hash = GetHashKey('COMPONENT_HEAVYSHOTGUN_CLIP_03')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'grip', label = "poignée", hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')}
		}
	},

	{name = 'WEAPON_DBSHOTGUN', label = "fusil à pompe double canon", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "obus", hash = GetHashKey('AMMO_SHOTGUN')}},
	{name = 'WEAPON_AUTOSHOTGUN', label = "fusil à pompe automatique", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "obus", hash = GetHashKey('AMMO_SHOTGUN')}},
	{name = 'WEAPON_MUSKET', label = "mousquet", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_SHOTGUN')}},

	{
		name = 'WEAPON_ASSAULTRIFLE',
		label = "fusil d'assaut",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_RIFLE')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_02')},
			{name = 'clip_drum', label = "chargeur tambour", hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_03')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = "viseur", hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'grip', label = "poignée", hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_ASSAULTRIFLE_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_CARBINERIFLE',
		label = "carabined'assaut",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_RIFLE')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_CARBINERIFLE_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_CARBINERIFLE_CLIP_02')},
			{name = 'clip_box', label = "chargeur très grande capacité", hash = GetHashKey('COMPONENT_CARBINERIFLE_CLIP_03')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = "viseur", hash = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_AR_SUPP')},
			{name = 'grip', label = "poignée", hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_CARBINERIFLE_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_ADVANCEDRIFLE',
		label = "fusil avancé",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_RIFLE')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_ADVANCEDRIFLE_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_ADVANCEDRIFLE_CLIP_02')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = "viseur", hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_AR_SUPP')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_SPECIALCARBINE',
		label = "carabine spéciale",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_RIFLE')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_02')},
			{name = 'clip_drum', label = "chargeur tambour", hash = GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_03')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = "viseur", hash = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'grip', label = "poignée", hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_SPECIALCARBINE_VARMOD_LOWRIDER')}
		}
	},

	{
		name = 'WEAPON_BULLPUPRIFLE',
		label = "fusil bullpup",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_RIFLE')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_BULLPUPRIFLE_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_BULLPUPRIFLE_CLIP_02')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = "viseur", hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_AR_SUPP')},
			{name = 'grip', label = "poignée", hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_BULLPUPRIFLE_VARMOD_LOW')}
		}
	},

	{
		name = 'WEAPON_COMPACTRIFLE',
		label = "fusil compact",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_RIFLE')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_COMPACTRIFLE_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_COMPACTRIFLE_CLIP_02')},
			{name = 'clip_drum', label = "chargeur tambour", hash = GetHashKey('COMPONENT_COMPACTRIFLE_CLIP_03')}
		}
	},

	{
		name = 'WEAPON_MG',
		label = "mitrailleuse",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_MG')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_MG_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_MG_CLIP_02')},
			{name = 'scope', label = "viseur", hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL_02')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_MG_VARMOD_LOWRIDER')}
		}
	},

	{
		name = 'WEAPON_COMBATMG',
		label = "mitrailleuse de combat",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_MG')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_COMBATMG_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_COMBATMG_CLIP_02')},
			{name = 'scope', label = "viseur", hash = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM')},
			{name = 'grip', label = "poignée", hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_COMBATMG_VARMOD_LOWRIDER')}
		}
	},

	{
		name = 'WEAPON_GUSENBERG',
		label = "balayeuse gusenberg",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_MG')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_GUSENBERG_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_GUSENBERG_CLIP_02')},
		}
	},

	{
		name = 'WEAPON_SNIPERRIFLE',
		label = "fusil de sniper",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_SNIPER')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'scope', label = "viseur", hash = GetHashKey('COMPONENT_AT_SCOPE_LARGE')},
			{name = 'scope_advanced', label = "lunette", hash = GetHashKey('COMPONENT_AT_SCOPE_MAX')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_SNIPERRIFLE_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_HEAVYSNIPER',
		label = "fusil de sniper lourd",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_SNIPER')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'scope', label = "viseur", hash = GetHashKey('COMPONENT_AT_SCOPE_LARGE')},
			{name = 'scope_advanced', label = "lunette", hash = GetHashKey('COMPONENT_AT_SCOPE_MAX')}
		}
	},

	{
		name = 'WEAPON_MARKSMANRIFLE',
		label = "fusil marksman",
		ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_SNIPER')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = "chargeur par défaut", hash = GetHashKey('COMPONENT_MARKSMANRIFLE_CLIP_01')},
			{name = 'clip_extended', label = "chargeur grande capacité", hash = GetHashKey('COMPONENT_MARKSMANRIFLE_CLIP_02')},
			{name = 'flashlight', label = "torche", hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = "viseur", hash = GetHashKey('COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM')},
			{name = 'suppressor', label = "silencieux", hash = GetHashKey('COMPONENT_AT_AR_SUPP')},
			{name = 'grip', label = "poignée", hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'luxary_finish', label = "skin de luxe", hash = GetHashKey('COMPONENT_MARKSMANRIFLE_VARMOD_LUXE')}
		}
	},

	{name = 'WEAPON_MINIGUN', label = "minigun", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_MINIGUN')}},
	{name = 'WEAPON_RAILGUN', label = "canon éléctrique", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "cartouche(s)", hash = GetHashKey('AMMO_RAILGUN')}},
	{name = 'WEAPON_STUNGUN', label = "tazer", tints = Config.DefaultWeaponTints, components = {}},
	{name = 'WEAPON_RPG', label = "lance-rocket", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "roquette(s)", hash = GetHashKey('AMMO_RPG')}},
	{name = 'WEAPON_HOMINGLAUNCHER', label = "lance tête-chercheuse", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "roquette(s)", hash = GetHashKey('AMMO_HOMINGLAUNCHER')}},
	{name = 'WEAPON_GRENADELAUNCHER', label = "lance-grenade", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "grenade(s)", hash = GetHashKey('AMMO_GRENADELAUNCHER')}},
	{name = 'WEAPON_COMPACTLAUNCHER', label = "lanceur compact", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "grenade(s)", hash = GetHashKey('AMMO_GRENADELAUNCHER')}},
	{name = 'WEAPON_FLAREGUN', label = "lance fusée de détresse", tints = Config.DefaultWeaponTints, components = {}, ammo = {label = "fusée(s)", hash = GetHashKey('AMMO_FLAREGUN')}},
	{name = 'WEAPON_FIREEXTINGUISHER', label = "extincteur", components = {}, ammo = {label = "charge(s)", hash = GetHashKey('AMMO_FIREEXTINGUISHER')}},
	{name = 'WEAPON_PETROLCAN', label = "jerrican d\'essence", components = {}, ammo = {label = "jerrican d\'essence", hash = GetHashKey('AMMO_PETROLCAN')}},
	{name = 'WEAPON_FIREWORK', label = "feu d\'artifice", components = {}, ammo = {label = "feu(x) d\'artifice", hash = GetHashKey('AMMO_FIREWORK')}},
	{name = 'WEAPON_FLASHLIGHT', label = "lampe torche", components = {}},
	{name = 'GADGET_PARACHUTE', label = "parachute", components = {}},
	{name = 'WEAPON_KNUCKLE', label = "poing américain", components = {}},
	{name = 'WEAPON_HATCHET', label = "hachette", components = {}},
	{name = 'WEAPON_MACHETE', label = "machette", components = {}},
	{name = 'WEAPON_SWITCHBLADE', label = "couteau à cran d\'arrêt", components = {}},
	{name = 'WEAPON_BOTTLE', label = "bouteille", components = {}},
	{name = 'WEAPON_DAGGER', label = "poignard", components = {}},
	{name = 'WEAPON_POOLCUE', label = "queue de billard", components = {}},
	{name = 'WEAPON_WRENCH', label = "clé", components = {}},
	{name = 'WEAPON_BATTLEAXE', label = "hache de combat", components = {}},
	{name = 'WEAPON_KNIFE', label = "couteau", components = {}},
	{name = 'WEAPON_NIGHTSTICK', label = "matraque", components = {}},
	{name = 'WEAPON_HAMMER', label = "marteau", components = {}},
	{name = 'WEAPON_BAT', label = "batte de Baseball", components = {}},
	{name = 'WEAPON_GOLESXLUB', label = "club de golf", components = {}},
	{name = 'WEAPON_CROWBAR', label = "pied de biche", components = {}},
	{name = 'WEAPON_STONE_HATCHET', label = "hachette en pierre", components = {}},
	{name = 'WEAPON_UNARMED', label = 'Unarmed', components = {}},
	

	{name = 'WEAPON_GRENADE', label = "grenade", components = {}, ammo = {label = "grenade(s)", hash = GetHashKey('AMMO_GRENADE')}},
	{name = 'WEAPON_SMOKEGRENADE', label = "grenade fumigène", components = {}, ammo = {label = "bombe(s)", hash = GetHashKey('AMMO_SMOKEGRENADE')}},
	{name = 'WEAPON_STICKYBOMB', label = "bombe collante", components = {}, ammo = {label = "bombe(s)", hash = GetHashKey('AMMO_STICKYBOMB')}},
	{name = 'WEAPON_PIPEBOMB', label = "bombe tuyau", components = {}, ammo = {label = "bombe(s)", hash = GetHashKey('AMMO_PIPEBOMB')}},
	{name = 'WEAPON_BZGAS', label = "grenade à gaz bz", components = {}, ammo = {label = "grenade(s)", hash = GetHashKey('AMMO_BZGAS')}},
	{name = 'WEAPON_MOLOTOV', label = "cocktail molotov", components = {}, ammo = {label = "cocktail(s)", hash = GetHashKey('AMMO_MOLOTOV')}},
	{name = 'WEAPON_PROXMINE', label = "mine de proximité", components = {}, ammo = {label = "mine(s)", hash = GetHashKey('AMMO_PROXMINE')}},
	{name = 'WEAPON_SNOWBALL', label = "boule de neige", components = {}, ammo = {label = "boule(s) de neige", hash = GetHashKey('AMMO_SNOWBALL')}},
	{name = 'WEAPON_BALL', label = "balle", components = {}, ammo = {label = "balle(s)", hash = GetHashKey('AMMO_BALL')}},
	{name = 'WEAPON_FLARE', label = "fusée de détresse", components = {}, ammo = {label = "fusée(s) éclairante(s)", hash = GetHashKey('AMMO_FLARE')}}
}
