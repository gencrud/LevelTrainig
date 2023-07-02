# class_name Air
extends PlayerState

@export var _animation_player: = NodePath() 
@onready var animation_player: AnimationPlayer = get_node(_animation_player)

var start_position_jump: Vector2 = Vector2.ZERO


func enter(_msg := {}) -> void:	
	if _msg.has("do_jump") and _msg["do_jump"]:
		player.velocity.y = player.JUMP_IMPULSE
		animation_player.play("Jump")
		start_position_jump = player.position


func physics_update(delta: float) -> void:
	player.velocity.y += player.gravity * delta
		
	player.move_and_slide()
		
	# приземляемся на то же место
	if start_position_jump.y <= player.position.y:
		player.position.y = start_position_jump.y
		start_position_jump = Vector2.ZERO
		player.velocity = Vector2.ZERO
		state_machine.transition_to("Idle")
		
	if Input.is_action_just_pressed("beat"):
		state_machine.transition_to("AirBeat")
