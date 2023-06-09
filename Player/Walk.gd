# class_name Walk
extends PlayerState

@export var _animation_player: = NodePath() 
@onready var animation_player: AnimationPlayer = get_node(_animation_player)


func enter(_msg := {}) -> void:
	animation_player.play("Walk")
	

func physics_update(delta: float) -> void:
	"""if not player.is_on_floor():
		state_machine.transition_to("Air")
		return"""
		
	var direction: Vector2 = player.get_direction()
	# direction = direction.normalized() # here direction is normalizing  
	
	if direction != Vector2.ZERO:
		player.velocity = player.velocity.move_toward(direction * player.SPEED, player.SPEED * delta)
	else:
		player.velocity = player.velocity.move_toward(Vector2.ZERO, player.SPEED * delta)
	
	player.move_and_slide()
	
	for i in player.get_slide_collision_count():	
		var collision = player.get_slide_collision(i)
		print(collision.get_collider())
		if collision.get_collider() is TileMap:
			var tile: TileMap = collision.get_collider()

			# Player достиг стены. Движение вверх невозможно,  разрешить прыжок
	
	if Input.is_action_just_pressed("ui_accept"):
		state_machine.transition_to("Air", {do_jump = true})
	elif direction == Vector2.ZERO:
		state_machine.transition_to("Idle")
	else:
		state_machine.transition_to("Walk")
