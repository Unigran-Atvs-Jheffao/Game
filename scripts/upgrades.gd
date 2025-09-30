extends Node2D

@onready var pick_upgrade: CanvasLayer = $PickUpgrade
@export 
var upgrades: Upgrades;

@onready var card: UpgradeCard = $PickUpgrade/Control/VBoxContainer/HBoxContainer/Card
@onready var card2: UpgradeCard = $PickUpgrade/Control/VBoxContainer/HBoxContainer/Card2
@onready var card3: UpgradeCard = $PickUpgrade/Control/VBoxContainer/HBoxContainer/Card3

var cards: Array[UpgradeCard] = [];

func _ready() -> void:
	WaveData.trigger.connect(_on_trigger_again);
	
	cards.append(card);
	cards.append(card2);
	cards.append(card3);
	
	for i in range(len(cards)):
		cards[i].upgrade = upgrades.upgrades.pick_random();

func _process(delta: float) -> void:
	pass

func _on_trigger_again():
	get_tree().paused = false;
	pick_upgrade.visible = false;


func _on_pick_upgrade_visibility_changed() -> void:
	if(pick_upgrade.visible):
		for i in range(len(cards)):
			cards[i].upgrade = upgrades.upgrades.pick_random();
