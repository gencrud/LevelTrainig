extends Area2D
class_name BeatArea


func _on_body_entered(body: Node2D):
	print("player body: ", body.name, ' vs ', owner._enemy)
	if owner is Player:
		owner.beat_is_collision = true
		$GPUParticles.emitting = true
		
		

func _on_body_exited(body: Node2D):
	#print("Exit beat to body: ", body)
	if owner is Player:
		owner.beat_is_collision = false
		

func _on_area_entered(area: Area2D):
	if owner is Player:
		owner._enemy = area.owner
		print("player area ", area.owner.name, ' vs ...' )

