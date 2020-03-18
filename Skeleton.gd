extends Skeleton2D

onready var Branch = preload("res://Branch.tscn")

const PLANT_A = {
	'rules': {
		'F': 'F[+F]F[-F][F]'
	},
	'axiom': 'F',
	'+': 20,
	'-': -20,
	'dist': 0.40,
	'scale': 0.5,
	'heading': 270
}

const PLANT_B = {
	'rules': {
		'F': 'FF-[-F+F+F]+[F-F-F]'
	},
	'axiom': 'F',
	'+': 25,
	'-': -25,
	'dist': 0.25,
	'scale': 0.5,
	'heading': 270
}

const PLANT_C = {
	'rules': {
		'F': 'FF',
		'X': 'F+[[X]-X]-F[-FX]+X'
	},
	'axiom': 'X',
	'+': 25,
	'-': -25,
	'dist': 0.35,
	'scale': 0.5,
	'heading': 270
}

const PLANT_D = {
	'rules': {
		'F': 'F',
		'X': 'F[+X][-X]FX',
		'Y': 'F[+F]F[-F]F'
	},
	'axiom': 'YYX',
	'+': 15,
	'-': -15,
	'dist': 0.40,
	'scale': 0.5,
	'heading': 270
}

const PLANT_E = {
	'rules': {
		'F': 'F[+F]F[-F]F',
		'X': 'F+[[X]-X]-F[-FX]+X',
		'Y': 'F[+F]F[-F]F'
	},
	'axiom': 'YX',
	'+': 25,
	'-': -25,
	'dist': 0.35,
	'scale': 0.5,
	'heading': 270
}

const PLANT_F = {
	'rules': {
		'F': 'G[M|X][|M|X]G[+X+F][F][-X-F]',
		'G': 'GG',
		'M': 'MM',
		'X': '[Y]',
		'Y': 'F[+F]F[-F]F'
	},
	'axiom': '[F]-X-[F]-X-[F]-X',
	'+': 25,
	'-': -25,
	'dist': 0.25,
	'scale': 0.5,
	'heading': 270
}

func grow_tree(plant, instructions, depth):
	var angle = 0
	var stack = []
	var start = Vector2()
	var current_node = Branch.instance()
	current_node.create_branch(start, start, angle)
	current_node.default_length = 0
	current_node.rotate(deg2rad(angle))
	add_child(current_node)
	for i in range(len(instructions)):
		var ins = instructions[i]
		var s = pow(plant.scale, (
			(len(instructions) / len(plant.rules["F"])) *
			((i / len(plant.rules["F"])) / len(instructions))
		))
		if ins == "F" or ins == "G":
			var end = Vector2(
				start.x + (s * plant.dist * ((10000 / to_global(current_node.position).distance_to(position)) * depth)), 0# + rand_range(-20, 20), 0
#				start.y + (plant.dist * 150 * sin(deg2rad(angle))) + rand_range(-20, 20)
			)
			var branch = Branch.instance()
			branch.rotate(deg2rad(angle + rand_range(-5, 5)))
			branch.default_length = start.distance_to(end)
			branch.position.x = end.x
			branch.create_branch(start, end, angle)
			current_node.add_child(branch)
			current_node = branch
			angle = 0
		elif ins == '[':
			stack.push_back(current_node)
		elif ins == ']':
			current_node = stack.pop_back()
		elif ins == '|':
			angle += 15
		elif ins == '+' or ins == '-':
			angle += plant[ins]

func generate_instructions(ins, obj):
	var next = ""
	for i in ins:
		var current = i
		if current in obj.rules:
			next += obj.rules[current]
		else:
			next += current
	return next

func _ready():
	randomize()
	var depth = 3
	var plant = [PLANT_A, PLANT_C, PLANT_D, PLANT_E, PLANT_F][randi() % 5]
	var instructions = plant.axiom
	for i in range(depth):
		instructions = generate_instructions(instructions, plant)
	print(instructions)
	rotate(deg2rad(plant.heading))
	grow_tree(plant, instructions, depth)
#	grow_tree(PLANT_B)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
