extends Node2D

export var jump_strength = 100
export var gravity = 20

export(NodePath) var kinematic_body_node_path

onready var kinematic_body = get_node(kinematic_body_node_path)
var velocity = 0
var can_jump = true
var is_on_airship = false
var passive_velocity = 0
var jump_velocity = 0
var i = 0
func _ready():
	if !kinematic_body:
		push_error("Jump Component needs Kinematic Body to work please assign.")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	apply_gravity()
	cancel_velocity_on_ceiling()
	
	if Input.is_action_just_pressed("jump") and can_jump:
		apply_jump()
		can_jump = false
	if is_on_airship:
		velocity = velocity + passive_velocity 
	kinematic_body.move_and_slide(Vector2(0,velocity + jump_velocity), Vector2.UP)



func apply_gravity():
	if i > 10:
		print("Is on ground: " , is_touching_ground(), " Is on airship: ", is_on_airship, "Jump Velocity: " , jump_velocity)
		i = 0
	i = i+1

	if !is_touching_ground() and !is_on_airship:
		can_jump = false
		velocity = velocity + gravity / 2
	else:
		if jump_velocity >= 0:
			velocity = 0
		can_jump = true

	jump_velocity = jump_velocity + gravity / 2
	jump_velocity = clamp(jump_velocity, -999,0)
	

func cancel_velocity_on_ceiling():
	if kinematic_body.is_on_ceiling():
		velocity = 1

func apply_jump():
	jump_velocity = -jump_strength

func is_touching_ground():
	var raycastDir = Vector2(0,8.5)
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(global_position, global_position + raycastDir,[get_parent()])
	if result:
		return true
	else:
		return false
