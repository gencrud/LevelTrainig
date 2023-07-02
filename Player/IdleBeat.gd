# class_name IdleBeat
extends PlayerState

@export var _animation_player: = NodePath() 
@onready var animation_player: AnimationPlayer = get_node(_animation_player)


		
func enter(_msg := {}) -> void:
	animation_player.play("Beat")


func physics_update(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		state_machine.transition_to("Air", {do_jump = true})
	elif player.is_on_moving():
		state_machine.transition_to("Walk")
	elif not is_playing_beat():
		state_machine.transition_to("Idle")


func is_playing_beat() -> bool:
	return animation_player.current_animation == "Beat" and animation_player.is_playing()

