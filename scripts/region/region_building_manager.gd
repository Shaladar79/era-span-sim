extends RefCounted
class_name RegionBuildingManager

const BUILD_MODE_NONE: String = "none"

const SAVE_KEY_CURRENT_BUILD_MODE: String = "current_build_mode"
const SAVE_KEY_CURRENT_BUILDING_ID: String = "current_building_id"
const SAVE_KEY_REGION_BUILDINGS: String = "region_buildings"
const SAVE_KEY_NEXT_BUILDING_INSTANCE_ID: String = "next_building_instance_id"
const SAVE_KEY_HAS_CHIEFTAIN: String = "has_chieftain"
const SAVE_KEY_CHIEFTAIN_DATA: String = "chieftain_data"
const SAVE_KEY_HAS_WARLEADER: String = "has_warleader"
const SAVE_KEY_WARLEADER_DATA: String = "warleader_data"
const SAVE_KEY_HAS_SPIRITUAL_LEADER: String = "has_spiritual_leader"
const SAVE_KEY_SPIRITUAL_LEADER_DATA: String = "spiritual_leader_data"
const SAVE_KEY_HERO_PLACEHOLDERS: String = "hero_placeholders"
const KEY_ACTIVE: String = "active"
const KEY_FUEL_TIMER: String = "fuel_timer"
const KEY_IS_LIT: String = "is_lit"
const KEY_LAST_FUEL_MESSAGE_STATE: String = "last_fuel_message_state"

const SAVE_TYPE_KEY: String = "__save_type"
const SAVE_TYPE_VECTOR2I: String = "Vector2i"
const SAVE_TYPE_COLOR: String = "Color"

var region_tiles: Array = []
var region_width: int = 0
var region_height: int = 0

var current_build_mode: String = BUILD_MODE_NONE
var current_building_id: String = ""

var region_buildings: Array = []
var next_building_instance_id: int = 1

var has_chieftain: bool = false
var chieftain_data: Dictionary = {}

var has_warleader: bool = false
var warleader_data: Dictionary = {}

var has_spiritual_leader: bool = false
var spiritual_leader_data: Dictionary = {}

var hero_placeholders: Dictionary = {}


func setup(
    new_region_tiles: Array,
    new_region_width: int,
    new_region_height: int
) -> void:
    region_tiles = new_region_tiles
    region_width = new_region_width
    region_height = new_region_height


func clear_buildings() -> void:
    region_buildings.clear()
    next_building_instance_id = 1
    has_chieftain = false
    chieftain_data = {}
    has_warleader = false
    warleader_data = {}
    has_spiritual_leader = false
    spiritual_leader_data = {}
    hero_placeholders = {}

    if region_tiles.is_empty():
        return

    for y in range(region_height):
        for x in range(region_width):
            var tile_data: Dictionary = region_tiles[y][x]
            tile_data["occupied"] = false
            tile_data.erase("building_id")
            tile_data.erase("building_instance_id")


func get_save_data() -> Dictionary:
    return {
        SAVE_KEY_CURRENT_BUILD_MODE: current_build_mode,
        SAVE_KEY_CURRENT_BUILDING_ID: current_building_id,
        SAVE_KEY_REGION_BUILDINGS: get_save_safe_value(region_buildings),
        SAVE_KEY_NEXT_BUILDING_INSTANCE_ID: next_building_instance_id,
        SAVE_KEY_HAS_CHIEFTAIN: has_chieftain,
        SAVE_KEY_CHIEFTAIN_DATA: get_save_safe_value(chieftain_data),
        SAVE_KEY_HAS_WARLEADER: has_warleader,
        SAVE_KEY_WARLEADER_DATA: get_save_safe_value(warleader_data),
        SAVE_KEY_HAS_SPIRITUAL_LEADER: has_spiritual_leader,
        SAVE_KEY_SPIRITUAL_LEADER_DATA: get_save_safe_value(spiritual_leader_data),
        SAVE_KEY_HERO_PLACEHOLDERS: get_save_safe_value(hero_placeholders)
    }


func load_save_data(save_data: Dictionary) -> void:
    clear_buildings()

    current_build_mode = BUILD_MODE_NONE
    current_building_id = ""

    if save_data.is_empty():
        return

    current_build_mode = str(save_data.get(SAVE_KEY_CURRENT_BUILD_MODE, BUILD_MODE_NONE))
    current_building_id = str(save_data.get(SAVE_KEY_CURRENT_BUILDING_ID, ""))

    if current_build_mode == "":
        current_build_mode = BUILD_MODE_NONE

    if current_build_mode == BUILD_MODE_NONE:
        current_building_id = ""

    next_building_instance_id = max(1, int(save_data.get(SAVE_KEY_NEXT_BUILDING_INSTANCE_ID, 1)))

    var saved_buildings_variant: Variant = save_data.get(SAVE_KEY_REGION_BUILDINGS, [])
    var restored_buildings_variant: Variant = restore_save_safe_value(saved_buildings_variant)

    if typeof(restored_buildings_variant) == TYPE_ARRAY:
        var restored_buildings: Array = restored_buildings_variant

        for building_index in range(restored_buildings.size()):
            var building_variant: Variant = restored_buildings[building_index]

            if typeof(building_variant) != TYPE_DICTIONARY:
                continue

            var building_data: Dictionary = building_variant
            var instance_id: int = int(building_data.get("instance_id", 0))

            if instance_id <= 0:
               continue

            sanitize_loaded_building_runtime_data(building_data)

            region_buildings.append(building_data)

            if instance_id >= next_building_instance_id:
                next_building_instance_id = instance_id + 1

    has_chieftain = bool(save_data.get(SAVE_KEY_HAS_CHIEFTAIN, false))
    has_warleader = bool(save_data.get(SAVE_KEY_HAS_WARLEADER, false))
    has_spiritual_leader = bool(save_data.get(SAVE_KEY_HAS_SPIRITUAL_LEADER, false))

    var restored_chieftain_variant: Variant = restore_save_safe_value(
        save_data.get(SAVE_KEY_CHIEFTAIN_DATA, {})
    )

    if typeof(restored_chieftain_variant) == TYPE_DICTIONARY:
        chieftain_data = restored_chieftain_variant
    else:
        chieftain_data = {}

    var restored_warleader_variant: Variant = restore_save_safe_value(
        save_data.get(SAVE_KEY_WARLEADER_DATA, {})
    )

    if typeof(restored_warleader_variant) == TYPE_DICTIONARY:
        warleader_data = restored_warleader_variant
    else:
        warleader_data = {}

    var restored_spiritual_leader_variant: Variant = restore_save_safe_value(
        save_data.get(SAVE_KEY_SPIRITUAL_LEADER_DATA, {})
    )

    if typeof(restored_spiritual_leader_variant) == TYPE_DICTIONARY:
        spiritual_leader_data = restored_spiritual_leader_variant
    else:
        spiritual_leader_data = {}

    var restored_hero_placeholders_variant: Variant = restore_save_safe_value(
        save_data.get(SAVE_KEY_HERO_PLACEHOLDERS, {})
    )

    if typeof(restored_hero_placeholders_variant) == TYPE_DICTIONARY:
        hero_placeholders = restored_hero_placeholders_variant
    else:
        hero_placeholders = {}

    rebuild_occupied_tiles_from_buildings()


func rebuild_occupied_tiles_from_buildings() -> void:
    if region_tiles.is_empty():
        return

    for y in range(region_height):
        for x in range(region_width):
            var tile_data: Dictionary = region_tiles[y][x]
            tile_data["occupied"] = false
            tile_data.erase("building_id")
            tile_data.erase("building_instance_id")
            region_tiles[y][x] = tile_data

    for building_index in range(region_buildings.size()):
        var building_variant: Variant = region_buildings[building_index]

        if typeof(building_variant) != TYPE_DICTIONARY:
            continue

        var building_data: Dictionary = building_variant
        var building_id: String = str(building_data.get("id", ""))
        var building_instance_id: int = int(building_data.get("instance_id", 0))
        var tile_x: int = int(building_data.get("x", 0))
        var tile_y: int = int(building_data.get("y", 0))
        var footprint_width: int = int(building_data.get("width", 1))
        var footprint_height: int = int(building_data.get("height", 1))

        for y_offset in range(footprint_height):
            for x_offset in range(footprint_width):
                var tile_position := Vector2i(
                    tile_x + x_offset,
                    tile_y + y_offset
                )

                if not is_tile_in_bounds(tile_position):
                    continue

                var tile_data: Dictionary = region_tiles[tile_position.y][tile_position.x]
                tile_data["occupied"] = true
                tile_data["building_id"] = building_id
                tile_data["building_instance_id"] = building_instance_id
                region_tiles[tile_position.y][tile_position.x] = tile_data


func get_save_safe_value(value: Variant) -> Variant:
    match typeof(value):
        TYPE_VECTOR2I:
            var vector_value: Vector2i = value

            return {
                SAVE_TYPE_KEY: SAVE_TYPE_VECTOR2I,
                "x": vector_value.x,
                "y": vector_value.y
            }

        TYPE_COLOR:
            var color_value: Color = value

            return {
                SAVE_TYPE_KEY: SAVE_TYPE_COLOR,
                "r": color_value.r,
                "g": color_value.g,
                "b": color_value.b,
                "a": color_value.a
            }

        TYPE_DICTIONARY:
            var source_dict: Dictionary = value
            var output_dict: Dictionary = {}
            var keys: Array = source_dict.keys()

            for key_index in range(keys.size()):
                var key_variant: Variant = keys[key_index]
                var key_string: String = str(key_variant)

                output_dict[key_string] = get_save_safe_value(source_dict.get(key_variant))

            return output_dict

        TYPE_ARRAY:
            var source_array: Array = value
            var output_array: Array = []

            for value_index in range(source_array.size()):
                output_array.append(get_save_safe_value(source_array[value_index]))

            return output_array

        _:
            return value


func restore_save_safe_value(value: Variant) -> Variant:
    if typeof(value) == TYPE_DICTIONARY:
        var source_dict: Dictionary = value

        if str(source_dict.get(SAVE_TYPE_KEY, "")) == SAVE_TYPE_VECTOR2I:
            return Vector2i(
                int(source_dict.get("x", 0)),
                int(source_dict.get("y", 0))
            )

        if str(source_dict.get(SAVE_TYPE_KEY, "")) == SAVE_TYPE_COLOR:
            return Color(
                float(source_dict.get("r", 1.0)),
                float(source_dict.get("g", 1.0)),
                float(source_dict.get("b", 1.0)),
                float(source_dict.get("a", 1.0))
            )

        var restored_dict: Dictionary = {}
        var keys: Array = source_dict.keys()

        for key_index in range(keys.size()):
            var key_variant: Variant = keys[key_index]
            var key_string: String = str(key_variant)

            restored_dict[key_string] = restore_save_safe_value(source_dict.get(key_variant))

        return restored_dict

    if typeof(value) == TYPE_ARRAY:
        var source_array: Array = value
        var restored_array: Array = []

        for value_index in range(source_array.size()):
            restored_array.append(restore_save_safe_value(source_array[value_index]))

        return restored_array

    return value


func get_buildings() -> Array:
    return region_buildings


func get_current_building_id() -> String:
    return current_building_id


func get_current_build_mode() -> String:
    return current_build_mode


func is_in_build_mode() -> bool:
    return current_build_mode != BUILD_MODE_NONE and current_building_id != ""


func get_has_chieftain() -> bool:
    return has_chieftain


func get_chieftain_data() -> Dictionary:
    return chieftain_data.duplicate(true)


func get_chieftain_tile() -> Vector2i:
    if not has_chieftain:
        return Vector2i(-1, -1)

    return chieftain_data.get("tile", Vector2i(-1, -1))


func get_has_warleader() -> bool:
    return has_warleader


func get_warleader_data() -> Dictionary:
    return warleader_data.duplicate(true)


func get_has_spiritual_leader() -> bool:
    return has_spiritual_leader


func get_spiritual_leader_data() -> Dictionary:
    return spiritual_leader_data.duplicate(true)


func get_hero_placeholders() -> Dictionary:
    return hero_placeholders.duplicate(true)


func start_building_placement(building_id: String) -> void:
    var building_data: Dictionary = RegionBuildingData.get_building(building_id)

    if building_data.is_empty():
        push_warning("Unknown building id: " + building_id)
        return

    if not bool(building_data.get("unlocked", false)):
        print("Building is locked: ", str(building_data.get("name", building_id)))
        return

    current_build_mode = building_id
    current_building_id = building_id

    print(str(building_data.get("name", building_id)) + " placement mode: ON")
    print("Resource Cost: " + get_cost_text_from_dictionary(building_data.get("cost", {})))
    print("Item Cost: " + get_item_cost_text_from_dictionary(building_data.get("item_cost", {})))

    if current_building_id == RegionBuildingData.BUILDING_STORAGE_AREA:
        print("Storage Area starts unassigned. Click it after building to choose what resource it stores.")

    if bool(building_data.get("requires_campfire_range", false)):
        print("Placement Requirement: Must be within active fire range.")

    if bool(building_data.get("assignment_enabled", false)):
        print("Assignment Slots: ", int(building_data.get("assignment_slots", 0)))
        print("Assignment Role: ", str(building_data.get("assignment_role", "")))


func cancel_build_mode() -> void:
    current_build_mode = BUILD_MODE_NONE
    current_building_id = ""

    print("Build mode cancelled.")


func try_place_current_building(
    origin_tile: Vector2i,
    inventory: RegionInventory,
    item_inventory: RegionItemInventory
) -> bool:
    if current_building_id == "":
        print("No building selected.")
        return false

    var building_data: Dictionary = RegionBuildingData.get_building(current_building_id)

    if building_data.is_empty():
        push_warning("Cannot place unknown building: " + current_building_id)
        cancel_build_mode()
        return false

    if not is_tile_in_bounds(origin_tile):
        print("Cannot place building outside the map.")
        return false

    var footprint_width: int = int(building_data.get("width", 1))
    var footprint_height: int = int(building_data.get("height", 1))
    var building_name: String = str(building_data.get("name", current_building_id))

    var cost: Dictionary = get_dictionary_from_variant(building_data.get("cost", {}))
    var item_cost: Dictionary = get_dictionary_from_variant(building_data.get("item_cost", {}))

    if not can_place_building(origin_tile, footprint_width, footprint_height):
        print("Cannot place " + building_name + " here.")
        print_building_placement_failure_reason(
            origin_tile,
            footprint_width,
            footprint_height
        )
        return false

    if not inventory.has_cost(cost):
        print("Not enough resources to build " + building_name + ".")
        print("Need resources: " + get_cost_text_from_dictionary(cost))
        return false

    if not has_item_cost(item_inventory, item_cost):
        print("Not enough items to build " + building_name + ".")
        print("Need items: " + get_item_cost_text_from_dictionary(item_cost))
        return false

    inventory.spend_cost(cost)
    spend_item_cost(item_inventory, item_cost)

    var placed_building_instance_id: int = place_building(
        current_building_id,
        building_name,
        origin_tile,
        footprint_width,
        footprint_height
    )

    apply_building_unlock_side_effects(
        current_building_id,
        placed_building_instance_id
    )

    print(building_name + " built at: ", origin_tile)

    current_build_mode = BUILD_MODE_NONE
    current_building_id = ""

    return true


func apply_building_unlock_side_effects(
    building_id: String,
    building_instance_id: int
) -> void:
    if building_id == RegionBuildingData.BUILDING_SHELTER:
        var shelter_count: int = get_built_shelter_count()

        print("Shelters built: ", shelter_count)
        print("Normal housing capacity: ", get_normal_housing_capacity())

    if building_id == RegionBuildingData.BUILDING_TENT:
        print("Normal housing capacity: ", get_normal_housing_capacity())

    var placed_building: Dictionary = get_building_by_instance_id(building_instance_id)

    if bool(placed_building.get("hero_placeholder_enabled", false)):
        grant_generic_hero_placeholder(building_instance_id)

    if building_id == RegionBuildingData.BUILDING_BONFIRE:
        print("Bonfire built. Active fire range expanded from this building.")


func grant_generic_chieftain(
    source_building_instance_id: int,
    source_building_id: String = RegionBuildingData.BUILDING_CHIEFTAINS_SHELTER
) -> void:
    if has_chieftain:
        print("The village already has a Chieftain.")
        return

    var source_building: Dictionary = get_building_by_instance_id(source_building_instance_id)
    var chieftain_tile := Vector2i(region_width / 2, region_height / 2)

    if not source_building.is_empty():
        chieftain_tile = get_building_center_tile(source_building)

    has_chieftain = true
    chieftain_data = {
        "name": "Generic Chieftain",
        "role": "chieftain",
        "shape": "crown",
        "color": Color(1.0, 0.85, 0.25, 1.0),
        "skills": {},
        "traits": {},
        "source": source_building_id,
        "shelter_instance_id": source_building_instance_id,
        "tile": chieftain_tile
    }

    hero_placeholders["chieftain"] = chieftain_data.duplicate(true)

    print("A generic Chieftain now leads the village.")


func grant_generic_hero_placeholder(source_building_instance_id: int) -> void:
    var source_building: Dictionary = get_building_by_instance_id(source_building_instance_id)

    if source_building.is_empty():
        return

    var hero_role: String = str(source_building.get("hero_placeholder_role", ""))

    if hero_role == "":
        return

    if hero_placeholders.has(hero_role):
        print("The village already has placeholder hero: " + hero_role)
        return

    var source_building_id: String = str(source_building.get("id", ""))
    var source_building_name: String = str(source_building.get("name", source_building_id))
    var hero_tile: Vector2i = get_building_center_tile(source_building)
    var hero_shape: String = str(source_building.get("hero_placeholder_shape", "marker"))
    var hero_color: Color = source_building.get("hero_placeholder_color", Color(1.0, 1.0, 1.0, 1.0))

    var hero_name: String = get_placeholder_hero_display_name(hero_role)

    var hero_data: Dictionary = {
        "name": hero_name,
        "role": hero_role,
        "shape": hero_shape,
        "color": hero_color,
        "skills": {},
        "traits": {},
        "source": source_building_id,
        "source_name": source_building_name,
        "shelter_instance_id": source_building_instance_id,
        "tile": hero_tile
    }

    hero_placeholders[hero_role] = hero_data.duplicate(true)

    if hero_role == "chieftain":
        has_chieftain = true
        chieftain_data = hero_data.duplicate(true)

    elif hero_role == "warleader":
        has_warleader = true
        warleader_data = hero_data.duplicate(true)

    elif hero_role == "spiritual_leader":
        has_spiritual_leader = true
        spiritual_leader_data = hero_data.duplicate(true)

    print(hero_name + " placeholder created from " + source_building_name + ".")


func get_placeholder_hero_display_name(hero_role: String) -> String:
    if hero_role == "chieftain":
        return "Generic Chieftain"

    if hero_role == "warleader":
        return "Generic Warleader"

    if hero_role == "spiritual_leader":
        return "Generic Spiritual Leader"

    return hero_role.capitalize()


func can_place_current_building(origin_tile: Vector2i) -> bool:
    if current_building_id == "":
        return false

    var building_data: Dictionary = RegionBuildingData.get_building(current_building_id)

    if building_data.is_empty():
        return false

    var footprint_width: int = int(building_data.get("width", 1))
    var footprint_height: int = int(building_data.get("height", 1))

    if not can_place_building(origin_tile, footprint_width, footprint_height):
        return false

    if not meets_campfire_range_requirement(
        building_data,
        origin_tile,
        footprint_width,
        footprint_height
    ):
        return false

    return true


func get_current_building_footprint() -> Vector2i:
    if current_building_id == "":
        return Vector2i(1, 1)

    var building_data: Dictionary = RegionBuildingData.get_building(current_building_id)

    if building_data.is_empty():
        return Vector2i(1, 1)

    return Vector2i(
        int(building_data.get("width", 1)),
        int(building_data.get("height", 1))
    )


func can_place_building(
    origin_tile: Vector2i,
    footprint_width: int,
    footprint_height: int
) -> bool:
    if origin_tile.x < 0 or origin_tile.y < 0:
        return false

    if origin_tile.x + footprint_width > region_width:
        return false

    if origin_tile.y + footprint_height > region_height:
        return false

    for y_offset in range(footprint_height):
        for x_offset in range(footprint_width):
            var tile_position := Vector2i(
                origin_tile.x + x_offset,
                origin_tile.y + y_offset
            )

            var tile_data: Dictionary = region_tiles[tile_position.y][tile_position.x]

            if not bool(tile_data.get("buildable", false)):
                return false

            if bool(tile_data.get("occupied", false)):
                return false

    return true


func meets_campfire_range_requirement(
    building_data: Dictionary,
    origin_tile: Vector2i,
    footprint_width: int,
    footprint_height: int
) -> bool:
    if not bool(building_data.get("requires_campfire_range", false)):
        return true

    return is_footprint_in_active_fire_range(
        origin_tile,
        footprint_width,
        footprint_height
    )


func is_footprint_in_active_fire_range(
    origin_tile: Vector2i,
    footprint_width: int,
    footprint_height: int
) -> bool:
    for building_index in range(region_buildings.size()):
        var building_variant: Variant = region_buildings[building_index]

        if typeof(building_variant) != TYPE_DICTIONARY:
            continue

        var building_data: Dictionary = building_variant
        var building_id: String = str(building_data.get("id", ""))

        if not is_fire_source_building(building_id):
            continue

        if not is_protection_light_building_lit(building_data):
           continue

        var fire_origin := Vector2i(
            int(building_data.get("x", 0)),
            int(building_data.get("y", 0))
        )

        var fire_width: int = int(building_data.get("width", 1))
        var fire_height: int = int(building_data.get("height", 1))
        var fire_radius: int = int(building_data.get("campfire_radius", RegionBuildingData.CAMPFIRE_BUILD_RADIUS))

        if footprints_are_within_range(
            origin_tile,
            footprint_width,
            footprint_height,
            fire_origin,
            fire_width,
            fire_height,
            fire_radius
        ):
            return true

    return false


func is_fire_source_building(building_id: String) -> bool:
    return ProtectionLightData.is_protection_light_building(building_id)
    
func is_protection_light_building_lit(building_data: Dictionary) -> bool:
    var building_id: String = str(building_data.get("id", ""))

    if not ProtectionLightData.is_protection_light_building(building_id):
        return false

    return bool(building_data.get(KEY_IS_LIT, building_data.get(KEY_ACTIVE, true)))


func footprints_are_within_range(
    first_origin: Vector2i,
    first_width: int,
    first_height: int,
    second_origin: Vector2i,
    second_width: int,
    second_height: int,
    radius: int
) -> bool:
    for first_y_offset in range(first_height):
        for first_x_offset in range(first_width):
            var first_tile := Vector2i(
                first_origin.x + first_x_offset,
                first_origin.y + first_y_offset
            )

            for second_y_offset in range(second_height):
                for second_x_offset in range(second_width):
                    var second_tile := Vector2i(
                        second_origin.x + second_x_offset,
                        second_origin.y + second_y_offset
                    )

                    var distance: int = abs(first_tile.x - second_tile.x) + abs(first_tile.y - second_tile.y)

                    if distance <= radius:
                        return true

    return false


func place_building(
    building_id: String,
    display_name: String,
    origin_tile: Vector2i,
    footprint_width: int,
    footprint_height: int
) -> int:
    var building_instance_id: int = next_building_instance_id
    next_building_instance_id += 1

    var source_building_data: Dictionary = RegionBuildingData.get_building(building_id)

    var building_data := {
        "instance_id": building_instance_id,
        "id": building_id,
        "name": display_name,
        "x": origin_tile.x,
        "y": origin_tile.y,
        "width": footprint_width,
        "height": footprint_height,
        "active": true
    }

    copy_runtime_building_metadata(
        building_data,
        source_building_data
    )
    
    initialize_protection_light_building_runtime_data(building_data)

    region_buildings.append(building_data)

    for y_offset in range(footprint_height):
        for x_offset in range(footprint_width):
            var tile_position := Vector2i(
                origin_tile.x + x_offset,
                origin_tile.y + y_offset
            )

            var tile_data: Dictionary = region_tiles[tile_position.y][tile_position.x]
            tile_data["occupied"] = true
            tile_data["building_id"] = building_id
            tile_data["building_instance_id"] = building_instance_id

    return building_instance_id


func copy_runtime_building_metadata(
    target_building_data: Dictionary,
    source_building_data: Dictionary
) -> void:
    if source_building_data.is_empty():
        return

    var metadata_keys: Array = [
        "storage_resource",
        "storage_capacity",
        "housing_capacity",
        "portable_shelter",
        "houses_chieftain",
        "grants_generic_chieftain",
        "houses_warleader",
        "grants_generic_warleader",
        "houses_spiritual_leader",
        "grants_generic_spiritual_leader",
        "campfire_radius",
        "provides_bonfire_radius",
        "research_per_minute",
        "crafting_skill",
        "specialist_role",
        "specialist_housing_capacity",
        "ritual_site",
        "assignment_enabled",
        "assignment_slots",
        "assignment_role",
        "assignment_replaces_shelter",
        "hero_placeholder_enabled",
        "hero_placeholder_role",
        "hero_placeholder_shape",
        "hero_placeholder_color"
    ]

    for key_index in range(metadata_keys.size()):
        var key: String = str(metadata_keys[key_index])

        if not source_building_data.has(key):
            continue

        target_building_data[key] = source_building_data[key]

    if bool(target_building_data.get("assignment_enabled", false)):
        target_building_data["assigned_villagers"] = []

    if str(target_building_data.get("id", "")) == RegionBuildingData.BUILDING_STORAGE_AREA:
        if not target_building_data.has("storage_resource"):
            target_building_data["storage_resource"] = ""

        if not target_building_data.has("storage_capacity"):
            target_building_data["storage_capacity"] = RegionBuildingData.STORAGE_AREA_CAPACITY
            
func initialize_protection_light_building_runtime_data(building_data: Dictionary) -> void:
    var building_id: String = str(building_data.get("id", ""))

    if not ProtectionLightData.is_protection_light_building(building_id):
        return

    var fuel_interval: float = ProtectionLightData.get_fuel_interval_for_building(building_id)

    building_data[KEY_IS_LIT] = true
    building_data[KEY_ACTIVE] = true
    building_data[KEY_FUEL_TIMER] = fuel_interval
    building_data[KEY_LAST_FUEL_MESSAGE_STATE] = "lit"
    
func sanitize_loaded_building_runtime_data(building_data: Dictionary) -> void:
    var building_id: String = str(building_data.get("id", ""))

    if not ProtectionLightData.is_protection_light_building(building_id):
        return

    var fuel_interval: float = ProtectionLightData.get_fuel_interval_for_building(building_id)

    if not building_data.has(KEY_IS_LIT):
        building_data[KEY_IS_LIT] = bool(building_data.get(KEY_ACTIVE, true))

    if not building_data.has(KEY_ACTIVE):
        building_data[KEY_ACTIVE] = bool(building_data.get(KEY_IS_LIT, true))

    if not building_data.has(KEY_FUEL_TIMER):
        building_data[KEY_FUEL_TIMER] = fuel_interval

    if not building_data.has(KEY_LAST_FUEL_MESSAGE_STATE):
        if bool(building_data.get(KEY_IS_LIT, true)):
            building_data[KEY_LAST_FUEL_MESSAGE_STATE] = "lit"
        else:
            building_data[KEY_LAST_FUEL_MESSAGE_STATE] = "unlit"


func get_normal_housing_capacity() -> int:
    var housing_capacity: int = 0

    for building_index in range(region_buildings.size()):
        var building_variant: Variant = region_buildings[building_index]

        if typeof(building_variant) != TYPE_DICTIONARY:
            continue

        var building_data: Dictionary = building_variant
        var building_id: String = str(building_data.get("id", ""))

        if not is_normal_housing_building(building_id):
            continue

        if not bool(building_data.get("active", true)):
            continue

        housing_capacity += int(building_data.get("housing_capacity", 0))

    return housing_capacity


func is_normal_housing_building(building_id: String) -> bool:
    return (
        building_id == RegionBuildingData.BUILDING_SHELTER
        or building_id == RegionBuildingData.BUILDING_TENT
    )


func has_available_normal_housing(current_villager_count: int) -> bool:
    return get_normal_housing_capacity() > current_villager_count


func get_shelter_replacing_assignment_count() -> int:
    var assignment_count: int = 0

    for building_index in range(region_buildings.size()):
        var building_variant: Variant = region_buildings[building_index]

        if typeof(building_variant) != TYPE_DICTIONARY:
            continue

        var building_data: Dictionary = building_variant

        if not bool(building_data.get("assignment_replaces_shelter", false)):
            continue

        var assigned_villagers: Array = building_data.get("assigned_villagers", [])

        assignment_count += assigned_villagers.size()

    return assignment_count


func get_built_shelter_count() -> int:
    var shelter_count: int = 0

    for building_index in range(region_buildings.size()):
        var building_variant: Variant = region_buildings[building_index]

        if typeof(building_variant) != TYPE_DICTIONARY:
            continue

        var building_data: Dictionary = building_variant
        var building_id: String = str(building_data.get("id", ""))

        if building_id == RegionBuildingData.BUILDING_SHELTER:
            shelter_count += 1

    return shelter_count


func get_building_count_by_id(target_building_id: String) -> int:
    var building_count: int = 0

    for building_index in range(region_buildings.size()):
        var building_variant: Variant = region_buildings[building_index]

        if typeof(building_variant) != TYPE_DICTIONARY:
            continue

        var building_data: Dictionary = building_variant
        var building_id: String = str(building_data.get("id", ""))

        if building_id == target_building_id:
            building_count += 1

    return building_count
    
func update_protection_light_fuel(
    delta: float,
    inventory: RegionInventory
) -> Array:
    var messages: Array = []

    if delta <= 0.0:
        return messages

    for building_index in range(region_buildings.size()):
        var building_variant: Variant = region_buildings[building_index]

        if typeof(building_variant) != TYPE_DICTIONARY:
            continue

        var building_data: Dictionary = building_variant
        var building_id: String = str(building_data.get("id", ""))

        if not ProtectionLightData.is_protection_light_building(building_id):
            continue

        if not ProtectionLightData.building_requires_fuel(building_id):
            building_data[KEY_IS_LIT] = true
            building_data[KEY_ACTIVE] = true
            region_buildings[building_index] = building_data
            continue

        if not ProtectionLightData.should_auto_fuel_building(building_id):
            region_buildings[building_index] = building_data
            continue

        var fuel_interval: float = ProtectionLightData.get_fuel_interval_for_building(building_id)

        if fuel_interval <= 0.0:
            building_data[KEY_IS_LIT] = true
            building_data[KEY_ACTIVE] = true
            region_buildings[building_index] = building_data
            continue

        var current_timer: float = float(building_data.get(KEY_FUEL_TIMER, fuel_interval))
        current_timer -= delta

        if current_timer > 0.0:
            building_data[KEY_FUEL_TIMER] = current_timer
            region_buildings[building_index] = building_data
            continue

        var fuel_cost: Dictionary = ProtectionLightData.get_fuel_cost_for_building(building_id)
        var source_name: String = ProtectionLightData.get_display_name_for_building(building_id)
        var building_instance_id: int = int(building_data.get("instance_id", 0))

        if inventory.has_cost(fuel_cost):
            inventory.spend_cost(fuel_cost)

            building_data[KEY_IS_LIT] = true
            building_data[KEY_ACTIVE] = true
            building_data[KEY_FUEL_TIMER] = fuel_interval

            if str(building_data.get(KEY_LAST_FUEL_MESSAGE_STATE, "lit")) != "lit":
                messages.append(
                    source_name
                    + " #"
                    + str(building_instance_id)
                    + " has been refueled and relit."
                )

            building_data[KEY_LAST_FUEL_MESSAGE_STATE] = "lit"
        else:
            building_data[KEY_IS_LIT] = false
            building_data[KEY_ACTIVE] = false
            building_data[KEY_FUEL_TIMER] = min(30.0, fuel_interval)

            if str(building_data.get(KEY_LAST_FUEL_MESSAGE_STATE, "lit")) != "unlit":
                messages.append(
                    source_name
                    + " #"
                    + str(building_instance_id)
                    + " has gone out. More fuel is needed."
                )

            building_data[KEY_LAST_FUEL_MESSAGE_STATE] = "unlit"

        region_buildings[building_index] = building_data

    return messages


func get_building_center_tile(building_data: Dictionary) -> Vector2i:
    var tile_x: int = int(building_data.get("x", 0))
    var tile_y: int = int(building_data.get("y", 0))
    var width: int = int(building_data.get("width", 1))
    var height: int = int(building_data.get("height", 1))

    return Vector2i(
        tile_x + int(floor(float(width) / 2.0)),
        tile_y + int(floor(float(height) / 2.0))
    )


func get_building_at_tile(tile_position: Vector2i) -> Dictionary:
    if not is_tile_in_bounds(tile_position):
        return {}

    var tile_data: Dictionary = region_tiles[tile_position.y][tile_position.x]

    if not bool(tile_data.get("occupied", false)):
        return {}

    var building_instance_id: int = int(tile_data.get("building_instance_id", 0))

    if building_instance_id <= 0:
        return {}

    return get_building_by_instance_id(building_instance_id)


func get_building_by_instance_id(building_instance_id: int) -> Dictionary:
    for building_index in range(region_buildings.size()):
        var building_variant: Variant = region_buildings[building_index]

        if typeof(building_variant) != TYPE_DICTIONARY:
            continue

        var building_data: Dictionary = building_variant

        if int(building_data.get("instance_id", 0)) == building_instance_id:
            return building_data

    return {}

func destroy_building_by_instance_id(building_instance_id: int) -> Dictionary:
    var result: Dictionary = {
        "success": false,
        "message": "",
        "building_instance_id": building_instance_id,
        "building_id": "",
        "building_name": "",
        "assigned_villagers": []
    }

    # Destroy should always leave placement mode.
    cancel_build_mode()

    if building_instance_id <= 0:
        result["message"] = "Invalid building."
        return result

    var building_index: int = get_building_index_by_instance_id(building_instance_id)

    if building_index < 0:
        result["message"] = "Building not found."
        return result

    var building_data: Dictionary = region_buildings[building_index]
    var building_id: String = str(building_data.get("id", ""))
    var building_name: String = str(building_data.get("name", "Building"))
    var assigned_villagers: Array = building_data.get("assigned_villagers", [])

    result["building_id"] = building_id
    result["building_name"] = building_name
    result["assigned_villagers"] = assigned_villagers.duplicate(true)

    if is_hero_placeholder_building(building_data):
        result["message"] = building_name + " cannot be destroyed yet because it is tied to a hero placeholder."
        return result

    region_buildings.remove_at(building_index)

    # Safer than partial tile cleanup: rebuild map occupancy from remaining buildings.
    rebuild_occupied_tiles_from_buildings()

    result["success"] = true
    result["message"] = building_name + " destroyed."

    return result


func clear_building_occupied_tiles(building_data: Dictionary) -> void:
    if region_tiles.is_empty():
        return

    var tile_x: int = int(building_data.get("x", 0))
    var tile_y: int = int(building_data.get("y", 0))
    var footprint_width: int = int(building_data.get("width", 1))
    var footprint_height: int = int(building_data.get("height", 1))
    var building_instance_id: int = int(building_data.get("instance_id", 0))

    for y_offset in range(footprint_height):
        for x_offset in range(footprint_width):
            var tile_position := Vector2i(
                tile_x + x_offset,
                tile_y + y_offset
            )

            if not is_tile_in_bounds(tile_position):
                continue

            var tile_data: Dictionary = region_tiles[tile_position.y][tile_position.x]

            if int(tile_data.get("building_instance_id", 0)) != building_instance_id:
                continue

            tile_data["occupied"] = false
            tile_data.erase("building_id")
            tile_data.erase("building_instance_id")
            region_tiles[tile_position.y][tile_position.x] = tile_data

func get_building_index_by_instance_id(building_instance_id: int) -> int:
    for building_index in range(region_buildings.size()):
        var building_variant: Variant = region_buildings[building_index]

        if typeof(building_variant) != TYPE_DICTIONARY:
            continue

        var building_data: Dictionary = building_variant

        if int(building_data.get("instance_id", 0)) == building_instance_id:
            return building_index

    return -1


func is_storage_area_building(building_data: Dictionary) -> bool:
    return str(building_data.get("id", "")) == RegionBuildingData.BUILDING_STORAGE_AREA

func is_hero_placeholder_building(building_data: Dictionary) -> bool:
    return bool(building_data.get("hero_placeholder_enabled", false))

func is_assignment_enabled_building(building_data: Dictionary) -> bool:
    return bool(building_data.get("assignment_enabled", false))


func get_building_assignment_slots(building_instance_id: int) -> int:
    var building_data: Dictionary = get_building_by_instance_id(building_instance_id)

    if building_data.is_empty():
        return 0

    return int(building_data.get("assignment_slots", 0))


func get_building_assignment_count(building_instance_id: int) -> int:
    var building_data: Dictionary = get_building_by_instance_id(building_instance_id)

    if building_data.is_empty():
        return 0

    var assigned_villagers: Array = building_data.get("assigned_villagers", [])

    return assigned_villagers.size()


func get_building_assignment_role(building_instance_id: int) -> String:
    var building_data: Dictionary = get_building_by_instance_id(building_instance_id)

    if building_data.is_empty():
        return ""

    return str(building_data.get("assignment_role", ""))


func building_assignment_replaces_shelter(building_instance_id: int) -> bool:
    var building_data: Dictionary = get_building_by_instance_id(building_instance_id)

    if building_data.is_empty():
        return false

    return bool(building_data.get("assignment_replaces_shelter", false))


func can_assign_villager_to_building(
    villager_id: int,
    building_instance_id: int
) -> bool:
    if villager_id <= 0:
        return false

    var building_data: Dictionary = get_building_by_instance_id(building_instance_id)

    if building_data.is_empty():
        return false

    if not is_assignment_enabled_building(building_data):
        return false

    if not bool(building_data.get("active", true)):
        return false

    var assigned_villagers: Array = building_data.get("assigned_villagers", [])

    if assigned_villagers.has(villager_id):
        return true

    var assignment_slots: int = int(building_data.get("assignment_slots", 0))

    return assigned_villagers.size() < assignment_slots


func assign_villager_to_building(
    villager_id: int,
    building_instance_id: int
) -> Dictionary:
    var result: Dictionary = {
        "success": false,
        "message": "",
        "role": "",
        "replaces_shelter": false,
        "building_instance_id": building_instance_id
    }

    if villager_id <= 0:
        result["message"] = "Invalid villager."
        return result

    var building_index: int = get_building_index_by_instance_id(building_instance_id)

    if building_index < 0:
        result["message"] = "Building not found."
        return result

    var building_data: Dictionary = region_buildings[building_index]

    if not is_assignment_enabled_building(building_data):
        result["message"] = str(building_data.get("name", "Building")) + " does not accept assignments."
        return result

    if not bool(building_data.get("active", true)):
        result["message"] = str(building_data.get("name", "Building")) + " is not active."
        return result

    unassign_villager_from_any_building(villager_id)

    building_index = get_building_index_by_instance_id(building_instance_id)

    if building_index < 0:
        result["message"] = "Building not found after unassignment."
        return result

    building_data = region_buildings[building_index]

    var assigned_villagers: Array = building_data.get("assigned_villagers", [])
    var assignment_slots: int = int(building_data.get("assignment_slots", 0))

    if assigned_villagers.has(villager_id):
        result["success"] = true
        result["role"] = str(building_data.get("assignment_role", ""))
        result["replaces_shelter"] = bool(building_data.get("assignment_replaces_shelter", false))
        result["message"] = "Villager is already assigned to " + str(building_data.get("name", "building")) + "."
        return result

    if assigned_villagers.size() >= assignment_slots:
        result["message"] = str(building_data.get("name", "Building")) + " has no open assignment slots."
        return result

    assigned_villagers.append(villager_id)
    building_data["assigned_villagers"] = assigned_villagers
    region_buildings[building_index] = building_data

    var building_name: String = str(building_data.get("name", "Building"))
    var role: String = str(building_data.get("assignment_role", ""))
    var replaces_shelter: bool = bool(building_data.get("assignment_replaces_shelter", false))

    result["success"] = true
    result["role"] = role
    result["replaces_shelter"] = replaces_shelter
    result["message"] = "Villager assigned to " + building_name + " as " + role + "."

    return result


func unassign_villager_from_any_building(villager_id: int) -> Dictionary:
    var result: Dictionary = {
        "success": false,
        "message": ""
    }

    if villager_id <= 0:
        result["message"] = "Invalid villager."
        return result

    for building_index in range(region_buildings.size()):
        var building_variant: Variant = region_buildings[building_index]

        if typeof(building_variant) != TYPE_DICTIONARY:
            continue

        var building_data: Dictionary = building_variant
        var assigned_villagers: Array = building_data.get("assigned_villagers", [])

        if not assigned_villagers.has(villager_id):
            continue

        assigned_villagers.erase(villager_id)
        building_data["assigned_villagers"] = assigned_villagers
        region_buildings[building_index] = building_data

        result["success"] = true
        result["message"] = "Villager unassigned from " + str(building_data.get("name", "building")) + "."
        return result

    result["message"] = "Villager was not assigned to a building."
    return result


func get_assignment_summary_for_building(building_instance_id: int) -> Dictionary:
    var building_data: Dictionary = get_building_by_instance_id(building_instance_id)

    if building_data.is_empty():
        return {}

    var assigned_villagers: Array = building_data.get("assigned_villagers", [])

    return {
        "assignment_enabled": bool(building_data.get("assignment_enabled", false)),
        "assignment_slots": int(building_data.get("assignment_slots", 0)),
        "assignment_count": assigned_villagers.size(),
        "assignment_role": str(building_data.get("assignment_role", "")),
        "assignment_replaces_shelter": bool(building_data.get("assignment_replaces_shelter", false)),
        "assigned_villagers": assigned_villagers.duplicate()
    }


func assign_storage_area_resource(
    building_instance_id: int,
    new_resource_name: String,
    inventory: RegionInventory
) -> bool:
    if new_resource_name == "":
        return false

    for building_index in range(region_buildings.size()):
        var building_variant: Variant = region_buildings[building_index]

        if typeof(building_variant) != TYPE_DICTIONARY:
            continue

        var building_data: Dictionary = building_variant

        if int(building_data.get("instance_id", 0)) != building_instance_id:
            continue

        if not is_storage_area_building(building_data):
            return false

        var old_resource_name: String = str(building_data.get("storage_resource", ""))

        if old_resource_name == new_resource_name:
            print("Storage Area is already assigned to ", new_resource_name)
            return true

        if old_resource_name != "":
            inventory.remove_storage_capacity(
                old_resource_name,
                RegionBuildingData.STORAGE_AREA_CAPACITY
            )

        building_data["storage_resource"] = new_resource_name

        inventory.add_storage_capacity(
            new_resource_name,
            RegionBuildingData.STORAGE_AREA_CAPACITY
        )

        region_buildings[building_index] = building_data

        print("Storage Area assigned to: ", new_resource_name)

        return true

    return false


func print_building_placement_failure_reason(
    origin_tile: Vector2i,
    footprint_width: int,
    footprint_height: int
) -> void:
    print("")
    print("Placement Debug:")
    print("Origin: ", origin_tile)
    print("Footprint: ", footprint_width, "x", footprint_height)

    if origin_tile.x < 0 or origin_tile.y < 0:
        print("- Origin is outside the map.")
        return

    if origin_tile.x + footprint_width > region_width:
        print("- Footprint extends past right edge of map.")
        return

    if origin_tile.y + footprint_height > region_height:
        print("- Footprint extends past bottom edge of map.")
        return

    for y_offset in range(footprint_height):
        for x_offset in range(footprint_width):
            var tile_position := Vector2i(
                origin_tile.x + x_offset,
                origin_tile.y + y_offset
            )

            if not is_tile_in_bounds(tile_position):
                print("- Tile outside map: ", tile_position)
                continue

            var tile_data: Dictionary = region_tiles[tile_position.y][tile_position.x]

            var terrain: String = str(tile_data.get("terrain", "unknown"))
            var feature: String = str(tile_data.get("feature", "unknown"))
            var buildable: bool = bool(tile_data.get("buildable", false))
            var walkable: bool = bool(tile_data.get("walkable", false))
            var occupied: bool = bool(tile_data.get("occupied", false))
            var resources: Array = tile_data.get("resources", [])

            if not buildable or occupied:
                print(
                    "- Blocking tile ",
                    tile_position,
                    " terrain=",
                    terrain,
                    " feature=",
                    feature,
                    " buildable=",
                    buildable,
                    " walkable=",
                    walkable,
                    " occupied=",
                    occupied,
                    " resources=",
                    resources.size()
                )

    print("")


func get_dictionary_from_variant(value: Variant) -> Dictionary:
    if typeof(value) != TYPE_DICTIONARY:
        return {}

    var dictionary_value: Dictionary = value

    return dictionary_value


func get_cost_text_from_dictionary(cost_variant: Variant) -> String:
    if typeof(cost_variant) != TYPE_DICTIONARY:
        return "Free"

    var cost: Dictionary = cost_variant

    if cost.is_empty():
        return "Free"

    var parts: Array = []
    var resource_names: Array = cost.keys()
    resource_names.sort()

    for resource_index in range(resource_names.size()):
        var resource_name_variant: Variant = resource_names[resource_index]
        var resource_name: String = str(resource_name_variant)
        var amount: int = int(cost.get(resource_name, 0))

        parts.append(resource_name + " " + str(amount))

    return ", ".join(parts)


func has_item_cost(
    item_inventory: RegionItemInventory,
    item_cost_variant: Variant
) -> bool:
    if typeof(item_cost_variant) != TYPE_DICTIONARY:
        return true

    var item_cost: Dictionary = item_cost_variant

    if item_cost.is_empty():
        return true

    var item_ids: Array = item_cost.keys()

    for item_index in range(item_ids.size()):
        var item_id: String = str(item_ids[item_index])
        var required_amount: int = int(item_cost.get(item_id, 0))

        if required_amount <= 0:
            continue

        if not item_inventory.has_item(item_id, required_amount):
            return false

    return true


func spend_item_cost(
    item_inventory: RegionItemInventory,
    item_cost_variant: Variant
) -> bool:
    if typeof(item_cost_variant) != TYPE_DICTIONARY:
        return true

    var item_cost: Dictionary = item_cost_variant

    if item_cost.is_empty():
        return true

    if not has_item_cost(item_inventory, item_cost):
        return false

    var item_ids: Array = item_cost.keys()

    for item_index in range(item_ids.size()):
        var item_id: String = str(item_ids[item_index])
        var required_amount: int = int(item_cost.get(item_id, 0))

        if required_amount <= 0:
            continue

        item_inventory.remove_item(item_id, required_amount)

    return true


func get_item_cost_text_from_dictionary(item_cost_variant: Variant) -> String:
    if typeof(item_cost_variant) != TYPE_DICTIONARY:
        return "Free"

    var item_cost: Dictionary = item_cost_variant

    if item_cost.is_empty():
        return "Free"

    var parts: Array = []
    var item_ids: Array = item_cost.keys()
    item_ids.sort()

    for item_index in range(item_ids.size()):
        var item_id: String = str(item_ids[item_index])
        var amount: int = int(item_cost.get(item_id, 0))
        var item_name: String = get_item_display_name(item_id)

        parts.append(item_name + " " + str(amount))

    return ", ".join(parts)


func get_item_display_name(item_id: String) -> String:
    if item_id == RegionRecipeData.ITEM_POINTED_STICK:
        return "Pointed Stick"

    if item_id == RegionRecipeData.ITEM_SIMPLE_HAND_AXE:
        return "Simple Hand Axe"

    if item_id == RegionRecipeData.ITEM_SHARP_STONE_KNIFE:
        return "Sharp Stone Knife"

    if item_id == RegionRecipeData.ITEM_CRUDE_CONTAINER:
        return "Crude Container"

    if item_id == RegionRecipeData.ITEM_SLING:
        return "Sling"

    if item_id == RegionRecipeData.ITEM_HERBAL_POULTICE:
        return "Herbal Poultice"

    if item_id == RegionRecipeData.ITEM_THROWING_SPEAR:
        return "Throwing Spear"

    if item_id == RegionRecipeData.ITEM_STONE_TIPPED_SPEAR:
        return "Stone-Tipped Spear"

    if item_id == RegionRecipeData.ITEM_STONE_CLUB:
        return "Stone Club"

    if item_id == RegionRecipeData.ITEM_STONE_SCRAPER:
        return "Stone Scraper"

    if item_id == RegionRecipeData.ITEM_WORKED_HAND_AXE:
        return "Worked Hand Axe"

    if item_id == RegionRecipeData.ITEM_DRAG_SLED:
        return "Drag Sled"

    if item_id == RegionRecipeData.ITEM_TENT_KIT:
        return "Tent Kit"

    if item_id == RegionRecipeData.ITEM_ADVANCED_SLING:
        return "Advanced Sling"

    if item_id == RegionRecipeData.ITEM_FLINT_TIPPED_HUNTING_SPEAR:
        return "Flint-Tipped Hunting Spear"

    if item_id == RegionRecipeData.ITEM_FLINT_EDGED_HAND_AXE:
        return "Flint-Edged Hand Axe"

    if item_id == RegionRecipeData.ITEM_FLINT_EDGED_WOODSMAN_AXE:
        return "Flint-Edged Woodsman Axe"

    if item_id == RegionRecipeData.ITEM_FLINT_TIPPED_MINING_PICK:
        return "Flint-Tipped Mining Pick"

    return item_id.capitalize()


func is_tile_in_bounds(tile_position: Vector2i) -> bool:
    return (
        tile_position.x >= 0
        and tile_position.y >= 0
        and tile_position.x < region_width
        and tile_position.y < region_height
    )
