class_name ComboBeat3
extends PlayerState

const STATE_NAME: String = "ComboBeat3"
const STATE_NAME_NEXT: String = ""

@export var _animation_player: = NodePath() 
@onready var animation_player: AnimationPlayer = get_node(_animation_player)


func enter(_msg := {}) -> void:
	animation_player.play(STATE_NAME)
	player.get_node("Camera2D").add_trauma(0.08)
	# player._enemy = null
	

func physics_update(delta: float) -> void:	
	if Input.is_action_just_pressed("ui_accept"):
		state_machine.transition_to("Air", {do_jump = true})
	elif not super._is_playing_beat(animation_player, STATE_NAME):
		state_machine.transition_to("Idle")
