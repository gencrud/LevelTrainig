class_name ComboBeat
extends PlayerState

const STATE_NAME: String = "ComboBeat"
const STATE_NAME_NEXT: String = "ComboBeat2"

@export var _animation_player: = NodePath() 
@onready var animation_player: AnimationPlayer = get_node(_animation_player)

func enter(_msg := {}) -> void:
	animation_player.play(STATE_NAME)
	# player.get_node("Camera2D").add_trauma()
	# x: 112, y: 190 => 20


func physics_update(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		state_machine.transition_to("Air", {do_jump = true})
	elif super._can_use_next_combo(animation_player, STATE_NAME):
		# print(animation_player.current_animation, ' = ', animation_player.is_playing())
		
		await animation_player.animation_finished
		state_machine.transition_to(STATE_NAME_NEXT)
	elif not super._is_playing_beat(animation_player, STATE_NAME):
		state_machine.transition_to("Idle")
		
