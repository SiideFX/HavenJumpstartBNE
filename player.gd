extends CharacterBody2D
@onready var chain_knife = $ChainKnife

const SPEED = 300.0
const JUMP_VELOCITY = -750.0
var state: String = "idle"

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor() and state != "slam":
		velocity += get_gravity() * delta
		state = "fall"

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		state = "jump"

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if velocity.y > 1500:
		get_tree().reload_current_scene()

	move_and_slide()
	
func _on_body_entered(body):
	if body.is_in_group("Coin"):
		body.queue_free() # Deletes the specific body that collided
