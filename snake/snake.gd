extends Node2D


# Godot does not have a distinction between private and public properties
# all private properties will be prefixed with an underscore

var _part_scene = preload("res://snake_part/snake_part.tscn")
var _parts: Array[SnakePart] = []
var head: SnakePart
var move_dir = Vector2(-1, 0)
var _last_move_dir = Vector2(-1, 0)

func _ready() -> void:
	for child in get_children():
		_parts.append(child)
	
	head = _parts[0]
	_move()


func _process(_delta: float) -> void:
	var left = int(Input.is_action_just_pressed("ui_left"))
	var right = int(Input.is_action_just_pressed("ui_right"))
	var up = int(Input.is_action_just_pressed("ui_up"))
	var down = int(Input.is_action_just_pressed("ui_down"))
	
	if up + left + down + right > 0:
		move_dir = Vector2(right - left, down - up)
		print(move_dir)


func _on_head_at_point() -> void:
	for part in _parts:
		part.teleport()
	_move()


func get_move_dir() -> Vector2:
	if move_dir.length() != 1:
		return _last_move_dir
	
	
	return move_dir


func _move() -> void:
	_last_move_dir = move_dir
	head.goto(head.position + (move_dir * 64))
	
	for i in range(1, len(_parts)):
		var part := _parts[i]
		var ahead := _parts[i - 1]
		part.goto(ahead.position)
