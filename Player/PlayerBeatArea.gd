extends Area2D
class_name BeatArea


func _on_body_entered(body: Node2D):
	#print("Beat to body: ", body)
	if owner is Player:
		owner.beat_is_collision = true
		$GPUParticles.emitting = true
		owner.get_node("Camera2D").add_trauma()


func _on_body_exited(body: Node2D):
	#print("Exit beat to body: ", body)
	if owner is Player:
		owner.beat_is_collision = false
		

func _on_area_entered(area: Area2D):
	print("Beat to area: ", area)
