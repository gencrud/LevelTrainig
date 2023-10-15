class_name ComboBeat2
extends PlayerState

@export var _animation_player: = NodePath() 
@onready var animation_player: AnimationPlayer = get_node(_animation_player)

var _state_name: String = "ComboBeat2"
var _state_name_next_combo: String = "ComboBeat3"


func enter(_msg := {}) -> void:
	animation_player.play(_state_name)
	player.get_node("Camera2D").add_trauma()
	

func physics_update(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		state_machine.transition_to("Air", {do_jump = true})
	elif super._can_use_next_combo(animation_player, _state_name):
		state_machine.transition_to(_state_name_next_combo)
	elif not super._is_playing_beat(animation_player, _state_name):
		state_machine.transition_to("Idle")
