extends Node2D

export var running_speed = 100
export(NodePath) var kinematic_body_node_path

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var kinematic_body : KinematicBody2D = get_node(kinematic_body_node_path)

var movement_dir = 0 
var velocity = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	if !kinematic_body:
		push_error("Movement Component needs kinematic body to work please assign.")	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	calculate_movement_dir()
	apply_horizontal_movement()

	kinematic_body.move_and_slide(Vector2(velocity,0), Vector2.UP)

func calculate_movement_dir():
	if Input.is_action_pressed("move_left"):
		movement_dir = -1
	elif Input.is_action_pressed("move_right"):
		movement_dir = 1
	else:
		movement_dir = 0

func apply_horizontal_movement():
	velocity = movement_dir * running_speed
