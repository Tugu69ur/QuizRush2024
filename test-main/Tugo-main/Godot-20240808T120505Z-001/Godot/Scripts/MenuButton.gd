extends MenuButton

var MenuPopUp : PopupMenu = self.get_popup()
# Called when the node enters the scene tree for the first time.
func _ready():
	MenuPopUp.add_item("psda")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
