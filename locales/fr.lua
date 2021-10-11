Locale                          = Locale or {}

Locale.fr = { -- fr is the reference that will be used for 'Config.Language'
	LapText						= "~r~E~w~ - Acheter un lap dance (~g~" .. Config.LapDanceCost .. "$~w~)", -- Définit le texte qui sera affiché au-dessus du marqueur
	BoughtLapdance				= "Vous avez acheté un lap dance pour 100$", -- Texte de la notification lorsqu'un lap dance est acheté
	StripperActive				= "La strip-teaseuse est déjà occupé !", -- Texte de la notification si une strip-teaseuse est déjà occupé lorsque vous essayez d'acheter un lap dance
	NotEnoughMoney				= "Vous n'avez pas assez d'argent. Un lap dance coûte 100$" -- Texte de la notification si le joueur n'a pas assez d'argent
}