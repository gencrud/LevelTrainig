extends CharacterBody2D


enum states {PATROL, CHASE, ATTACK, DEAD}
var state = states.PATROL

# For setting animations.
var anim_state
var run_speed = 50
var attacks = ["attack1", "attack2"]

# For path following.
@export var patrol_path: = NodePath()
var patrol_points = 0.0
var patrol_index = 0

# Target for chase mode.
var player: Player = null


func _ready():
	if patrol_path:
		patrol_points = get_node(patrol_path).curve.get_baked_points()
		
		
func _physics_process(delta):
	choose_action()
	# Changing the x scale flips the sprite and its attack area.
	if velocity.x > 0:
		$Sprite2D.flip_h = true
	elif velocity.x < 0:
		$Sprite2D.flip_h = false
		

	# If we're moving, show the run animation.
	# if velocity.length() > 0:
	# 	anim_state.travel("run")
	# Show the idle animation when coming to a stop (but not attacking).
	#if anim_state.get_current_node() == "run" and velocity.length() == 0:
	#	anim_state.travel("idle")

	move_and_slide()
	

func choose_action():
	# velocity = Vector2.ZERO
	# var current = anim_state.get_current_node()
	# If we're currently attacking, don't move or change state.

	#if current in attacks: 
	#	return

	# Depending on the current state, choose a movement target.
	var target
	match state:
		states.DEAD:
			set_physics_process(false)

		# Move along assigned path.
		states.PATROL:
			if patrol_path.is_empty():
				return
			target = patrol_points[patrol_index]
			if position.distance_to(target) < 1:
				patrol_index = wrapi(patrol_index + 1, 0, patrol_points.size())
				target = patrol_points[patrol_index]
			velocity = (target - position).normalized() * run_speed

		# Move towards player.
		states.CHASE:
			target = player.position
			velocity = (target - position).normalized() * run_speed

		# Make an attack.
		states.ATTACK:
			velocity = Vector2.ZERO
			target = player.position
			if target.x > position.x:
				$Sprite2D.flip_h = true
			elif target.x < position.x:
				$Sprite2D.flip_h = false

			# anim_state.travel("attack")


func _on_detect_radius_body_entered(body):
	if body is Player:
		print("detect entered: CHASE ", body)
		state = states.CHASE
		player = body 

func _on_detect_radius_body_exited(body):
	print("detect exited: PATROL ", body)
	state = states.PATROL
	player = null


func _on_attack_radius_body_entered(body):
	if body is Player:
		print("attack entered: ATTACK ", body)
		state = states.ATTACK
		velocity = Vector2.ZERO


func _on_attack_radius_body_exited(body):
	print("attack CHASE after Attack", body)
	state = states.CHASE
