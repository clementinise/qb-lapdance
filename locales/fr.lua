Locale                          = Locale or {}

Locale.fr = { -- fr is the reference that will be used for 'Config.Language'
	StandaloneLapText			= "~r~E~w~ - Demander un lap dance", -- Définit le texte qui sera affiché au-dessus du marqueur si 'Config.Framework' est mis sur 'standalone'
	LapText						= "~r~E~w~ - Acheter un lap dance (~g~" .. Config.LapDanceCost .. "$~w~)", -- Définit le texte qui sera affiché au-dessus du marqueur
	BoughtLapdance				= "Vous avez acheté un lap dance pour 100$", -- Texte de la notification lorsqu'un lap dance est acheté
	StripperPause				= "La stripteaseuse a besoin de repos !", -- Texte de la notification si un joueur veut directement racheter un lapdance dans les 10 secondes après avoir fini son dernier
	StripperActive				= "La strip-teaseuse est déjà occupé !", -- Texte de la notification si une strip-teaseuse est déjà occupé lorsque vous essayez d'acheter un lap dance
	NotEnoughMoney				= "Vous n'avez pas assez d'argent. Un lap dance coûte 100$" -- Texte de la notification si le joueur n'a pas assez d'argent
}