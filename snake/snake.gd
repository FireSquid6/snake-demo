extends Node2D

var _part_scene = preload("res://snake_part/snake_part.tscn")
var _parts: Array[SnakePart] = []
var head: SnakePart

func _ready():
	for child in get_children():
		_parts.append(child)
	
	head = _parts[0]
	
	_move()


func _on_head_at_point():
	for part in _parts:
		part.teleport()
	print("they're at the head")
	_move()


func _move():
	head.goto(head.position + Vector2(-64, 0))
	
	for i in range(1, len(_parts)):
		var part := _parts[i]
		var ahead := _parts[i - 1]
		part.goto(ahead.position)
