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
		%infoText.set_text("Hydrothermal vents are the habitat for many chemosynthetic organisms. Water, heated from the planet’s mantle, emits out of the vent, releasing chemicals such as sulfur and hydrogen. Organisms feed from the chemicals produced by hydrothermal vents as an energy source, with organisms such as tubeworms, mussels, and many forms of bacteria inhabiting the vents.")
	elif info == "Worm":
		%infoTitle.set_text("")
		%infoText.set_text("")
	elif info == "Mussel":
		%infoTitle.set_text("")
		%infoText.set_text("")
	elif info == "Crab":
		%infoTitle.set_text("")
		%infoText.set_text("")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
