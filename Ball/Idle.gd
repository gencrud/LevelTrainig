# class_name Idle
extends PunchingBagState

@export var _animation_player: = NodePath() 
@onready var animation_player: AnimationPlayer = get_node(_animation_player)


func enter(_msg := {}) -> void:
	owner.life_label_1.visible = false
	owner.life_label_2.visible = false
	owner.life_label_3.visible = false
