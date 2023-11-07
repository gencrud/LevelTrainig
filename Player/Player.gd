class_name Player
extends CharacterBody2D

const SPEED: float = 340.0
const JUMP_IMPULSE: float = -540.0

const FRICTION: float = 8.0
# const AIR_FRICTION: float = 10.0 # Not using so far
# const ACCELERATION: float = 180.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# Can go to next state of combo beat when true 
var beat_is_collision: bool = false
var _enemy: Node2D
var lifes = 100


func get_direction(do_flip:bool = false) -> Vector2:
	var direction_x: = Input.get_axis("ui_left", "ui_right")	
	var direction_y: = Input.get_axis("ui_up", "ui_down")
	
	if do_flip:
		# Todo: move logic setter direction of fliping
		if not $Sprite.flip_h and direction_x == -1:
			$Sprite.flip_h = true
		elif direction_x == 1:
			$Sprite.flip_h = false
		
	return Vector2(direction_x, direction_y)


func is_on_moving() -> bool:
	var direction = get_direction()
	return not is_zero_approx(direction.x) or not is_zero_approx(direction.y)


"""
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = get_direction()		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
"""
