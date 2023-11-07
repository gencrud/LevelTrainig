extends Area2D
class_name BeatArea


func _on_body_entered(body: Node2D):
	print("player body: ", body.name, ' vs ', owner)
	if owner is Player:
		owner.beat_is_collision = true
		$GPUParticles.emitting = true
		
		

func _on_body_exited(body: Node2D):
	#print("Exit beat to body: ", body)
	if owner is Player:
		owner.beat_is_collision = false
		

func _on_area_entered(area: Area2D):
	if owner is Player:
		pass
		#owner._enemy = area.owner
				
		# todo:print("player area ", area.owner.name, ' vs ...')
		
		'''
		if owner._enemy is Enemy: # and owner.get_node("AnimationPlayer").current_animation != 'Damage':
			var player_animation_player: AnimationPlayer = owner.get_node('AnimationPlayer')
			if 'Damage' in [player_animation_player.current_animation, owner._enemy.animation_player]:
				return
					
			_on_body_entered(owner)
			owner._enemy.animation_player.play("Damage")
			owner._enemy.lifes -= 10
			owner._enemy.modulate.a -= 0.02
			
			if owner._enemy.lifes <= 0:	
				owner._enemy.position.x += 200
				await get_tree().create_timer(0.6).timeout
				if is_instance_valid(owner._enemy):
					owner._enemy.queue_free()
				'''
