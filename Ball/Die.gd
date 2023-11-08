# class_name Die
extends PunchingBagState

#@export var _animation_player: = NodePath() 
#@onready var animation_player: AnimationPlayer = get_node(_animation_player)

const STATE_NAME: String = "Die"


func enter(msg := {}) -> void:
	# animation_player.play(STATE_NAME)
	if msg.player:
		owner.position.x += 20 * owner.REBOUND_AFTER_IMPACT * msg.player.transform.x[0] 
	
	owner.modulate.a = 0.5	
	owner.life_label_1.visible = false
	owner.life_label_2.visible = false
	owner.life_label_3.visible = false
	
	$"../../BeatArea/CollisionShape2D".disabled = true
	$"../../BounceParticles".emitting = true
	await get_tree().create_timer(0.8).timeout
	owner.queue_free()
