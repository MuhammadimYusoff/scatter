tool
extends "base_point_modifier.gd"


export var override_global_seed := false
export var custom_seed := 0
export var instance_count := 10


var _rng: RandomNumberGenerator


func _init() -> void:
	display_name = "Add Around Point (Random)"
	category = "Create"
	enabled = true
	warning_ignore_no_transforms = true


func _process_transforms(transforms, global_seed) -> void:
	._process_transforms(transforms, global_seed)

	_rng = RandomNumberGenerator.new()

	if override_global_seed:
		_rng.set_seed(custom_seed)
	else:
		_rng.set_seed(global_seed)

	var size := bounds_max - bounds_min
	var half_size := size * 0.5
	var center := bounds_min + half_size
	var height: float = bounds_max.y

	for i in instance_count:
		for j in 100:
			var pos = _random_vec3() * half_size + center
			if is_inside(pos):
				pos.y = height
				var t = Transform()
				t.origin = pos
				transforms.list.push_back(t)
				break


func _random_vec3() -> Vector3:
	var vec3 = Vector3.ZERO
	vec3.x = _rng.randf_range(-1.0, 1.0)
	vec3.y = _rng.randf_range(-1.0, 1.0)
	vec3.z = _rng.randf_range(-1.0, 1.0)
	return vec3
