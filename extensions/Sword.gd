extends "res://content/weapons/sword/Sword.gd"

var current_scale : float = 3.0
var scale_up_time = 3.0
var cooldown_until_scale_up = 3.0
var wait_listen_count = 0

@onready var base_damage_stab = Data.of("sword.stabDamage")
@onready var base_damage_slice = Data.of("sword.sliceDamage")

# Called when the node enters the scene tree for the first time.
func _ready():
	Data.listen(self, "sword.stabDamage")
	Data.listen(self, "sword.sliceDamage")
	change_scale()

func propertyChanged(property : String, old_value, new_value):
	if property == "sword.stabDamage":
		base_damage_stab = new_value
	elif property == "sword.sliceDamage":
		base_damage_slice = new_value
	apply_damage_changes()
		
func _physics_process(delta):
	if hitMonsters.size() > 0 and current_scale > 0.4:
		current_scale = max(current_scale - 0.1,0.4)
		change_scale()
		apply_damage_changes()
	if current_scale < 3.0 and ! GameWorld.paused:
		cooldown_until_scale_up -= delta
		if cooldown_until_scale_up < 0 :
			current_scale += 0.2
			cooldown_until_scale_up = scale_up_time
			change_scale()
			apply_damage_changes()
	super(delta)

func change_scale():
	$Blade.scale = current_scale * Vector2(1,1)
	$Blade/HitArea/BladeCollisionShape.shape.size.y = abs($Blade/HitArea/ArrowHead.position.y) + 13
	$Blade/HitArea/BladeCollisionShape.position.y = int($Blade/HitArea/ArrowHead.position.y/2)

func apply_damage_changes():
	Data.values["sword.stabDamage"] = base_damage_stab * current_scale
	Data.values["sword.sliceDamage"] = base_damage_slice * current_scale
