extends Camera2D

@export var target: = NodePath()  # Assign the node this camera will follow.

var decay = 0.8  # How quickly the shaking stops [0, 1].
var max_offset = Vector2(100, 75)  # Maximum hor/ver shake in pixels.
var max_roll = 0.1  # Maximum rotation in radians (use sparingly).
var trauma = 0.0  # Current shake strength.
var trauma_power = 2  # Trauma exponent. Use [2, 3].
var noise_y = 0
	
@onready var noise: FastNoiseLite = FastNoiseLite.new()


func _ready():
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.fractal_type = FastNoiseLite.FRACTAL_FBM
	noise.frequency = 0.01
	noise.fractal_lacunarity = 2.0
	noise.fractal_gain = 0.5

	
func add_trauma(amount: float = 0.24):
	trauma = min(trauma + amount, 1.0)
	

func _process(delta):
	if trauma and target:
		global_position = get_node(target).global_position
		trauma = max(trauma - decay * delta, 0)
		shake()


func shake():
	var amount = pow(trauma, trauma_power)
	noise_y += 1
	rotation = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	var _seed = amount * noise.get_noise_2d(noise.seed*2, noise_y)
	offset.x = max_offset.x * _seed
	offset.y = max_offset.y * _seed
