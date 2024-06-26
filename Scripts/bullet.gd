extends Node3D

const speed = 40.0

# Called when the node enters the scene tree for the first time.
@onready var mesh = $Cylinder
@onready var ray = $RayCast3D
@onready var particles = $GPUParticles3D
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.basis * Vector3(0,0,-speed) * delta 
	if ray.is_colliding():
		mesh.visible = false
		particles.emitting = true
		ray.enabled = false
		if ray.get_collider().is_in_group("enemy"):
			ray.get_collider().hit()
		await get_tree().create_timer(1.0).timeout
		queue_free()
		


func _on_timer_timeout():
	queue_free()
