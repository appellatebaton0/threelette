extends BulletComponent
class_name DamageComponent

# Reparents to the target on hit and runs from there.

var on_target:bool = false
var target:Ghost

func get_health_component() -> HealthComponent:
	for child in target.get_children():
		if child is HealthComponent:
			return child
	return null

func get_collision_component() -> CollisionComponent:
	var parent = get_parent()
	
	for child in parent.get_children():
		if child is CollisionComponent:
			return child
	
	return null

func _ready() -> void:
	var col = get_collision_component().area
	col.area_entered.connect(_on_area_entered)
	col.body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	if on_target:
		while_on_target(delta)

func while_on_target(_delta:float):
	pass

func _on_body_entered(body: Node2D) -> void:
	if body is Ghost:
		on_target = true
		reparent(body)
		target = body
func _on_area_entered(area: Area2D) -> void:
	if area is Ghost:
		on_target = true
		reparent(area)
		target = area
