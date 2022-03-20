extends Node2D

export var jump_strength = 100
export var gravity = 20

export(NodePath) var kinematic_body_node_path

onready var kinematic_body = get_node(kinematic_body_node_path)
var velocity = 0
var can_jump = true
func _ready():
	if !kinematic_body:
		push_error("Jump Component needs Kinematic Body to work please assign.")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	apply_gravity()
	cancel_velocity_on_ceiling()
	
	if Input.is_action_just_pressed("jump") and can_jump:
		apply_jump()
		can_jump = false

	kinematic_body.move_and_slide(Vector2(0,velocity), Vector2.UP)



func apply_gravity():
	if !kinematic_body.is_on_floor():
		can_jump = false
		velocity = velocity + gravity
	else:
		velocity = 0
		can_jump = true

func cancel_velocity_on_ceiling():
	if kinematic_body.is_on_ceiling():
		velocity = 1

func apply_jump():
	velocity = -jump_strength
