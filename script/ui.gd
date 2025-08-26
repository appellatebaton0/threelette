extends Control
class_name UI

@export var player:Actor
@onready var player_health_component:HealthComponent = get_player_health_component()
func get_player_health_component() -> HealthComponent:
	for child in player.get_children():
		if child is HealthComponent:
			return child
	return null

@onready var health_bar:TextureProgressBar = $MarginContainer/HBoxContainer/HealthBar

func _process(delta: float) -> void:
	if player_health_component != null:
		health_bar.value = player_health_component.health
		health_bar.max_value = player_health_component.max
