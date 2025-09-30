extends WeaponNode

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	damage = 3;
	swing_speed = 1;
	knockback = 1.2;
	

func attack():
	animation_player.play("sword_swing",-1, swing_speed)

func can_attack() -> bool:
	return animation_player.is_playing()

func _on_area_2d_area_entered(area: Area2D) -> void:
	var enemy = area.get_parent();
	if(enemy is Enemy):
		enemy.damage(damage);
		enemy.knockback(knockback);
