@tool
extends Node
class_name AudioTrack

signal transition_ended
signal track_stopped

var active_layers: Array = []
var is_playing: bool = false
var is_transitioning: bool = false

@onready var layers = $Content/Layers
@onready var base_track: AudioStreamPlayer = $Content/BaseTrack


func _ready() -> void:
	for layer in layers.get_children():
		layer.volume_db = -80


func play_track(layer_name: String = "") -> void:
	base_track.volume_db = 0
	base_track.play()
	
	if layer_name != "":
		layers.get_node(layer_name).volume_db = 0
	
	for layer in layers.get_children():
		layer.play()
	
	active_layers.clear()
	if layer_name != "":
		active_layers.append(layer_name)
	
	is_playing = true


func transition_to(layer_name: String = "", fade_time: float = 0.5) -> void:
	if layer_name != "":
		var layer_track: AudioStreamPlayer = layers.get_node(layer_name)
		if layer_track.volume_db != 0:
			var tween: Tween = get_tree().create_tween()
			tween.tween_property(layer_track, "volume_db", 0, fade_time)
			await tween.finished
		
	if active_layers.size() != 0:
		var tween: Tween = get_tree().create_tween().set_parallel()
		for current_layer_name in active_layers:
			if current_layer_name == layer_name: 
				continue
			var current_layer_track: AudioStreamPlayer = layers.get_node(current_layer_name)
			tween.tween_property(current_layer_track, "volume_db", -80, fade_time)
		await tween.finished
	
	if !(layer_name in active_layers) and layer_name != "":
		active_layers.append(layer_name)

	is_transitioning = false
	transition_ended.emit()


func blend_layer(layer_name: String = "", fade_time: float = 0.5) -> void:
	if layer_name != "":
		var layer_track: AudioStreamPlayer = layers.get_node(layer_name)
		
		if layer_track.volume_db == 0: 
			return
		
		var tween: Tween = get_tree().create_tween()
		tween.tween_property(layer_track, "volume_db", 0, fade_time)
	
	if !(layer_name in active_layers) and layer_name != "":
		active_layers.append(layer_name)


func stop_track(fade_time: float = 0.5) -> void:
	var tween: Tween = get_tree().create_tween().set_parallel()
	if active_layers.size() != 0:
		for current_layer_name in active_layers:
			var layer_track: AudioStreamPlayer = layers.get_node(current_layer_name)
			tween.tween_property(layer_track, "volume_db", -80, fade_time)
			
	tween.tween_property(base_track, "volume_db", -80, fade_time)
	
	await tween.finished
	
	base_track.stop()
	
	for layer in layers.get_children():
		layer.stop()
	
	is_playing = false
	active_layers.clear()
	track_stopped.emit()


func add_layer() -> void:
	var audio_player = AudioStreamPlayer.new()
	layers.add_child(audio_player)
	audio_player.volume_db = -80


func update_layer(layer_index: int, new_name: String, new_path: String) -> void:
	var audio_player: AudioStreamPlayer = layers.get_child(layer_index)
	audio_player.name = new_name
	audio_player.stream = load(new_path)


func remove_layer(layer_index: int) -> void:
	layers.get_child(layer_index).queue_free()
