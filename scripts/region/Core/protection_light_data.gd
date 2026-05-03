extends RefCounted
class_name ProtectionLightData

const SOURCE_TYPE_BUILDING: String = "building"
const SOURCE_TYPE_BELONGING: String = "belonging"

const SOURCE_CAMPFIRE: String = "campfire"
const SOURCE_BONFIRE: String = "bonfire"
const SOURCE_TORCH: String = "torch"

const KEY_SOURCE_ID: String = "source_id"
const KEY_SOURCE_TYPE: String = "source_type"
const KEY_DISPLAY_NAME: String = "display_name"
const KEY_BUILDING_ID: String = "building_id"
const KEY_ITEM_ID: String = "item_id"
const KEY_RADIUS_SCALE: String = "radius_scale"
const KEY_FUEL_RESOURCE: String = "fuel_resource"
const KEY_FUEL_AMOUNT: String = "fuel_amount"
const KEY_FUEL_INTERVAL: String = "fuel_interval"
const KEY_AUTO_FUEL: String = "auto_fuel"
const KEY_REQUIRES_FUEL: String = "requires_fuel"
const KEY_USES_BELONGING_SLOT: String = "uses_belonging_slot"

const RESOURCE_WOOD: String = "Wood"

const CAMPFIRE_RADIUS_SCALE: float = 1.0
const BONFIRE_RADIUS_SCALE: float = 2.5
const TORCH_RADIUS_SCALE: float = 0.25

const CAMPFIRE_FUEL_AMOUNT: int = 2
const CAMPFIRE_FUEL_INTERVAL: float = 300.0

const BONFIRE_FUEL_AMOUNT: int = 4
const BONFIRE_FUEL_INTERVAL: float = 480.0


static func get_source_definition(source_id: String) -> Dictionary:
    match source_id:
        SOURCE_CAMPFIRE:
            return {
                KEY_SOURCE_ID: SOURCE_CAMPFIRE,
                KEY_SOURCE_TYPE: SOURCE_TYPE_BUILDING,
                KEY_DISPLAY_NAME: "Campfire",
                KEY_BUILDING_ID: RegionBuildingData.BUILDING_CAMPFIRE,
                KEY_RADIUS_SCALE: CAMPFIRE_RADIUS_SCALE,
                KEY_FUEL_RESOURCE: RESOURCE_WOOD,
                KEY_FUEL_AMOUNT: CAMPFIRE_FUEL_AMOUNT,
                KEY_FUEL_INTERVAL: CAMPFIRE_FUEL_INTERVAL,
                KEY_AUTO_FUEL: true,
                KEY_REQUIRES_FUEL: true,
                KEY_USES_BELONGING_SLOT: false
            }

        SOURCE_BONFIRE:
            return {
                KEY_SOURCE_ID: SOURCE_BONFIRE,
                KEY_SOURCE_TYPE: SOURCE_TYPE_BUILDING,
                KEY_DISPLAY_NAME: "Bonfire",
                KEY_BUILDING_ID: RegionBuildingData.BUILDING_BONFIRE,
                KEY_RADIUS_SCALE: BONFIRE_RADIUS_SCALE,
                KEY_FUEL_RESOURCE: RESOURCE_WOOD,
                KEY_FUEL_AMOUNT: BONFIRE_FUEL_AMOUNT,
                KEY_FUEL_INTERVAL: BONFIRE_FUEL_INTERVAL,
                KEY_AUTO_FUEL: true,
                KEY_REQUIRES_FUEL: true,
                KEY_USES_BELONGING_SLOT: false
            }

        SOURCE_TORCH:
            return {
                KEY_SOURCE_ID: SOURCE_TORCH,
                KEY_SOURCE_TYPE: SOURCE_TYPE_BELONGING,
                KEY_DISPLAY_NAME: "Torch",
                KEY_BUILDING_ID: "",
                KEY_ITEM_ID: SOURCE_TORCH,
                KEY_RADIUS_SCALE: TORCH_RADIUS_SCALE,
                KEY_FUEL_RESOURCE: "",
                KEY_FUEL_AMOUNT: 0,
                KEY_FUEL_INTERVAL: 0.0,
                KEY_AUTO_FUEL: false,
                KEY_REQUIRES_FUEL: false,
                KEY_USES_BELONGING_SLOT: true
            }

        _:
            return {}


static func get_building_source_id(building_id: String) -> String:
    if building_id == RegionBuildingData.BUILDING_CAMPFIRE:
        return SOURCE_CAMPFIRE

    if building_id == RegionBuildingData.BUILDING_BONFIRE:
        return SOURCE_BONFIRE

    return ""


static func get_building_source_definition(building_id: String) -> Dictionary:
    var source_id: String = get_building_source_id(building_id)

    if source_id == "":
        return {}

    return get_source_definition(source_id)


static func is_protection_light_building(building_id: String) -> bool:
    return get_building_source_id(building_id) != ""


static func is_belonging_source(item_id: String) -> bool:
    return item_id == SOURCE_TORCH


static func get_radius_scale_for_building(building_id: String) -> float:
    var source_data: Dictionary = get_building_source_definition(building_id)

    if source_data.is_empty():
        return 0.0

    return float(source_data.get(KEY_RADIUS_SCALE, 0.0))


static func get_fuel_interval_for_building(building_id: String) -> float:
    var source_data: Dictionary = get_building_source_definition(building_id)

    if source_data.is_empty():
        return 0.0

    return float(source_data.get(KEY_FUEL_INTERVAL, 0.0))


static func get_fuel_cost_for_building(building_id: String) -> Dictionary:
    var source_data: Dictionary = get_building_source_definition(building_id)

    if source_data.is_empty():
        return {}

    if not bool(source_data.get(KEY_REQUIRES_FUEL, false)):
        return {}

    var fuel_resource: String = str(source_data.get(KEY_FUEL_RESOURCE, ""))
    var fuel_amount: int = int(source_data.get(KEY_FUEL_AMOUNT, 0))

    if fuel_resource == "":
        return {}

    if fuel_amount <= 0:
        return {}

    return {
        fuel_resource: fuel_amount
    }


static func get_display_name_for_building(building_id: String) -> String:
    var source_data: Dictionary = get_building_source_definition(building_id)

    if source_data.is_empty():
        return building_id.capitalize()

    return str(source_data.get(KEY_DISPLAY_NAME, building_id.capitalize()))


static func should_auto_fuel_building(building_id: String) -> bool:
    var source_data: Dictionary = get_building_source_definition(building_id)

    if source_data.is_empty():
        return false

    return bool(source_data.get(KEY_AUTO_FUEL, false))


static func building_requires_fuel(building_id: String) -> bool:
    var source_data: Dictionary = get_building_source_definition(building_id)

    if source_data.is_empty():
        return false

    return bool(source_data.get(KEY_REQUIRES_FUEL, false))
