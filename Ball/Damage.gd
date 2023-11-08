# class_name Damage
extends PunchingBagState

@export var _animation_player: = NodePath() 
@onready var animation_player: AnimationPlayer = get_node(_animation_player)

const STATE_NAME: String = "Damage"


func enter(msg := {}) -> void:
	animation_player.play(STATE_NAME)

	if msg.player:
		owner.position.x += owner.REBOUND_AFTER_IMPACT * msg.player.transform.x[0]
	
	if owner.life_label_3.visible:
		state_machine.transition_to('Die', {player = msg.player})
	elif owner.life_label_2.visible:
		owner.life_label_3.visible = true
	elif owner.life_label_1.visible:
		owner.life_label_2.visible = true
	else:
		owner.life_label_1.visible = true
