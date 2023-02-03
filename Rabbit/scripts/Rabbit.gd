class_name Rabbit
extends KinematicBody2D

var min_walk_speed := 50.0
var max_walk_speed := 500.0
var max_run_speed := 800.0
var max_stamina := 100.0
var life := 2

var turnspeed = 0.1
var velocity
var angle_velocity := 10.0
var direction := PI/4 #degrees
var velocity_change := 1000.0
onready var fsm := $StateMachine
onready var label := $Label
export onready var rabbitAnimation := $Animation


func _process(_delta: float) -> void:
	label.text = fsm.state.name
