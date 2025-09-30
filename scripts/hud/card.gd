class_name UpgradeCard extends PanelContainer

@export
var upgrade: Dictionary;

var inside = false;
@onready var power_up_name: Button = $PowerUpName

func _process(delta: float) -> void:
	power_up_name.text = upgrade.get("name");
	power_up_name.tooltip_text = upgrade.get("description")


func _on_power_up_name_button_up() -> void:
	if(upgrade.has("damage")):
		GlobalPlayerData.current_weapon.damage += upgrade.get("damage");
	if(upgrade.has("knockback")):
		GlobalPlayerData.current_weapon.knockback += upgrade.get("knockback");
	if(upgrade.has("speed")):
		GlobalPlayerData.current_weapon.swing_speed += upgrade.get("speed");
	if(upgrade.has("health")):
		GlobalPlayerData.player_health_max += upgrade.get("health");
		GlobalPlayerData.player_health += upgrade.get("health");
	if(upgrade.has("scale")):
		GlobalPlayerData.current_weapon.scale += Vector2(upgrade.get("scale"),upgrade.get("scale"));
	if(upgrade.has("ms")):
		GlobalPlayerData.speed += upgrade.get("ms")

	WaveData.trigger.emit();
