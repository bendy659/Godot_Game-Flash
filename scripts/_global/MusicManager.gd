extends Node

var musics: Dictionary = {
	"main-menu": [
		{ "name": "Choose Joy", "bmp": 75, "id": "choose_joy" },
		{ "name": "Exploration chiptune RPG Adventure", "bmp": 75, "id": "exploration_chiptune_rpg_adventure" },
		{ "name": "Game mode - ON", "bpm": 130, "id": "game_mode_on" }
	]
}
var music_stream: AudioStreamPlayer

var current_music: Dictionary
var on_ticking: bool = false
var time: int = 0
var beat_count: int = 0

signal on_bit(bit_count: int)

func ticking(
	override_bpm: int = 0
) -> void:
	if !music_stream: print_debug("Audio stream player not registered!")
	if !on_ticking: return
	
	var bpm = current_music["bpm"] if override_bpm == 0 else override_bpm
	
	if time % bpm == 0:
		beat_count += 1
		on_bit.emit(beat_count)

func start(imusic: Dictionary) -> void:
	current_music = imusic
	on_ticking = true

func reset() -> void:
	on_ticking = false
	time = 0
	beat_count = 0

func toast() -> void:
	pass
