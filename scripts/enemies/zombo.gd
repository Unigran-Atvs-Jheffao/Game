extends Enemy
@onready var timer: Timer = $Timer

@onready var zombo: Sprite2D = $Zombo
@onready var zombo_material = $Zombo.material

@onready var death_particles: CPUParticles2D = $DeathParticles
@onready var hit_particles: CPUParticles2D = $HitParticles


@onready var hit_sound: AudioStreamPlayer2D = $Sounds/HitSound
@onready var death_sound: AudioStreamPlayer2D = $Sounds/DeathSound

var unique;

var death: bool = false;

func _ready() -> void:
	unique = randf_range(0,1000);
	dmg = 2
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(timer.is_stopped()):
		hit_particles.emitting = false
		zombo_material.set_shader_parameter("hit", 0)
		velocity = Vector2(0,0)
		self.rotation = 0;
		

	
	if(hp == 0 && !death):
		zombo.visible = false;
		death_particles.emitting = true;
		death_sound.pitch_scale = randf_range(0.95,1.05);
		death_sound.play();
		death = true;
	
	if(timer.is_stopped()):
		var dir = (GlobalPlayerData.player.global_position - global_position).normalized();
		velocity = dir * 30;
		self.rotation = sin(Time.get_ticks_usec()/50000.0 + unique)/6;
	
	move_and_slide();

func damage(val):
	if(timer.is_stopped()):
		zombo_material.set_shader_parameter("hit", 1)
		timer.start()
		hit_particles.emitting = true;
		hit_sound.pitch_scale = randf_range(0.5,1.5);
		hit_sound.play();
		hp = max(hp - val,0);

func knockback(val):
		var dir = (global_position - GlobalPlayerData.player.global_position).normalized();
		velocity = (dir * 50 * val);

func _on_timer_timeout() -> void:
	timer.stop();

func is_dead():
	return death;

func _on_death_particles_finished() -> void:
	if(death):
		WaveData.wave_deaths += 1;
		queue_free();
