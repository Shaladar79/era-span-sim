extends RefCounted
class_name RegionAgeData

const AGE_STONE: String = "stone_age"

const CATEGORY_CORE: String = "core"
const CATEGORY_HOUSING: String = "housing"
const CATEGORY_WORK: String = "work"
const CATEGORY_FOOD: String = "food"
const CATEGORY_DEFENSE: String = "defense"
const CATEGORY_SPIRITUAL: String = "spiritual"

# Legacy aliases kept so older files do not break while we clean categories.
const CATEGORY_CRAFTING: String = CATEGORY_WORK
const CATEGORY_SPECIAL: String = CATEGORY_FOOD


static func get_available_build_ages() -> Array:
    return [
        {
            "id": AGE_STONE,
            "name": "Stone Age"
        }
    ]


static func get_build_categories_for_age(age_id: String) -> Array:
    if age_id == AGE_STONE:
        return [
            {
                "id": CATEGORY_CORE,
                "name": "Core"
            },
            {
                "id": CATEGORY_HOUSING,
                "name": "Housing"
            },
            {
                "id": CATEGORY_WORK,
                "name": "Work"
            },
            {
                "id": CATEGORY_FOOD,
                "name": "Food"
            },
            {
                "id": CATEGORY_DEFENSE,
                "name": "Defense"
            },
            {
                "id": CATEGORY_SPIRITUAL,
                "name": "Spiritual"
            }
        ]

    return []


static func get_default_build_age() -> String:
    return AGE_STONE


static func get_default_build_category_for_age(age_id: String) -> String:
    if age_id == AGE_STONE:
        return CATEGORY_CORE

    return CATEGORY_CORE


static func get_build_age_name(age_id: String) -> String:
    match age_id:
        AGE_STONE:
            return "Stone Age"
        _:
            return age_id.capitalize()


static func get_build_category_name(category_id: String) -> String:
    match category_id:
        CATEGORY_CORE:
            return "Core"
        CATEGORY_HOUSING:
            return "Housing"
        CATEGORY_WORK:
            return "Work"
        CATEGORY_FOOD:
            return "Food"
        CATEGORY_DEFENSE:
            return "Defense"
        CATEGORY_SPIRITUAL:
            return "Spiritual"
        _:
            return category_id.capitalize()
