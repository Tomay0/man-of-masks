extends CharacterBody2D

var jump_press_time = 0
var in_air_time = 0
var jump_time = 0
var is_requesting_jump = false
var is_jumping = false

const SPEED = 300.0
const GRAVITY = 3000.0
const JUMP_VELOCITY = -800.0
const FLOATING_JUMP_MULTIPLIER = 0.4
const FAST_FALL_MULTIPLIER = 1.5
const JUMP_PRESS_BUFFER = 0.05
const COYOTE_PRESS_BUFFER = 0.125
const MIN_JUMP_TIME = 0.1
const MAX_JUMP_TIME = 0.5

# fast fall - when your velocity goes to falling - increase gravity
# hold jump - 2 gravity constants, when you release you go to heavier gravity.
# Minimum jump height and maximum jump height to have a max hold time.


func fast_fall_multiplier():
	var multi = 1.0
	
	if velocity.y > 0:
		multi *= FAST_FALL_MULTIPLIER
	
	if is_jumping:
		multi *= FLOATING_JUMP_MULTIPLIER
	
	return multi

func handle_in_air(delta: float):
	in_air_time += delta
	velocity.y += GRAVITY * delta * fast_fall_multiplier()

func request_jump():
	is_requesting_jump = true
	jump_press_time = 0

# trigger an actual jump, switch from 'requesting' to actually jumping
func jump():
	velocity.y = JUMP_VELOCITY
	jump_time = 0
	is_requesting_jump = false
	is_jumping = true

# attempt to jump
func try_jump():
	if is_requesting_jump and jump_press_time <= JUMP_PRESS_BUFFER and in_air_time <= COYOTE_PRESS_BUFFER:
		jump()
	

# when you land on the groud, reset 'in air time'
func handle_on_floor(delta: float):
	in_air_time = 0

func hold_jump_time(delta: float):
	jump_time += delta
	
	# we only want to stop your jumping once you pass the minimum jump time
	if jump_time > MIN_JUMP_TIME and not Input.is_action_pressed("ui_accept"):
		is_jumping = false
	
	if jump_time > MAX_JUMP_TIME:
		is_jumping = false


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		jump_press_time += delta
	
	# if you are currently jumping, extend your jump time
	if is_jumping:
		hold_jump_time(delta)
	
	# attempt to jump when you press the button
	if Input.is_action_just_pressed("ui_accept"):
		request_jump()
	
	# will try jumping if a jump has been requested and the conditions for jumping have been met
	try_jump()
	
	if is_on_floor():
		handle_on_floor(delta)
	else:
		handle_in_air(delta)
		
	print("JUMP PRESS TIME: %s" % jump_press_time)
	print("In air time: %s" % in_air_time)
	print("Jump time: %s" % jump_time)
	print("Is requesting jump: %s" % is_requesting_jump)
	print("Is jumping: %s" % is_jumping)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
