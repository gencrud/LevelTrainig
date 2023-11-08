extends CharacterBody2D
class_name PunchingBag

const REBOUND_AFTER_IMPACT: int = 4

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var life_label_1: Label = $Label
@onready var life_label_2: Label = $Label2
@onready var life_label_3: Label = $Label3


func _on_beat_area_area_entered(area: Area2D):
	# Зона поражения плэера должна проходить мимо зоны поражения объекта
	if area.name == 'BeatArea': 
		return
	
	# Удары плэера попадают в зону поражения объекта
	if area.owner is Player and area.name == 'AttackArea':
		if not $BeatArea/CollisionShape2D.disabled:
			area.owner.get_node('AttackArea')._on_body_entered(area.owner)
			$StateMachine/Idle.state_machine.transition_to('Damage', {player=area.owner})


func _on_beat_area_body_entered(body: Node2D):
	if body is Player:
		body.velocity = Vector2.ZERO
		body.get_node('StateMachine/Idle').state_machine.transition_to('Idle')
