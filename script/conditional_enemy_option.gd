extends Resource
class_name ConditionalEnemyOption

@export var scene:PackedScene
@export var cost:int = 1

enum CONDITION_TYPES{DIVISIBLE_BY_MATCH, PAST_ROUND, BEFORE_ROUND}
@export var condition_type:CONDITION_TYPES

@export var value:int

func is_true_on_round(round_num:int) -> bool:
	
	match condition_type:
		CONDITION_TYPES.DIVISIBLE_BY_MATCH:
			return floor(float(value)/round_num) == float(value)/round_num
		CONDITION_TYPES.PAST_ROUND:
			return round_num > value
		CONDITION_TYPES.BEFORE_ROUND:
			return round_num < value
	return false
