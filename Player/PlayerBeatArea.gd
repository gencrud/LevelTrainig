extends Area2D
class_name BeatArea


func _on_body_entered(body: Node2D):
	print("Beat to body: ", body)


func _on_area_entered(area: Area2D):
	print("Beat to area: ", area)
