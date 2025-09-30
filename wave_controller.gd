extends Node2D
@onready var spawn_timer: Timer = $SpawnTimer
@onready var wave_timeout: Timer = $WaveTimeout
@onready var control: CanvasLayer = $Node2D/PickUpgrade

@onready var current_wave: Label = $CanvasLayer/CurrentWave
@onready var enemies: Label = $CanvasLayer/Enemies
@onready var animation_player: AnimationPlayer = $CanvasLayer/AnimationPlayer

var zomboPrefab = preload("res://prefabs/enemies/Zombo.tscn");


func _ready() -> void:
	WaveData.trigger.connect(_on_trigger);
	wave_timeout.start();
	wave_create()

func _process(delta: float) -> void:
	if(WaveData.can_start_next):
		WaveData.current_wave+=1;
		WaveData.to_spawn = WaveData.current_wave * 10;
		WaveData.wave_size = WaveData.to_spawn;
		WaveData.wave_deaths = 0;
		WaveData.can_start_next = false;
	
	if(WaveData.to_spawn > 0 && spawn_timer.is_stopped()):
		var random = randf_range(0,360);
		var ang = deg_to_rad(random);
		
		var x = GlobalPlayerData.player.global_position.x + sin(ang) * 100;
		var y = GlobalPlayerData.player.global_position.y + cos(ang) * 100;
		
		if(x < 16):
			x = 24;
		if(y < 16):
			y = 24;
		if(x > 1144):
			x = 1144 - 32;
		if(y > 640):
			y = 640 - 32;
		
		var zombo = zomboPrefab.instantiate();
		zombo.global_position = Vector2(x,y);
		get_parent().add_child(zombo);
		WaveData.to_spawn -=1;
		spawn_timer.start();
		
		
	if(WaveData.to_spawn == 0 && WaveData.wave_deaths == WaveData.wave_size && wave_timeout.is_stopped()):
		get_tree().paused = true;
		control.visible = true;
		
		
	
	current_wave.text = "Current Wave: " + str(WaveData.current_wave);
	enemies.text = "Enemies Remaining: " + str(WaveData.wave_size - WaveData.wave_deaths);


func wave_create():
	animation_player.play("wave")


func _on_spawn_timer_timeout() -> void:
	spawn_timer.stop();
	pass # Replace with function body.


func _on_wave_timeout_timeout() -> void:
	WaveData.can_start_next = true;
	wave_timeout.stop();
	pass # Replace with function body.

func _on_trigger():
	wave_timeout.start()
	wave_create();
