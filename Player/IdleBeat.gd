class_name IdleBeat
extends PlayerState

@export var _animation_player: = NodePath() 
@onready var animation_player: AnimationPlayer = get_node(_animation_player)

var _state_name: String = "IdleBeat"
var _state_name_next_combo: String = "ComboBeat"


func enter(_msg := {}) -> void:
	animation_player.play(_state_name)
	# Snake camera: get_node("../../Camera2D").add_trauma(0.1)
	# x: 112, y: 190 => 20
	

func physics_update(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		state_machine.transition_to("Air", {do_jump = true})
	elif super._can_use_next_combo(animation_player, _state_name):
		# print(animation_player.current_animation, ' = ', animation_player.is_playing())
		state_machine.transition_to(_state_name_next_combo)
	# elif player.is_on_moving():
	#	state_machine.transition_to("Walk")
	elif not super._is_playing_beat(animation_player, _state_name):
		state_machine.transition_to("Idle")
