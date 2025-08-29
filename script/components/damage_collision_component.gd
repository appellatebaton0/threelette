extends CollisionComponent
class_name DamageCollisionComponent

var me:Area2D = get_me()
@onready var damage_components:Array[DamageComponent]

@export var duplicate_damage:bool = false
@export var die_on_hit_environment:bool = false

@export var damage_delay:float = 0.3
var damage_timer:float = 0.0

func _once_ready():
	if actor != null:
		damage_components = actor.get_damage_components()

func _process(delta: float) -> void:
	if damage_timer <= 0:
		for area in me.get_overlapping_areas():
			if on_hit(area.get_parent()):
				damage_timer = damage_delay
		for body in me.get_overlapping_bodies():
			if on_hit(body.get_parent()):
				damage_timer = damage_delay
	damage_timer = move_toward(damage_timer, 0, delta)

func on_hit(hit_target):
	hit_something.emit()
	if hit_target is Actor:
		if hit_target == actor:
			return false
		
		for damage_component in damage_components:
			var new_dmg:DamageComponent = damage_component.duplicate()
			
			new_dmg.source = damage_component.source
			
			add_child(new_dmg)
			new_dmg.apply_to(hit_target)
			return true
	elif die_on_hit_environment:
		actor.queue_free()
		return true
