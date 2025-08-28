extends TextureButton
class_name UpgradeButton

signal selected(upgrade:Component)

@onready var main:Main = get_tree().get_first_node_in_group("Main")
@onready var wave_spawner:WaveSpawner = get_tree().get_first_node_in_group("WaveSpawner")
@onready var valid_upgrades:Array[Component] = get_valid_upgrades()

@export var label:Label
func get_valid_upgrades() -> Array[Component]:
	var upgrades:Array[Component]
	
	for child in get_children():
		if child is Component:
			upgrades.append(child)
	
	return upgrades

var upgrade:Component
@export var primary:bool = false
@export var next:UpgradeButton

func load_new_upgrade(with:Array[Component] = valid_upgrades):
	var options:Array[Component] = with.duplicate(true)
	
	var choice:Component = options.pick_random()
	options.erase(choice)
	
	choice = choice.duplicate()
	
	choice.randomize_values()
	
	upgrade = choice
	
	label.text = upgrade.component_effect()
	
	
	if next != null:
		next.load_new_upgrade(options)

func _ready() -> void:
	main.reset.connect(_on_reload)
	wave_spawner.round_complete.connect(_on_reload)
	pressed.connect(_on_pressed)
	_on_reload()


func _on_pressed() -> void:
	selected.emit(upgrade)

func _on_reload():
	if primary:
		load_new_upgrade()
