extends CharacterBody2D
class_name Enemy

enum states {PATROL, CHASE, ATTACK, DEAD}
var state = states.PATROL
var lifes = 100

# For setting animations.
var anim_state
var run_speed = 50
var attacks: Array = ["Attack_1", "Attack_2",  "Attack_3"]

# For path following.
@export var patrol_path: = NodePath()
var patrol_points = 0.0
var patrol_index = 0

# Target for chase mode.
var player: Player = null

@onready var animation_player: AnimationPlayer = $AnimationPlayer


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
			if patrol_path.is_empty(): return
			target = patrol_points[patrol_index]
			if position.distance_to(target) < 1:
				patrol_index = wrapi(patrol_index + 1, 0, patrol_points.size())
				target = patrol_points[patrol_index]
			velocity = (target - position).normalized() * run_speed
			animation_player.play("Walk")
			
		# Move towards player.
		states.CHASE:
			target = player.position
			velocity = (target - position).normalized() * run_speed
			animation_player.play("Walk")

		# Make an attack.
		states.ATTACK:
			velocity = Vector2.ZERO
			target = player.position
			
			if target.x > position.x:
				$Sprite2D.flip_h = true
			elif target.x < position.x:
				$Sprite2D.flip_h = false
			
			var player_animation_player: AnimationPlayer = player.get_node('AnimationPlayer')
			if 'Damage' in [player_animation_player.current_animation, animation_player.current_animation]:
				return
				
			if animation_player.current_animation == 'Walk':
				animation_player.play(attacks[0])
				
				player.lifes -= 10
				player_animation_player.play('Damage')
				print('1 : ', player.lifes)
			elif not animation_player.is_playing():	
				var rand_attack = attacks[randi() % attacks.size()]
				animation_player.play(rand_attack)
				
				player.position.x -= 2
				player.lifes -= 10
				player_animation_player.play('Damage')
				print('2 : ', player.lifes)
			
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


func _on_attack_radius_body_entered(body: Node2D):
	if body is Player:
		print("attack entered: ATTACK ", body.get_node("AnimationPlayer").current_animation, ' ', animation_player.current_animation)
		state = states.ATTACK
		velocity = Vector2.ZERO


func _on_attack_radius_body_exited(body):
	print("attack CHASE after Attack, L: ", body.lifes)

	if body is Player:
		state = states.CHASE
		
		if body.lifes <= 0:
			body.position.x -= 300
			body.modulate.a = 0.2
			
