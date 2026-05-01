extends RefCounted
class_name RegionBuildingData

const AGE_STONE: String = RegionAgeData.AGE_STONE

const BUILDING_CAMPFIRE: String = StoneAgeBuildingData.BUILDING_CAMPFIRE
const BUILDING_SHELTER: String = StoneAgeBuildingData.BUILDING_SHELTER
const BUILDING_CHIEFTAINS_SHELTER: String = StoneAgeBuildingData.BUILDING_CHIEFTAINS_SHELTER
const BUILDING_MAKING_SPOT: String = StoneAgeBuildingData.BUILDING_MAKING_SPOT
const BUILDING_STONEWORKING_BENCH: String = StoneAgeBuildingData.BUILDING_STONEWORKING_BENCH
const BUILDING_WOODWORKING_BENCH: String = StoneAgeBuildingData.BUILDING_WOODWORKING_BENCH
const BUILDING_STORAGE_AREA: String = StoneAgeBuildingData.BUILDING_STORAGE_AREA
const BUILDING_THINKERS_SPOT: String = StoneAgeBuildingData.BUILDING_THINKERS_SPOT

const BUILDING_HUNTERS_HUT: String = StoneAgeBuildingData.BUILDING_HUNTERS_HUT
const BUILDING_WARLEADER_SHELTER: String = StoneAgeBuildingData.BUILDING_WARLEADER_SHELTER
const BUILDING_WARRIOR_HUT: String = StoneAgeBuildingData.BUILDING_WARRIOR_HUT

const BUILDING_TENT: String = StoneAgeBuildingData.BUILDING_TENT
const BUILDING_CHIEFTAINS_TENT: String = StoneAgeBuildingData.BUILDING_CHIEFTAINS_TENT
const BUILDING_BONFIRE: String = StoneAgeBuildingData.BUILDING_BONFIRE
const BUILDING_SPIRITUAL_LEADER_TENT: String = StoneAgeBuildingData.BUILDING_SPIRITUAL_LEADER_TENT
const BUILDING_RITUAL_SITE: String = StoneAgeBuildingData.BUILDING_RITUAL_SITE

const CAMPFIRE_BUILD_RADIUS: int = StoneAgeBuildingData.CAMPFIRE_BUILD_RADIUS
const BONFIRE_BUILD_RADIUS: int = StoneAgeBuildingData.BONFIRE_BUILD_RADIUS

const STORAGE_BASE_RESOURCE_CAP: int = StoneAgeBuildingData.STORAGE_BASE_RESOURCE_CAP
const STORAGE_AREA_CAPACITY: int = StoneAgeBuildingData.STORAGE_AREA_CAPACITY

const SHELTER_CAPACITY: int = StoneAgeBuildingData.SHELTER_CAPACITY
const TENT_CAPACITY: int = StoneAgeBuildingData.TENT_CAPACITY

const CHIEFTAINS_SHELTER_REQUIRED_SHELTERS: int = StoneAgeBuildingData.CHIEFTAINS_SHELTER_REQUIRED_SHELTERS
const CHIEFTAINS_SHELTER_CAPACITY: int = StoneAgeBuildingData.CHIEFTAINS_SHELTER_CAPACITY
const CHIEFTAINS_TENT_CAPACITY: int = StoneAgeBuildingData.CHIEFTAINS_TENT_CAPACITY
const SPIRITUAL_LEADER_TENT_CAPACITY: int = StoneAgeBuildingData.SPIRITUAL_LEADER_TENT_CAPACITY

const THINKERS_SPOT_RESEARCH_PER_MINUTE: int = StoneAgeBuildingData.THINKERS_SPOT_RESEARCH_PER_MINUTE

const SPECIALIST_HUT_CAPACITY: int = StoneAgeBuildingData.SPECIALIST_HUT_CAPACITY
const WARLEADER_SHELTER_CAPACITY: int = StoneAgeBuildingData.WARLEADER_SHELTER_CAPACITY

static var runtime_unlocked_buildings: Dictionary = {}


static func reset_runtime_unlocks() -> void:
    runtime_unlocked_buildings = {
        BUILDING_CAMPFIRE: true
    }


static func unlock_building(building_id: String) -> void:
    if runtime_unlocked_buildings.is_empty():
        reset_runtime_unlocks()

    if building_id == "":
        return

    runtime_unlocked_buildings[building_id] = true


static func unlock_buildings(building_ids: Array) -> void:
    for building_index in range(building_ids.size()):
        unlock_building(str(building_ids[building_index]))


static func is_building_unlocked(building_id: String) -> bool:
    if runtime_unlocked_buildings.is_empty():
        reset_runtime_unlocks()

    return bool(runtime_unlocked_buildings.get(building_id, false))


static func get_building(building_id: String) -> Dictionary:
    var buildings: Dictionary = get_all_buildings()

    if not buildings.has(building_id):
        return {}

    var building_data: Dictionary = buildings[building_id].duplicate(true)
    building_data["unlocked"] = is_building_unlocked(building_id)

    return building_data


static func get_all_buildings() -> Dictionary:
    var buildings: Dictionary = {}

    buildings.merge(
        StoneAgeBuildingData.get_all_buildings(),
        true
    )

    return buildings


static func get_unlocked_buildings() -> Array:
    var unlocked_buildings: Array = []
    var buildings: Dictionary = get_all_buildings()
    var building_ids: Array = buildings.keys()

    building_ids.sort()

    for building_index in range(building_ids.size()):
        var building_id: String = str(building_ids[building_index])

        if not is_building_unlocked(building_id):
            continue

        var building_data: Dictionary = get_building(building_id)

        if building_data.is_empty():
            continue

        unlocked_buildings.append(building_data)

    return unlocked_buildings


static func get_unlocked_buildings_for_age_and_category(
    age_id: String,
    category_id: String
) -> Array:
    var filtered_buildings: Array = []
    var unlocked_buildings: Array = get_unlocked_buildings()

    for building_index in range(unlocked_buildings.size()):
        var building_data: Dictionary = unlocked_buildings[building_index]
        var building_age: String = str(building_data.get("age", ""))
        var building_category: String = str(building_data.get("category", ""))

        if building_age != age_id:
            continue

        if building_category != category_id:
            continue

        filtered_buildings.append(building_data)

    return filtered_buildings


static func get_available_build_ages() -> Array:
    return RegionAgeData.get_available_build_ages()


static func get_build_categories_for_age(age_id: String) -> Array:
    return RegionAgeData.get_build_categories_for_age(age_id)


static func get_default_build_age() -> String:
    return RegionAgeData.get_default_build_age()


static func get_default_build_category_for_age(age_id: String) -> String:
    return RegionAgeData.get_default_build_category_for_age(age_id)


static func get_build_age_name(age_id: String) -> String:
    return RegionAgeData.get_build_age_name(age_id)


static func get_build_category_name(category_id: String) -> String:
    return RegionAgeData.get_build_category_name(category_id)


static func get_storage_resource_options() -> Array:
    return [
        "Wood",
        "Stone",
        "Fiber",
        "Flint",
        "Berries",
        "Mushrooms",
        "Reeds",
        "Clay",
        "Fish"
    ]
