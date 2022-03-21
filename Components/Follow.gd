extends Node2D

export(NodePath) var follower_node_path
export(NodePath) var followee_node_path
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var follower_node = get_node(follower_node_path)
onready var followee_node = get_node(followee_node_path)

func _ready():
	if !follower_node:
		push_error("Component needs follower node please assign")
	if !followee_node:
		push_error("Component needs followee node please assign")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	follower_node.position = followee_node.position
