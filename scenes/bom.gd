extends RigidBody2D

@export var sceneName = "LoseScreen2"

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://scenes/" + sceneName + ".tscn")
	elif body != self: 
		queue_free()
