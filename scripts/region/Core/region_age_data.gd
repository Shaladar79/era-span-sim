extends RefCounted
class_name RegionAgeData

const AGE_STONE: String = "stone_age"

const CATEGORY_CORE: String = "core"
const CATEGORY_SHELTER: String = "shelter"
const CATEGORY_STORAGE: String = "storage"
const CATEGORY_WORK: String = "work"
const CATEGORY_FOOD: String = "food"
const CATEGORY_DEFENSE: String = "defense"
const CATEGORY_HERO: String = "hero"
const CATEGORY_SPIRITUAL: String = "spiritual"
const CATEGORY_HOUSING: String = "housing"
const CATEGORY_CRAFTING: String = "crafting"
const CATEGORY_SPECIAL: String = "special"

static func get_available_build_ages() -> Array:
    return [
        {
            "id": AGE_STONE,
            "name": "Stone Age"
        }
    ]


static func get_build_age_name(age_id: String) -> String:
    var ages: Array = get_available_build_ages()

    for age_index in range(ages.size()):
        var age_data: Dictionary = ages[age_index]

        if str(age_data.get("id", "")) == age_id:
            return str(age_data.get("name", age_id))

    return age_id


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
                "id": CATEGORY_CRAFTING,
                "name": "Crafting"
            },
            {
                "id": CATEGORY_SPECIAL,
                "name": "Special"
            }
        ]

    return []


static func get_build_category_name(category_id: String) -> String:
    var categories: Array = get_build_categories_for_age(AGE_STONE)

    for category_index in range(categories.size()):
        var category_data: Dictionary = categories[category_index]

        if str(category_data.get("id", "")) == category_id:
            return str(category_data.get("name", category_id))

    return category_id


static func get_default_build_age() -> String:
    return AGE_STONE


static func get_default_build_category_for_age(age_id: String) -> String:
    var categories: Array = get_build_categories_for_age(age_id)

    if categories.is_empty():
        return ""

    var category_data: Dictionary = categories[0]

    return str(category_data.get("id", ""))
