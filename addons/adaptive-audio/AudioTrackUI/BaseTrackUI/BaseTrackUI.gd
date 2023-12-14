@tool
extends Panel
class_name BaseTrackUI

signal audio_updated(track_name, stream_path)
signal track_started(fade_time)
signal track_removed

var stream_path: String

@onready var title: Label = $Content/Title
@onready var track_name_edit: LineEdit = $Content/TrackName

@onready var fade_spin_box: SpinBox = $Content/FadeTime/SpinBox
@onready var fade_slider: HSlider = $Content/FadeTime/HSlider

@onready var file_label: Label = $Content/FileButtons/Label
@onready var select_audio_button: Button = $Content/FileButtons/Select
@onready var file_dialog: FileDialog = $FileDialog

@onready var update_button: Button = $Content/TrackButtons/Update
@onready var play_button: Button = $Content/TrackButtons/Play
@onready var remove_button: Button = $Content/TrackButtons/Remove


func _ready() -> void:
	if owner != null:
		await owner.ready
	
	select_audio_button.pressed.connect(func () -> void:
		file_dialog.popup_centered(Vector2(512, 384))
	)
	file_dialog.file_selected.connect(func (path: String) -> void:
		stream_path = path
		file_label.text = file_dialog.current_file
		update_audio()
	)
	update_button.pressed.connect(update_audio)
	
	fade_spin_box.value_changed.connect(func (value: float) -> void:
		fade_slider.value = value
	)
	fade_slider.value_changed.connect(func (value: float) -> void:
		fade_spin_box.value = value
	)
	
	play_button.pressed.connect(func () -> void:
		track_started.emit(fade_spin_box.value)
	)
	remove_button.pressed.connect(func () -> void:
		track_removed.emit()
	)
	
	track_name_edit.text = title.text
	track_name_edit.editable = false
	
	track_name_edit.focus_entered.connect(func () -> void:
		track_name_edit.editable = true
	)
	track_name_edit.focus_exited.connect(func () -> void:
		track_name_edit.editable = false
		update_audio()
	)
	
	track_name_edit.gui_input.connect(func (event: InputEvent) -> void:
		if event is InputEventKey:
			if event.pressed and event.keycode == KEY_ENTER:
				track_name_edit.release_focus()
	)


func update_audio() -> void:
	audio_updated.emit(track_name_edit.text, stream_path)


func _can_drop_data(position: Vector2, data) -> bool:
	return typeof(data.files[0]) == TYPE_STRING and (data.files[0].get_extension() == "ogg" or data.files[0].get_extension() == "wav" or data.files[0].get_extension() == "mp3")


func _drop_data(position: Vector2, data) -> void:
	stream_path = data.files[0]
	file_dialog.current_path = stream_path
	file_label.text = file_dialog.current_file
	update_audio()
