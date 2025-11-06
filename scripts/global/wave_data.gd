extends Node

@export
var current_wave = 21;

@export
var can_start_next: bool = false;
@export
var wave_size = 0;

@export
var to_spawn = 0;

@export
var wave_deaths = 0;

func init():
	current_wave = 0;
	can_start_next = false;
	wave_size = 0;
	to_spawn = 0;
	wave_deaths = 0;


signal trigger;
