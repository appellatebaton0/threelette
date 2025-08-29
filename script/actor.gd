extends Node2D
class_name Actor

func get_component(look_name:String) -> Component:
	for child in get_children():
		if child.name == look_name:
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

func get_shoot_component() -> ShootComponent:
	for child in get_children():
		if child is ShootComponent:
			return child
	return null


func get_damage_components() -> Array[DamageComponent]:
	var components:Array[DamageComponent]
	
	for child in get_children():
		if child is DamageComponent:
			components.append(child)
	
	return components



#
#func _process(delta: float) -> void:
	#var c:Array[DamageComponent]
	#for child in get_children():
		#if child is DamageComponent:
			#c.append(child)
	#if len(c) != 0:
		#print(self, " has ", c)
