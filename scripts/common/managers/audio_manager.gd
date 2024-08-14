class_name AudioManager
extends Node

var loaded_sfx : Dictionary
var loaded_bgm : Dictionary

var bus : AudioBusLayout

var bgm_player : AudioStreamPlayer
var sfx_player : AudioStreamPlayer

func initialize() -> void:
	loaded_sfx.clear()
	loaded_bgm.clear()
	
	loaded_bgm["bgm"] = load("res://assets/audio/bgm.mp3")
	loaded_sfx["click"] = load("res://assets/audio/点击.mp3")
	loaded_sfx["building_appear"] = load("res://assets/audio/建筑出现.mp3")
	loaded_sfx["building_levelup"] = load("res://assets/audio/建筑升级.mp3")
	bus = load("res://assets/audio/audio_bus.tres")
	
	AudioServer.set_bus_layout(bus)
	
	bgm_player = AudioStreamPlayer.new()
	add_child(bgm_player)
	sfx_player = AudioStreamPlayer.new()
	add_child(sfx_player)
	
	bgm_player.bus = &"bgm"
	sfx_player.bus = &"sfx"
	
	bgm_player.autoplay = false
	sfx_player.autoplay = false
	
	EventBus.subscribe(GameEvents.AUDIO_PLAY, play_audio)
	EventBus.subscribe(GameEvents.AUDIO_STOP, stop_audio)
	
	print("audio manager initialized")

func play_audio(name : String, type : String) -> void:
	match type:
		"bgm":
			bgm_player.stream = loaded_bgm[name] as AudioStream
			bgm_player.play()
			print(type, "播放", name)
		"sfx":
			sfx_player.stream = loaded_sfx[name] as AudioStream
			sfx_player.play()
			print(type, "播放", name)
	
func stop_audio(type : String) -> void:
	match type:
		"bgm":
			bgm_player.stop()
		"sfx":
			sfx_player.stop()
