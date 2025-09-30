class_name WeaponNode extends Node2D;

var damage;
var swing_speed;
var knockback;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func attack():
	pass
	
func can_attack() -> bool:
	return true;
