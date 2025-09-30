extends Node

@onready var health_bar: ProgressBar = $Health
@onready var hp: Label = $Health/HP

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	hp.text = "HP: " + str(GlobalPlayerData.player_health) + "/" + str(GlobalPlayerData.player_health_max);
	health_bar.value = GlobalPlayerData.player_health;
	health_bar.max_value = GlobalPlayerData.player_health_max
