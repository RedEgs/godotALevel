extends CharacterBody2D # The class for the character controller.

# ----------------------------------------------------------------------------------------------

@export var maxSpeed = 260 # Controls the speed that the player is limited to.
@export var acceleration = 3000 # Controls the rate at which the player will reach maxSpeed.
@export var friction = 700 # Controls the rate at which the player will slow down by when not accelerating.

@export var playerCamera: Camera2D # Exposes a variable, for the player camera, to the inspector.
@export var playerCast: RayCast2D

# I Chose this approach as it made the player movement feel smooth and polished. Not necessarily fundamentally important
# but may enhance some users experience with playing the game.

var input = Vector2.ZERO # Sets the speed to 0, so the player isn't moving when the game is loaded.

func _physics_process(delta): # Called during the physics processing step of the main loop. See the docs for the rest.
	playerMovement(delta) # Runs the playerMovement function below to handle the player's movement.
	
func getInput(): # This returns the normalised input vector based on godots inbuilt input system.
	input.x = int(Input.is_action_pressed("moveRight")) - int(Input.is_action_pressed("moveLeft")) # Gets the input along x-axis, which subtracts right movement from left movement.
	input.y = int(Input.is_action_pressed("moveDown")) - int(Input.is_action_pressed("moveUp")) # Gets the input along y-axis, which subtracts down movement from up movement.
	return input.normalized() # Returns the result of scaling the vector to unit length. See the docs for the rest.
	
func playerMovement(delta): # Function handles all player movement, which is reliant on getting input.
	input = getInput() # Runs the getInput() function above to return the normalized input vector.
	
	if input == Vector2.ZERO: # Checks if the player is not moving.
		if velocity.length() > (friction * delta): # If the velocity's magnitude (length) is more than our deceleration (friction * delta) 
			velocity -= velocity.normalized() * (friction * delta) # Slowly decreases the velocity value player's speed
		else:
			velocity = Vector2.ZERO # Stop the player completely
	else:
		velocity += (input * acceleration * delta) # Speeds character up by acceleration over time.
		velocity = velocity.limit_length(maxSpeed) # Limits the value / Clamps the value.
 
	move_and_slide() # Moves the player-controller based on velocity (Inbuilt Method). See the docs for the rest.


# ----------------------------------------------

func _process(delta): # While the script is running
	look_at(get_global_mouse_position()) # Changes the CharacterBody2D facing direction to be the position of the mouse on screen. No real use other than aesthetics.

# ----------------------------------------------
