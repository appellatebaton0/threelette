extends CollisionComponent
class_name BasicCollisionComponent

func _on_body_entered(body: Node2D) -> void:
	bullet.queue_free()
func _on_area_entered(area: Area2D) -> void:
	bullet.queue_free()
