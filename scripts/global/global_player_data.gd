extends Node

@export
var speed = 50;
@export
var player_health = 10;
@export
var player_health_max = 10;
@export
var current_weapon: WeaponNode;
@export
var coins = 0;
@export
var rerolls = 1;

func init():
	speed = 50;
	player_health = 10;
	player_health_max = 10;
	coins = 0;
	rerolls = 1;

@export
var player: CharacterBody2D;

func damage(val: int) -> void:
	player_health = clamp(player_health - val, 0, player_health_max)

func heal(val: int) -> void:
	player_health = clamp(player_health + val, 0, player_health_max)
