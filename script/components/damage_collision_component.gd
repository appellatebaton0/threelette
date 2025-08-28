extends CollisionComponent
class_name DamageCollisionComponent

@onready var damage_components:Array[DamageComponent]

@export var duplicate_damage:bool = false
@export var die_on_hit_environment:bool = false

func _once_ready():
	if actor != null:
		damage_components = actor.get_damage_components()

func _on_hit(hit_target):
	if hit_target is Actor:
		if hit_target == actor:
			return
		
		for damage_component in damage_components:
			var new_dmg:DamageComponent = damage_component.duplicate()
			
			new_dmg.source = damage_component.source
			
			add_child(new_dmg)
			new_dmg.apply_to(hit_target)
	elif die_on_hit_environment:
		actor.queue_free()

func _on_area_entered(area: Area2D) -> void:
	_on_hit(area.get_parent())
func _on_body_entered(body: Node2D) -> void:
	_on_hit(body.get_parent())
