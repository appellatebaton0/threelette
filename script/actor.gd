extends Node2D
class_name Actor

func get_component(name:String) -> Component:
	for child in get_children():
		if child.name == name:
			return child
	return null

func get_motion_component() -> MotionComponent:
	for child in get_children():
		if child is MotionComponent:
			return child
	return null

func get_health_component() -> HealthComponent:
	for child in get_children():
		if child is HealthComponent:
			return child
	return null

func get_damage_component() -> DamageComponent:
	for child in get_children():
		if child is DamageComponent:
			return child
	return null
#
#func _process(delta: float) -> void:
	#var c:Array[DamageComponent]
	#for child in get_children():
		#if child is DamageComponent:
			#c.append(child)
	#if len(c) != 0:
		#print(self, " has ", c)
