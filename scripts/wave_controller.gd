extends Node2D
@onready var spawn_timer: Timer = $SpawnTimer
@onready var wave_timeout: Timer = $WaveTimeout
@onready var control: CanvasLayer = $Node2D/PickUpgrade
@onready var tile_map_layer: TileMapLayer = $"../TileMapLayer"

@onready var current_wave: Label = $CanvasLayer/CurrentWave
@onready var enemies: Label = $CanvasLayer/Enemies
@onready var coin_count: Label = $CanvasLayer/CoinCount
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
		
		x = clamp(x, 64, 1144 - 64);
		y = clamp(y, 64, 640 - 64);
		var zombo = zomboPrefab.instantiate();
		zombo.global_position = Vector2(x,y);
		get_parent().add_child(zombo);
		WaveData.to_spawn -=1;
		spawn_timer.start();
		
		
	if(WaveData.to_spawn == 0 && WaveData.wave_deaths == WaveData.wave_size && wave_timeout.is_stopped()):
		get_tree().paused = true;
		control.visible = true;
	
	
	if(WaveData.current_wave == 5):
		spawn_timer.wait_time = 0.4;
		tile_map_layer.material.set_shader_parameter("color", Color(0.977, 0.669, 0.248, 1.0));
		
	if(WaveData.current_wave == 10):
		spawn_timer.wait_time = 0.3; 
		tile_map_layer.material.set_shader_parameter("color", Color(1.0, 1.0, 1.0, 1.0));
		
	if(WaveData.current_wave == 15):
		spawn_timer.wait_time = 0.2; 
		tile_map_layer.material.set_shader_parameter("color", Color(0.075, 0.407, 1.0, 1.0));
		
	if(WaveData.current_wave == 20):
		spawn_timer.wait_time = 0.1; 
		tile_map_layer.material.set_shader_parameter("color", Color(0.837, 0.0, 0.47, 1.0));
		
	if(WaveData.current_wave == 25):
		spawn_timer.wait_time = 0.05;
		tile_map_layer.material.set_shader_parameter("color", Color(0,0,0,0));
	
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
	wave_timeout.start();
	wave_create();
