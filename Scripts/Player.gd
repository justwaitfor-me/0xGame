extends CharacterBody2D

@onready var animation_player = $AnimatedSprite2D
const SPEED = 300.0
const JUMP_VELOCITY = -1000.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(delta):
	if $"../Camera2D".global_position.y + 450 < global_position.y:
		$"../Camera2D/Label".show()
		$"../Camera2D/Button".show()
		$"../AudioStreamPlayer2D".play()
		
		get_tree().paused = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
		if not animation_player.is_playing():
			animation_player.play("up")

	# Get the input direction.
	var direction = Input.get_axis("ui_left", "ui_right")

	# Handle movement/deceleration and animation control
	if direction:
		velocity.x = direction * SPEED
		# Play "walk" animation when moving
		if not animation_player.is_playing():
			animation_player.play("walk")
	

	move_and_slide()