extends CharacterBody2D
class_name Ball

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
		animation_player.play("bounce_bad")


func play_bounce_bad():
	if not animation_player.is_playing():
		animation_player.play("bounce_bad")

		
func health():
	if life_label_3.visible:
		modulate.a = 0.5

		life_label_1.visible = false
		life_label_2.visible = false
		life_label_3.visible = false
		
		$BeatArea/CollisionShape2D.disabled = true
		$BounceParticles.emitting = true
		await get_tree().create_timer(1).timeout
		queue_free()
		
	elif life_label_2.visible:
		life_label_3.visible = true
	elif life_label_1.visible:
		life_label_2.visible = true
	else:
		life_label_1.visible = true
