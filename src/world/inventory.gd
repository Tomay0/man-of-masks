extends Node2D
class_name Inventory

var inventory := {}

func collect_item(item_id: StringName):
	if not inventory.has(item_id):
		inventory[item_id] = 0
	inventory[item_id] += 1

func has_collected_item(item_id: StringName):
	return inventory.has(item_id)

func use_item(item_id: StringName):
	if not inventory.has(item_id):
		return false
		
	inventory[item_id] -= 1
	if inventory[item_id] == 0:
		inventory.erase(item_id)
		
	return true
