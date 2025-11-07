extends RigidBody2D;
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if(GlobalPlayerData.player.global_position.distance_to(global_position) < 40):
		self.linear_velocity = (global_position.direction_to(GlobalPlayerData.player.global_position)) * delta * 2500;
	else:
		self.linear_velocity = Vector2(0,0);

func _on_area_2d_area_entered(area: Area2D) -> void:
		GlobalPlayerData.heal(randi_range((GlobalPlayerData.player_health_max/10.0) * 3, (GlobalPlayerData.player_health_max/10.0) * 5));
		audio_stream_player_2d.pitch_scale = randf_range(0.9,1.1);
		audio_stream_player_2d.play(0);



func _on_audio_stream_player_2d_finished() -> void:
	queue_free();
