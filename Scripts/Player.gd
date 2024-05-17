extends CharacterBody3D
#movement
@export_category("Movement")
@export var maxSpeed = 4.0

@export_category("Jumping")
@export var jumpForce = 5.0
@export var gravityModifer = 1.5

#camera
@export_category("Camera")
@export var lookSensitivity = .005
var cameraLookInput :Vector2

@onready var camera : Camera3D = $Camera3D 
@onready var gameGravity = ProjectSettings.get_setting("physics/3d/default_gravity") * gravityModifer 


func _ready():
	camera.rotation = Vector3(0,0,0) 
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _physics_process(delta):
	if not is_on_floor():# gravity
		velocity.y -= gameGravity * delta
	if Input.is_action_pressed("Jump") and is_on_floor(): # jumping
		velocity.y = jumpForce
	var moveInput = Input.get_vector("Move Left","Move Right","Move Forward", "Move backward")
	var moveDir = (transform.basis * Vector3(moveInput.x,0,moveInput.y).normalized())
	var moveSpeed = maxSpeed # makes max speed the base move speed add sprinting later.
	
	velocity.x = moveDir.x * moveSpeed
	velocity.z = moveDir.z * moveSpeed
	move_and_slide()
	
	rotate_y(-cameraLookInput.x * lookSensitivity)
	cameraLookInput.y = -cameraLookInput.y
	camera.rotate_x(cameraLookInput.y * lookSensitivity)
	
	camera.rotation.x = clamp(camera.rotation.x,-1,1)
	
	cameraLookInput = Vector2.ZERO # this resets the camera input each frame
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		cameraLookInput = event.relative
		
	
	

