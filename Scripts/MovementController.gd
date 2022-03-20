extends Node2D
# Manages additional movement calculation like passive movement on an airship

export(NodePath) var movement_node_path
export(NodePath) var airship_observer_node_path

onready var movement_node = get_node(movement_node_path)
onready var airship_observer_node = get_node(airship_observer_node_path)
func _ready():
	if !movement_node:
		push_error("MovementController needs movement component. Please assign")
	if !airship_observer_node:
		push_error("MovementController needs airship observer component. Please assign")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	calculate_passive_movement()

func calculate_passive_movement():
	if airship_observer_node.airship_last_stood_on:
		var airship_movement = airship_observer_node.airship_last_stood_on.get_node("AirshipMovement")
		print(airship_movement.velocity, movement_node.velocity)
		movement_node.passive_velocity = airship_movement.velocity.x