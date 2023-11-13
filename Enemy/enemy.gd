extends CharacterBody2D
class_name Enemy

enum states {PATROL, CHASE, ATTACK, DEAD}
# var state = states.PATROL
var lifes = 100

# For setting animations.
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
	
		
"""	
func _physics_process(delta):
	choose_action()
	move_and_slide()

func choose_action():
	if state == 0: return
	print("S: ", state, '; A: ', animation_player.current_animation)
	
	# velocity = Vector2.ZERO
	# If we're currently attacking, don't move or change state.
	if animation_player.current_animation in attacks: 
		return

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
		#states.CHASE:
		#	target = player.position
		#	velocity = (target - position).normalized() * run_speed
		#	animation_player.play("Walk")
	

		# Make an attack.
		#states.ATTACK:
		#	velocity = Vector2.ZERO
		#	target = player.position
						
			# var rand_attack = attacks[randi() % attacks.size()]	
		#	animation_player.play('Attack_1')

			'''
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
			'''
			# anim_state.travel("attack")
"""


func _on_detect_radius_body_entered(body: Node2D):
	if body is Player:
		$StateMachine.state.state_machine.transition_to('Chase', {player=body})


func _on_detect_radius_body_exited(body: Node2D):
	print('DETECT EXITED ', body.name)
	if body is Player:
		$StateMachine.state.state_machine.transition_to('Idle')


func _on_attack_radius_body_entered(body: Node2D):
	if body is Player:
		$StateMachine.state.state_machine.transition_to('Attack_1', {player=body})
		

func _on_attack_radius_body_exited(body: Node2D):
	print('ATTACK EXITED ', body.name)
	if body is Player:
		$StateMachine.state.state_machine.transition_to('Chase', {player=body})
		
		# todo: BAAAD
		if body.lifes <= 0:
			body.position.x -= 300
			body.modulate.a = 0.2
			
