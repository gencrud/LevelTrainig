# class_name Walk
extends PlayerState

@export var _animation_player: = NodePath() 
@onready var animation_player: AnimationPlayer = get_node(_animation_player)


func enter(_msg := {}) -> void:
	animation_player.play("Walk")
	

func physics_update(delta: float) -> void:
	"""if not player.is_on_floor():
		state_machine.transition_to("Air")
		return"""

	if is_on_tilemap_wall(player):
		player.position.y = get_border_wall()
		return

	var direction: Vector2 = player.get_direction()	
	if direction != Vector2.ZERO:
		player.velocity = player.velocity.move_toward(direction * player.SPEED, player.SPEED * delta)
	else:
		player.velocity = player.velocity.move_toward(Vector2.ZERO, player.SPEED * delta)
	
	# player.move_and_slide()
	var collision: KinematicCollision2D = player.move_and_collide(player.velocity * delta)
	if collision:
		player.velocity = player.velocity.slide(collision.get_normal())
			
	if Input.is_action_just_pressed("ui_accept"):
		state_machine.transition_to("Air", {do_jump = true})
	elif direction == Vector2.ZERO:
		state_machine.transition_to("Idle")


func get_border_wall() -> int:
	return (get_viewport().get_visible_rect().size.y / 2 ) - 50


func is_on_tilemap_wall(player: Player) -> bool:
	var pos = player.transform.get_origin()
	return pos.y < get_border_wall()
	
	"""
	# Durty solution of fefine collision on WALL
	# var tile_map: TileMap = get_node('../../../TileMap2')
	# var tile_set: TileSet = tile_map.get_tileset()
	# var tile_pos: Vector2 = player.transform.get_origin()  # collision.get_position() # - collision.get_normal()
	
	# To fix of related to object position or viewport 
	# tile_pos.y -= player.global_position.y - 20
	# tile_pos.x -= player.global_position.x - 100
	# tile_pos.y -= 220
	#tile_pos.x += 20
	
	var cell: Vector2i = tile_map.local_to_map(tile_pos)
	print(cell, ' ', tile_pos, ' : ', player.global_position)
	print()

	for source_id in tile_set.get_source_count():
		if not tile_set.has_source(source_id):
			continue
				
		var source: TileSetAtlasSource = tile_set.get_source(source_id)
		if source.has_tile(cell):
			var tile_data = source.get_tile_data(cell, 0)
			return bool(tile_data and tile_data.get_custom_data('is_wall'))
	"""
		
	"""
	for i in player.get_slide_collision_count():	
		var collision = player.get_slide_collision(i)
		
		if collision.get_collider() is TileMap:
			var tile_map: TileMap = collision.get_collider()
			var tile_pos = collision.get_position() - collision.get_normal()
			var tile_set = tile_map.tile_set
		
			var clicked_cell: Vector2i = tile_map.local_to_map(tile_pos)
			var data = tile_map.get_cell_tile_data(0, clicked_cell)
			print(data)
			
			# print(tile_map.get_coords_for_body_rid(collision.get_collider_rid()))
			# print(tile_map.local_to_map(tile_map.get_coords_for_body_rid(collision.get_collider_rid())))
			
			# print(tile_map.local_to_map(tile_map.to_local(tile_pos)))
			print(tile_set.get_custom_data_layer_name(0))
			# print(tile_set.get_custom_data_layer_by_name('is_wall'))
			
			for source_id in tile_set.get_source_count():
				if not tile_set.get_source(source_id):
					continue
				
				var source = tile_set.get_source(source_id)
				
				for tile_index in source.get_tiles_count():
					var coords := source.get_tile_id(tile_index) 
					var tile_data = source.get_tile_data(coords, 0)
					
					if tile_data.get_custom_data('is_wall'):	
						print(tile_index, ' ' , coords, ' ', source, ' ', source_id)
	"""
					
