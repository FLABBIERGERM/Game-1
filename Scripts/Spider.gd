extends CharacterBody3D
const SPEED = 3.5
var player = null
var health = 3
@export var damage: = 1
@export var player_path := "/root/Main/player"
@onready var nav_agent = $NavigationAgent3D
signal body_hit(damage)

@export var eins =  1

func _ready():
	player = get_node(player_path)


func _physics_process(delta):
	velocity = Vector3.ZERO
	#nav
	nav_agent.set_target_position(player.global_transform.origin)
	var next_nav_point = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_transform.origin).normalized() * SPEED
	
	look_at(Vector3(player.global_position.x, global_position.y ,player.global_position.z),Vector3.UP)
	
	
	move_and_slide()
func hit():
	emit_signal("body_hit", damage)
	health -= damage  
	print("Hit")
	if health <= 0:
		queue_free()
