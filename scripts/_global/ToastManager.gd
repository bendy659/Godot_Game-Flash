extends Node

class ToastContext:
	var icon: String
	var name: String
	var description: String
	var show_icon: bool = false
	
	func _init(iicon, iname: String, idescription: String) -> void:
		icon = "none" if iicon == null else iicon
		name = iname
		description = idescription
		show_icon = iicon != null

var toast_context: ToastContext = ToastContext.new(
	null, "Example name", "example description"
)

func show() -> void:
	pass

func hide() -> void:
	pass
