extends WeaponNode

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	damage = 6;
	swing_speed = 0.5;
	knockback = 5;
	

func attack():
	animation_player.play("axe_swing",-1, swing_speed)

func can_attack() -> bool:
	return animation_player.is_playing()

func _on_area_2d_area_entered(area: Area2D) -> void:
	var enemy = area.get_parent();
	if(enemy is Enemy):
		enemy.damage(damage);
		enemy.knockback(knockback);
