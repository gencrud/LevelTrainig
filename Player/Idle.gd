# class_name Idle
extends PlayerState

const STATE_NAME: String = "Idle"
const STATE_NAME_NEXT: String = "IdleBeat"

var changed_scale: bool = false

@export var _animation_player: = NodePath() 
@onready var animation_player: AnimationPlayer = get_node(_animation_player)


func enter(_msg := {}) -> void:
	animation_player.play(STATE_NAME)


func _input(event):

	if event.is_action_pressed("ui_right") and changed_scale:
		player.scale.x = -1
		changed_scale = false
	elif event.is_action_pressed("ui_left") and not changed_scale:
		player.scale.x = -1
		changed_scale = true


func physics_update(delta: float) -> void:	
	# сбрасываем скорость при остановке персонажа
	if not is_zero_approx(player.velocity.x):
		player.velocity.x = lerp(player.velocity.x, 0.0, player.FRICTION * delta)
	if not is_zero_approx(player.velocity.y): 
		player.velocity.y = lerp(player.velocity.y, 0.0, player.FRICTION * delta)
	
	player.move_and_slide()

	if Input.is_action_just_pressed("ui_accept"): # and player.is_on_flat():
		state_machine.transition_to("Air", {do_jump = true})
	elif Input.is_action_just_pressed("beat") and animation_player.current_animation != 'Damage':
		state_machine.transition_to(STATE_NAME_NEXT)
	elif player.is_on_moving():	
		state_machine.transition_to("Walk")

