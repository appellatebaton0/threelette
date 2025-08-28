extends Resource
class_name ConditionalEnemyOption

@export var scene:PackedScene

enum CONDITION_TYPES{DIVISIBLE_BY_MATCH, PAST_ROUND, BEFORE_ROUND}
@export var condition_type:CONDITION_TYPES

@export var value:int

func is_true_on_round(round:int) -> bool:
	
	match condition_type:
		CONDITION_TYPES.DIVISIBLE_BY_MATCH:
			return floor(float(value)/round) == float(value)/round
		CONDITION_TYPES.PAST_ROUND
	return false
