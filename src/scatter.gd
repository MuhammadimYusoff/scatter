@tool
extends Node3D


signal updated


const ModifierStack := preload("./stack/modifier_stack.gd")

var modifier_stack: ModifierStack


func _ready() -> void:
	_ensure_stack_exists()
	print("Scatter ready done")


func _get_property_list() -> Array:
	var list := []

	list.push_back({
		name = "ProtonScatter",
		type = TYPE_NIL,
		usage = PROPERTY_USAGE_CATEGORY | PROPERTY_USAGE_SCRIPT_VARIABLE,
	})
	list.push_back({
		name = "modifier_stack",
		type = TYPE_OBJECT,
		hint_string = "ScatterModifierStack",
	})

	return list


func _ensure_stack_exists() -> void:
	if modifier_stack:
		if modifier_stack.owner != self:
			modifier_stack = modifier_stack.duplicate(true)
			modifier_stack.owner = self
		return

	modifier_stack = ModifierStack.new()
	modifier_stack.owner = self