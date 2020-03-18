extends Node2D

func on_area_entered(area):
	print(area)

func _ready():
	get_node("Area2D").connect("area_entered", self, "on_area_entered")

#func _process(delta):
#	pass
