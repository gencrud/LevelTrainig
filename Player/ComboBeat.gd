# class_name ComboBeat
extends PlayerState

@export var _animation_player: = NodePath() 
@onready var animation_player: AnimationPlayer = get_node(_animation_player)


func enter(_msg := {}) -> void:
	animation_player.play("ComboBeat")
	# x: 112, y: 190 => 20
	


func physics_update(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		state_machine.transition_to("Air", {do_jump = true})
	elif Input.is_action_just_pressed("beat"):
		if animation_player.current_animation == "ComboBeat":
			state_machine.transition_to("ComboBeat2")
	elif not is_playing_beat():
		state_machine.transition_to("Idle")


func is_playing_beat() -> bool:
	return animation_player.current_animation == "ComboBeat" and animation_player.is_playing()
