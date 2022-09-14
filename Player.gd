extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
const UP = Vector2(0, -1)
const FLAP = 200
const MAXFALLSPEED = 200
const GRAVITY = 10

var motion = Vector2()
var Wall = preload("res://Wallnode.tscn")
var score = 0

func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	if Input.is_action_just_pressed("FLAP"):
		motion.y = -FLAP
	
	motion = move_and_slide(motion, UP)
	get_parent().get_parent().get_node("CanvasLayer/RichTextLabel").text = str(score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func Wall_reset():
	var Wall_instance = Wall.instance()
	Wall_instance.position = Vector2(450, rand_range(-60, 60))
	get_parent().call_deferred("add_child", Wall_instance)

func _on_Resetter_body_entered(body):
	if body.name == "Walls":
		body.queue_free()
		Wall_reset()


func _on_Detect_area_entered(area):
	if area.name == "PointArea":
		score = score + 1


func _on_Detect_body_entered(body):
	if body.name == "Walls":
		get_tree().reload_current_scene()
