extends Node2D

@onready var pick_upgrade: CanvasLayer = $PickUpgrade
@export 
var upgrades: Upgrades;

@onready var card: UpgradeCard = $PickUpgrade/Control/VBoxContainer/HBoxContainer/Card
@onready var card2: UpgradeCard = $PickUpgrade/Control/VBoxContainer/HBoxContainer/Card2
@onready var card3: UpgradeCard = $PickUpgrade/Control/VBoxContainer/HBoxContainer/Card3

@onready var cost: Label = $PickUpgrade/Control/Button/HBoxContainer/Cost
@onready var money: Label = $PickUpgrade/Control/HBoxContainer/Money

var cards: Array[UpgradeCard] = [];

func _ready() -> void:
	cards.append(card);
	cards.append(card2);
	cards.append(card3);
	roulette()

func _process(delta: float) -> void:
	money.text = str(GlobalPlayerData.coins);

func _on_trigger_again():
	get_tree().paused = false;
	pick_upgrade.visible = false;


func _on_pick_upgrade_visibility_changed() -> void:
	if(pick_upgrade.visible):
		for i in range(len(cards)):
			cards[i].upgrade = upgrades.upgrades.pick_random();


func roulette():
	WaveData.trigger.connect(_on_trigger_again);
	
	for i in range(len(cards)):
		cards[i].upgrade = upgrades.upgrades.pick_random();
	
	cost.text = str( GlobalPlayerData.rerolls * 25 );

func _on_button_pressed() -> void:
	if(GlobalPlayerData.coins > GlobalPlayerData.rerolls * 25 ):
		GlobalPlayerData.coins -= GlobalPlayerData.rerolls * 25;
		money.text = str(GlobalPlayerData.coins);
		GlobalPlayerData.rerolls += 1;
		roulette();
		
	
