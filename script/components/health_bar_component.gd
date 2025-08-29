extends Component
class_name HealthBarComponent

@onready var me:TextureProgressBar = get_me()
@onready var health_component:HealthComponent = actor.get_health_component()

@export var show_time:float = 1.5
var show_timer:float = 0.0

func _once_ready() -> void:
	health_component.took_damage.connect(_on_took_damage)
	me.max_value = health_component.max_health

func _process(delta: float) -> void:
	me.modulate.a = lerp(me.modulate.a, min(1.0, show_timer), 0.4)
	
	me.value = lerp(me.value, health_component.health, 0.4)
	
	show_timer = move_toward(show_timer, 0, delta)

func _on_took_damage():
	show_timer = show_time
