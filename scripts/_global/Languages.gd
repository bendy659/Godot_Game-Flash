extends Node

var translations: Dictionary = {
	"names": {
		"ru": {
			"unk": "Неизвестный"
		},
		"en": {
			"unk": "Unknown"
		}
	},
	"main_menu": {
		"buttons": {
			"start-game": {
				"name": {
					"ru": "Запуск",
					"en": "Start"
				}
			},
			"settings": {
				"name": {
					"ru": "Настройки",
					"en": "Settings"
				}
			},
			"leave": {
				"name": {
					"ru": "Ливнуть",
					"en": "Leave"
				}
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
					"[unk:none]: XDDDXDXDDX.",
					"[unk:none]: Иш чё захотел...",
					"[unk:none]: Ты еще даже не начал, а уже ссышся и домой просишся."
				],
				"en": [
					"[unk:none]: XDDDXDXDDX.",
					"[unk:none]: Look at what he wanted...",
					"[unk:none]: You haven't even started, and you're already scared shitless and begging to go home."
				]
			}
		}
	}
}

func _translate(id: String) -> Variant:
	var parts := id.split(".")
	var result = translations
	
	for part in parts:
		print_debug("Attempt founding [%s]" % part)
		print_debug("Found components: [%s]" % result[part])
		
		if result.has(part):
			result = result[part]
	
	print_debug("Founds final: %s" % result)
	
	var c_lang = GameSettings.language
	
	if result.has(c_lang): return result[c_lang]
	return id # Not found

func translate_label(id: String) -> String:
	var result = _translate(id)
	
	if result is String: return result
	else: return id

func translate_array(id: String) -> Array[String]:
	var result = _translate(id)
	
	if result is Array[String]: return result
	else: return [result]
