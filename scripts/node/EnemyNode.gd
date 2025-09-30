class_name Enemy extends CharacterBody2D

@export 
var hp = 10;
@export 
var dmg = 1;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func is_dead() -> bool:
	return false;
	

func damage(damage):
	pass
	
func knockback(strengh):
	pass
