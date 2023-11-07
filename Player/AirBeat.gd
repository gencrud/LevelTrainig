# class_name AirBeat
extends PlayerState

@export var _animation_player: = NodePath() 
@onready var animation_player: AnimationPlayer = get_node(_animation_player)


		
func enter(_msg := {}) -> void:
	animation_player.play("AirBeat")
	

func physics_update(delta: float) -> void:
	state_machine.transition_to("Air")

	
