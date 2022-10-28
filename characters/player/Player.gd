extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var GRAVITY = 30
const MAXFALLSPEED = 200
const MAXSPEED = 200
const JUMPFORCE = 1000
const ACCELERATION = 40

var velocity = Vector2.ZERO
var facing_right = true

func _physics_process(delta):
	
	if facing_right:
		$Sprite.scale.x = 1
	else:
		$Sprite.scale.x = -1
	
	# Handling gravity
	velocity.y += GRAVITY
	if velocity.y > MAXFALLSPEED:
		velocity.y = MAXFALLSPEED

	velocity.x = clamp(velocity.x, -MAXSPEED, MAXSPEED)
	
		
	if Input.is_action_pressed("move_right"):
		velocity.x += ACCELERATION
		facing_right = true
		$AnimationPlayer.play("run")
		
	elif Input.is_action_pressed("move_left"):
		velocity.x -= ACCELERATION
		facing_right = false
		$AnimationPlayer.play("run")
		
	else:
		velocity.x = lerp(velocity.x, 0, 0.2)
		$AnimationPlayer.play("idle")
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			print("JUMP ACTION")
			velocity.y -= JUMPFORCE
			$AnimationPlayer.play("jump")
	else:
		if velocity.y > 0:
			$AnimationPlayer.play("fall")
		elif velocity.y < 0:
			$AnimationPlayer.play("jump")
	
	
	# Setting the position
	var motion = move_and_slide(velocity, Vector2.UP)

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Player is spawned!!!!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
