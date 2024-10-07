extends PanelContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_Visible():
	visible = true
	visible = true

func set_Invisible():
	visible = false
	visible = false

func textInfo(info):
	if info == "Vent":
		%infoTitle.set_text("[font_size=50][b]Hydrothermic Vent[/b][/font_size]")
		%infoText.set_text("Hydrothermal vents are the habitat for many chemosynthetic organisms. Water, heated from the planet’s mantle, emits out of the vent, releasing chemicals such as sulfur and hydrogen. Organisms feed from the chemicals produced by hydrothermal vents as an energy source, with organisms such as tubeworms, mussels, and many forms of bacteria inhabiting the vents")
	elif info == "Worm":
		%infoTitle.set_text("[font_size=50][b]Tubeworms[/b][/font_size]")
		%infoText.set_text("Tubeworms are most known for its habitant around hydrothermal vents and its grouped and tube-like appearance. Tubeworms are commonly found nearby hydrothermal vents collecting sulfide from the vents as nutrition. Tubeworms use bacteria, which occupies inside itself, it order to get the nutrition from sulfide")
	elif info == "Fish":
		%infoTitle.set_text("[font_size=50][b]Fishes             [/b][/font_size]")
		%infoText.set_text("Fishes are a surrogate representing the predacious organism in the chemosynthetic ecosystem. Feeding off of tubeworms, they are the top of our tentative food chain. Being at the top of the food chain, they die eventually to the circle of life. This would then serve as food for the organisms who need nutrients in the ecosystem.")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
