extends RayCast2D

export(NodePath) var kinematic_body_node_path

onready var kinematic_body = get_node(kinematic_body_node_path)
var airship_last_stood_on

var _collision : KinematicCollision2D
# Called when the node enters the scene tree for the first time.
func _ready():
	if !kinematic_body:
		push_error("AirshipObserver needs kinematic body to work. Please assign.")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	_collision  = kinematic_body.get_last_slide_collision()

	if _collision and _collision.collider.is_in_group("airship"): 
		airship_last_stood_on = _collision.collider
	
func is_standing_on_airship_currently():

	if get_collider() and get_collider().is_in_group("airship"):
		return true
	else:
		return false
