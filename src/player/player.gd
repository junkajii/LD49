class_name Player
extends KinematicBody2D


onready var audio_player := $AudioStreamPlayer2D
onready var anim_tree := $AnimationTree
onready var anim_state = anim_tree.get("parameters/playback")

const SPEED_MAX := 70.0
const ACCELERATION := 10
const GRAVITY := 8.0
const GRAVITY_MAX := 160.0
const JUMP_HEIGHT := -150.0
const DOUBLE_JUMP_HEIGHT := -150.0
const FLOOR_NORMAL := Vector2.UP

var jump_count : int = 2
var jumps_remaining : int = 0
var velocity := Vector2.ZERO
var direction : int = 0
var buffer_counter : int = 0
var buffer_max : int = 4
var coyote_counter : int = 0
var coyote_max : int = 10
var jumped : bool = false

func _ready() -> void:
	anim_tree.active = true


func _physics_process(_delta : float) -> void:
	velocity.y = min(velocity.y + GRAVITY, GRAVITY_MAX)

	direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

	if direction > 0:
		velocity.x = min(velocity.x + ACCELERATION, SPEED_MAX)
		$Sprite.flip_h = false
	elif direction < 0:
		velocity.x = max(velocity.x - ACCELERATION, -SPEED_MAX)
		$Sprite.flip_h = true
	else:
		velocity.x = 0

	if is_on_floor():
		if direction < 0:
			anim_state.travel("walk")
		elif direction > 0:
			anim_state.travel("walk")
		else:
			anim_state.travel("idle")

	if !is_on_floor():
		if coyote_counter > 0:
			coyote_counter -= 1
			if !jumped:
				if Input.is_action_just_pressed("jump"):
					velocity.y = JUMP_HEIGHT
					jumped = true
					jumps_remaining = jump_count - 1
		else:
			if jumped and Input.is_action_just_pressed("jump"):
				if jumps_remaining > 0:
					audio_player.play()
					velocity.y = DOUBLE_JUMP_HEIGHT
					jumps_remaining -= 1
	else:
		jumped = false
		coyote_counter = coyote_max

	if Input.is_action_just_pressed("jump"):
		buffer_counter = buffer_max
	if buffer_counter > 0:
		buffer_counter -= 1
		if is_on_floor():
			audio_player.play()
			velocity.y = JUMP_HEIGHT
			buffer_counter = 0
			jumped = true
			jumps_remaining = jump_count - 1

	if !is_on_floor():
		if velocity.y < 0:
			anim_state.travel("jump")
		else:
			anim_state.travel("fall")

	velocity = move_and_slide(velocity, FLOOR_NORMAL)


func death() -> void:
	print("DEATH!!!")
