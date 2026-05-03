extends RefCounted
class_name StoneAgeFoodData

const FOOD_MEAT: String = "Meat"
const FOOD_FISH: String = "Fish"
const FOOD_BERRIES: String = "Berries"
const FOOD_MUSHROOMS: String = "Mushrooms"


static func get_daily_food_priority() -> Array:
    return [
        FOOD_MEAT,
        FOOD_FISH,
        FOOD_BERRIES,
        FOOD_MUSHROOMS
    ]


static func get_food_restore_amount(_food_resource_name: String) -> int:
    return CoreTuning.FOOD_RESTORE_AMOUNT
