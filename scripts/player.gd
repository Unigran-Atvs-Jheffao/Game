extends CharacterBody2D


var speed = GlobalPlayerData.speed;
@onready var character_body_2d: CharacterBody2D = $"."

@onready var player: Sprite2D = $Player
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D


@onready var camera_2d: Camera2D = $Camera2D
@onready var weapon_root: Node2D = $WeaponRoot
@onready var weapon_parent: Node2D = $WeaponRoot/WeaponParent

@onready var hit_sound: AudioStreamPlayer2D = $Sounds/HitSound

@onready var stunTimer: Timer = $StunTimer
@onready var invulnerability_timer: Timer = $InvulnerabilityTimer

@onready var morte: Control = $"../CanvasLayer/Morte"

@onready var player_material = $Player.material

var weapons = [
	preload("res://prefabs/weapons/Sword.tscn").instantiate(),
	preload("res://prefabs/weapons/Axe.tscn").instantiate(),
	preload("res://prefabs/weapons/Spear.tscn").instantiate(),
]
const BLINK_EFFECT = preload("res://effects/BlinkEffect.tres")
const HIT_EFFECT = preload("res://effects/HitEffect.tres")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalPlayerData.current_weapon = weapons.pick_random();
	weapon_parent.add_child(GlobalPlayerData.current_weapon);
	
	GlobalPlayerData.player = character_body_2d;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(stunTimer.is_stopped()):
		if(player_material == HIT_EFFECT):
			player_material.set_shader_parameter("hit", 0)
		
		if(Input.is_key_pressed(KEY_W)):
			self.velocity.y = -speed
		elif(Input.is_key_pressed(KEY_S)):
			self.velocity.y = +speed
		else:
			self.velocity.y = 0;
		
		if(Input.is_key_pressed(KEY_A)):
			self.velocity.x = -speed
		elif(Input.is_key_pressed(KEY_D)):
			self.velocity.x = +speed
		else:
			self.velocity.x = 0;

		if(Input.is_action_just_pressed("ui_down")):
			GlobalPlayerData.damage(1)
		if(Input.is_action_just_pressed("ui_up")):
			GlobalPlayerData.heal(1)

		if(self.velocity.x != 0 or self.velocity.y != 0):
			player.rotation = sin(Time.get_ticks_usec()/50000.0)/6;
			gpu_particles_2d.emitting = true;
		else:
			gpu_particles_2d.emitting = false;
			player.rotation = 0;
			
		if(GlobalPlayerData.player_health == 0):
			morte.visible = true;
			
		var mouse = get_global_mouse_position()
		
		
		if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
			GlobalPlayerData.current_weapon.attack()
		
		weapon_root.rotation = weapon_root.global_position.angle_to_point(mouse);
	else:
		player.rotation = 0;

	move_and_slide();

func _on_hurt_box_area_entered(area: Area2D) -> void:
	var enemy = area.get_parent();
	if(stunTimer.is_stopped() && enemy is Enemy && invulnerability_timer.is_stopped()):
		if(enemy.is_dead()):
			return;
		var dir = (global_position - area.global_position).normalized();
		velocity = dir * 100;
		move_and_slide();
		if(player_material == HIT_EFFECT):
			player_material.set_shader_parameter("hit", true)
		
		stunTimer.start()
		GlobalPlayerData.damage(enemy.dmg)
		hit_sound.pitch_scale = randf_range(0.5,1.5);
		hit_sound.play()

func _on_timer_timeout() -> void:
	stunTimer.stop(); # Replace with function body.
	invulnerability_timer.start();
	player.material = BLINK_EFFECT;
	


func _on_invulnerability_timer_timeout() -> void:
	invulnerability_timer.stop();
	player.material = HIT_EFFECT;
