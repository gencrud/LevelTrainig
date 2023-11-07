# class_name Damage
extends PunchingBagState

@export var _animation_player: = NodePath() 
@onready var animation_player: AnimationPlayer = get_node(_animation_player)

var _state_name: String = "Damage"


func enter(_msg := {}) -> void:
	if not animation_player.is_playing():
		animation_player.play(_state_name)
