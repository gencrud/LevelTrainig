# Boilerplate class to get full autocompletion and type checks for the `player` when coding the player's states.
# Without this, we have to run the game to see typos and other errors the compiler could otherwise catch while scripting.
class_name PlayerState
extends State

# Typed reference to the player node.
var player: Player


func _ready() -> void:
	# The states are children of the `Player` node so their `_ready()` callback will execute first.
	# That's why we wait for the `owner` to be ready first.
	await owner.ready
	# The `as` keyword casts the `owner` variable to the `Player` type.
	# If the `owner` is not a `Player`, we'll get `null`.
	player = owner as Player
	# This check will tell us if we inadvertently assign a derived state script
	# in a scene other than `Player.tscn`, which would be unintended. This can
	# help prevent some bugs that are difficult to understand.
	assert(player != null)


func _is_playing_beat(animation_player: AnimationPlayer, _state_name: String) -> bool:
	return "Beat" in animation_player.current_animation and animation_player.current_animation == _state_name and animation_player.is_playing()


func _can_use_next_combo(animation_player: AnimationPlayer, _state_name: String) -> bool:
	return Input.is_action_just_pressed("beat") and player.beat_is_collision and animation_player.current_animation != 'Damage'
