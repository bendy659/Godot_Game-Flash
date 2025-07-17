extends Node

var translations: Dictionary = {
	"names": {
		"dictor": {
			"ru": "Диктор",
			"en": "Dictor"
		},
		"unk": {
			"ru": "Неизвестный",
			"en": "Unknown"
		}
	},
	"main_menu": {
		"tabs": {
			"general": {
				"ru": "Общее",
				"en": "General",
				
				"language": {
					"ru": "Язык",
					"en": "Language"
				}
			},
			"control": {
				"ru": "Управление",
				"en": "Control",
				
				"mouse_senc": {
					"name": {
						"ru": "Чувствительность мыши",
						"en": "Mouse senc"
					}
				}
			},
			"sounds": {
				"ru": "Звуки",
				"en": "Sounds",
				
				"general": {
					"name": {
						"ru": "Общая",
						"en": "General"
					}
				},
				"music": {
					"name": {
						"ru": "Музыка",
						"en": "Music"
					}
				},
				"env": {
					"name": {
						"ru": "Окружение",
						"en": "Environment"
					}
				},
				"ui": {
					"name": {
						"ru": "UI",
						"en": "UI"
					}
				},
				"sfx": {
					"name": {
						"ru": "Звуковые эффекты",
						"en": "SFX"
					}
				}
			},
			"graphics": {
				"ru": "Графика",
				"en": "Graphics"
			}
		},
		"buttons": {
			"start-game": {
				"ru": "Запуск",
				"en": "Start"
			},
			"settings": {
				"ru": "Настройки",
				"en": "Settings"
			},
			"exit": {
				"ru": "Ливнуть",
				"en": "Leave"
			}
		}
	},
	"settings_menu": {
		"tabs": {
			"general": {
				"ru": "Общее",
				"en": "General"
			},
			"control": {
				"ru": "Управление",
				"en": "Control"
			},
			"sounds": {
				"ru": "Звуки",
				"en": "Sounds"
			},
			"graphic": {
				"ru": "Графика",
				"en": "graphic"
			}
		}
	},
	
	"dialogues": {
		"main_menu": {
			"button_leave": {
				"ru": [
					"[unk:none] XDDDXDXDDX.",
					"[unk:none] Иш чё захотел...",
					"[unk:none] Ты еще даже не начал, а уже ссышся и домой просишся.",
					"XDDDDDS",
					"ой..."
				],
				"en": [
					"[unk:none] XDDDXDXDDX.",
					"[unk:none] Look at what he wanted...",
					"[unk:none] You haven't even started, and you're already scared shitless and begging to go home.",
					"XDDDDDS",
					"ops..."
				]
			}
		}
	}
}

func _translate(id: String) -> Variant:
	var parts := id.split(".")
	var result = translations
	
	for part in parts:
		if result.has(part):
			result = result[part]
			print_debug("Found component [%s]" % part)
		else:
			print_debug("Component [%s] not found in current level!" % part)
			return id  # Not found - return id
	
	var c_lang = GameSettings.language
	
	if typeof(result) == TYPE_DICTIONARY and result.has(c_lang):
		return result[c_lang]
	
	# if value in final - return result
	if typeof(result) in [TYPE_STRING, TYPE_ARRAY]:
		print_debug("Translation for '%s' found. Returning this '%s'" % [id, result])
		return result
	
	print_debug("Translation for '%s' not found. Returning ID." % id)
	return id


func translate_label(id: String) -> String:
	var result = _translate(id)
	
	if typeof(result) == TYPE_STRING: return result
	else: return id

func translate_array(id: String) -> Array:
	var result = _translate(id)
	
	if typeof(result) == TYPE_ARRAY: return result
	else: return [result]
