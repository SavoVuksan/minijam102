extends Node2D

export var max_speed = 100
export var accelaration = 10

export(NodePath) var kinematic_body_node_path

onready var kinematic_body = get_node(kinematic_body_node_path)

var movement_dir = Vector2(0,0)
var velocity = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	if !kinematic_body:
		push_error("AirshipMovement Component needs kinematic body. Please assign.")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	calculate_movement_dir()
	calculate_velocity(delta)

	kinematic_body.move_and_slide(velocity, Vector2.UP)

func calculate_movement_dir():
	if Input.is_action_pressed("move_left"):
		movement_dir.x = -1
	elif Input.is_action_pressed("move_right"):
		movement_dir.x = 1
	else:
		movement_dir.x = 0
	if Input.is_action_pressed("move_up"):
		movement_dir.y = -1
	elif Input.is_action_pressed("move_down"):
		movement_dir.y = 1
	else:
		movement_dir.y = 0

func calculate_velocity(delta):
	velocity = velocity + movement_dir * accelaration * delta
	#velocity = velocity.clamped(max_speed)
