extends Component
class_name MotionComponent

signal state_changed(to:String)
var state:String = "idle"

var direction:Vector2

func change_state(to:String):
	if state == to:
		return
	
	state = to
	
	state_changed.emit(to)

func is_facing_left() -> bool:
	return false
