extends CharacterBody2D
class_name PunchingBag

const REBOUND_AFTER_IMPACT: int = 12
const ANIMATION_NAME_BOUNCE: String = 'Damage'

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var life_label_1: Label = $Label
@onready var life_label_2: Label = $Label2
@onready var life_label_3: Label = $Label3


func _ready():
	life_label_1.visible = false
	life_label_2.visible = false
	life_label_3.visible = false
	

func _on_beat_area_area_entered(area: Area2D):
	if area.owner is Player:
		area._on_body_entered(area.owner)
		$StateMachine/Idle.state_machine.transition_to(ANIMATION_NAME_BOUNCE)
		# animation_player.play(ANIMATION_NAME_BOUNCE)
			

func play_bounce_bad():
	$StateMachine/Idle.state_machine.transition_to(ANIMATION_NAME_BOUNCE)

		
func die():
	position.x += REBOUND_AFTER_IMPACT
	
	if life_label_3.visible:
		modulate.a = 0.5
		
		life_label_1.visible = false
		life_label_2.visible = false
		life_label_3.visible = false
		
		$BeatArea/CollisionShape2D.disabled = true
		$BounceParticles.emitting = true
		await get_tree().create_timer(0.8).timeout
		queue_free()
		
	elif life_label_2.visible:
		life_label_3.visible = true
	elif life_label_1.visible:
		life_label_2.visible = true
	else:
		life_label_1.visible = true
