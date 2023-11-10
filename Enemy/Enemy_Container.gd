extends Node2D


@onready var monster = load("res://Enemy/monster.tscn/Player.tscn")
var starting_position = Vector2(300,300)

func _physics_process(_delta):
	if not has_node("Monster"):
		var player = monster.instantiate()
		monster.position = starting_position
		add_child(monster)
