extends Control

@onready var b := [
	$"toast/left-top", $"toast/top",
	$toast/left, $toast/center,
	$toast/left_bottom, $toast/bottom
]
@onready var context := [
	$toast/icon,
	$toast/name,
	$toast/description
]
@onready var animator := $animator

var toast_content: ToastManager.ToastContext = ToastManager.toast_context
