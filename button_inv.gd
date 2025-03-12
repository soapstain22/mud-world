extends MenuButton

@onready var popup: PopupMenu = get_popup()

func _ready():
	# Clear any default items in the popup menu.

	# Connect the item_pressed signal to a function.
	popup.item_pressed.connect(_on_popup_item_pressed)

func _on_popup_item_pressed(id: int):
	match id:
		0:
			print("New Game selected")
			# Implement your New Game logic here.
		1:
			print("Load Game selected")
			# Implement your Load Game logic here.
		2:
			print("Settings selected")
			# Implement your Settings logic here.
		3:
			print("Quit selected")
			get_tree().quit() # or other close logic.
		_:
			print("Unknown item selected: ", id)
