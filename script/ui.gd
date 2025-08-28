extends Control
class_name UI

signal upgrade_selected

@export var wave_spawner:WaveSpawner

@export var player:Actor
@onready var player_health_component:HealthComponent = player.get_health_component()
@onready var player_shoot_component:ShootComponent = player.get_shoot_component()

@onready var health_bar:TextureProgressBar = $MarginContainer/VBoxContainer/HealthBar
@onready var ghost_counter:Label = $MarginContainer/VBoxContainer/GhostCounter
@onready var round_counter:Label = $MarginContainer/VBoxContainer/RoundCounter

func _ready() -> void:
	for child in $UpgradeOption/Panel/MarginContainer/VBoxContainer.get_children():
		if child is UpgradeButton:
			child.selected.connect(_on_upgrade_selected)

func _process(delta: float) -> void:
	if player_health_component != null:
		health_bar.value = player_health_component.health
		health_bar.max_value = player_health_component.max
	
	var ghosts_left = len(get_tree().get_nodes_in_group("Ghost"))
	ghost_counter.text = (str(ghosts_left) + " Ghost Left") if ghosts_left == 1 else (str(ghosts_left) + " Ghosts Left")
	
	round_counter.text = "Round " + str(wave_spawner.round_num)
	
func _on_upgrade_selected(upgrade:Component):
	player.add_child(upgrade)
	upgrade.actor = player
	$UpgradeOption.hide()
	upgrade_selected.emit()


func _on_round_complete() -> void:
	$UpgradeOption.show()
