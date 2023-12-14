@tool
extends Control
class_name LayerTrackUI

signal audio_updated(track_index, track_name, stream_path)
signal transitioned(track_name, fade_time)
signal blended(layer_name, fade_time)
signal track_removed(index)

var stream_path: String

@onready var title: Label = $Content/Title
@onready var layer_name_edit: LineEdit = $Content/LayerName

@onready var fade_spin_box: SpinBox = $Content/FadeTime/SpinBox
@onready var fade_slider: HSlider = $Content/FadeTime/HSlider

@onready var file_label: Label = $Content/FileButtons/Label
@onready var select_button: Button = $Content/FileButtons/Select

@onready var transition_button: Button = $Content/LayerButtons/Transition
@onready var blend_button: Button = $Content/LayerButtons/Blend

@onready var set_button: Button = $Content/LayerButtons/Set
@onready var remove_button: Button = $Content/LayerButtons/RemoveLayer

@onready var file_dialog: FileDialog = $FileDialog


func _ready() -> void:
	select_button.pressed.connect(func () -> void:
		file_dialog.popup_centered(Vector2(512, 384))
	)
	set_button.pressed.connect(func () -> void:
		audio_updated.emit(get_index(), layer_name_edit.text, stream_path)
	)
	file_dialog.file_selected.connect(func (path: String) -> void:
		stream_path = path
		file_label.text = file_dialog.current_file
		audio_updated.emit(get_index(), layer_name_edit.text, stream_path)
	)
	
	fade_spin_box.value_changed.connect(func (value: float) -> void:
		fade_slider.value = value
	)
	fade_slider.value_changed.connect(func (value: float) -> void:
		fade_spin_box.value = value
	)
	
	transition_button.pressed.connect(func () -> void:
		transitioned.emit(layer_name_edit.text, fade_spin_box.value)
	)
	blend_button.pressed.connect(func () -> void:
		blended.emit(layer_name_edit.text, fade_spin_box.value)
	)
	
	remove_button.pressed.connect(func () -> void:
		track_removed.emit(get_index())
	)
	
	title.text = "Layer" + str(get_index())
	
	layer_name_edit.text = title.text
	layer_name_edit.editable = false
	
	layer_name_edit.focus_entered.connect(func () -> void:
		layer_name_edit.editable = true
	)
	layer_name_edit.focus_exited.connect(func () -> void:
		layer_name_edit.editable = false
		audio_updated.emit(get_index(), layer_name_edit.text, stream_path)
	)
	layer_name_edit.gui_input.connect(func (event: InputEvent) -> void:
		if event is InputEventKey:
			if event.pressed and event.keycode == KEY_ENTER:
				layer_name_edit.release_focus()
	)


func set_layer_data(value: String, path: String) -> void:
	layer_name_edit.text = value
	layer_name_edit.editable = false
	
	stream_path = path
	file_dialog.current_path = path
	file_label.text = file_dialog.current_file


func _can_drop_data(position: Vector2, data) -> bool:
	return typeof(data.files[0]) == TYPE_STRING and (data.files[0].get_extension() == "ogg" or data.files[0].get_extension() == "wav" or data.files[0].get_extension() == "mp3")


func _drop_data(position: Vector2, data) -> void:
	stream_path = data.files[0]
	file_dialog.current_path = stream_path
	file_label.text = file_dialog.current_file
	audio_updated.emit(get_index(), layer_name_edit.text, stream_path)
