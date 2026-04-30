extends RefCounted
class_name RegionBuildingManager

const BUILD_MODE_NONE: String = "none"

var region_tiles: Array = []
var region_width: int = 0
var region_height: int = 0

var current_build_mode: String = BUILD_MODE_NONE
var current_building_id: String = ""

var region_buildings: Array = []
var next_building_instance_id: int = 1

var has_chieftain: bool = false
var chieftain_data: Dictionary = {}


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

    if region_tiles.is_empty():
        return

    for y in range(region_height):
        for x in range(region_width):
            var tile_data: Dictionary = region_tiles[y][x]
            tile_data["occupied"] = false
            tile_data.erase("building_id")
            tile_data.erase("building_instance_id")


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
        print("Placement Requirement: Must be within Campfire range.")


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

    if not meets_campfire_range_requirement(
        building_data,
        origin_tile,
        footprint_width,
        footprint_height
    ):
        print("Cannot place " + building_name + " here.")
        print("- Building must be within range " + str(RegionBuildingData.CAMPFIRE_BUILD_RADIUS) + " of a Campfire.")
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

    if building_id == RegionBuildingData.BUILDING_CHIEFTAINS_SHELTER:
        grant_generic_chieftain(building_instance_id)


func grant_generic_chieftain(source_building_instance_id: int) -> void:
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
        "skills": {},
        "traits": {},
        "source": RegionBuildingData.BUILDING_CHIEFTAINS_SHELTER,
        "shelter_instance_id": source_building_instance_id,
        "tile": chieftain_tile
    }

    print("A generic Chieftain now leads the village.")


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

    return is_footprint_in_campfire_range(
        origin_tile,
        footprint_width,
        footprint_height
    )


func is_footprint_in_campfire_range(
    origin_tile: Vector2i,
    footprint_width: int,
    footprint_height: int
) -> bool:
    var campfire_radius: int = RegionBuildingData.CAMPFIRE_BUILD_RADIUS

    for building_index in range(region_buildings.size()):
        var building_variant: Variant = region_buildings[building_index]

        if typeof(building_variant) != TYPE_DICTIONARY:
            continue

        var building_data: Dictionary = building_variant
        var building_id: String = str(building_data.get("id", ""))

        if building_id != RegionBuildingData.BUILDING_CAMPFIRE:
            continue

        var campfire_origin := Vector2i(
            int(building_data.get("x", 0)),
            int(building_data.get("y", 0))
        )

        var campfire_width: int = int(building_data.get("width", 1))
        var campfire_height: int = int(building_data.get("height", 1))

        if footprints_are_within_range(
            origin_tile,
            footprint_width,
            footprint_height,
            campfire_origin,
            campfire_width,
            campfire_height,
            campfire_radius
        ):
            return true

    return false


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

    if building_id == RegionBuildingData.BUILDING_STORAGE_AREA:
        building_data["storage_resource"] = ""
        building_data["storage_capacity"] = RegionBuildingData.STORAGE_AREA_CAPACITY

    if building_id == RegionBuildingData.BUILDING_SHELTER:
        building_data["housing_capacity"] = RegionBuildingData.SHELTER_CAPACITY
        building_data["assigned_villagers"] = []

    if building_id == RegionBuildingData.BUILDING_CHIEFTAINS_SHELTER:
        building_data["housing_capacity"] = RegionBuildingData.CHIEFTAINS_SHELTER_CAPACITY
        building_data["houses_chieftain"] = true
        building_data["grants_generic_chieftain"] = true

    if building_id == RegionBuildingData.BUILDING_CAMPFIRE:
        building_data["campfire_radius"] = RegionBuildingData.CAMPFIRE_BUILD_RADIUS

    if building_id == RegionBuildingData.BUILDING_THINKERS_SPOT:
        building_data["research_per_minute"] = RegionBuildingData.THINKERS_SPOT_RESEARCH_PER_MINUTE

    if building_id == RegionBuildingData.BUILDING_STONEWORKING_BENCH:
        building_data["crafting_skill"] = "stoneworking"
        building_data["specialist_role"] = "stoneworker"
        building_data["specialist_housing_capacity"] = 1
        building_data["assigned_villagers"] = []

    if building_id == RegionBuildingData.BUILDING_WOODWORKING_BENCH:
        building_data["crafting_skill"] = "woodworking"
        building_data["specialist_role"] = "woodworker"
        building_data["specialist_housing_capacity"] = 1
        building_data["assigned_villagers"] = []

    if building_id == RegionBuildingData.BUILDING_HUNTERS_HUT:
        building_data["specialist_role"] = "hunter"
        building_data["specialist_housing_capacity"] = RegionBuildingData.SPECIALIST_HUT_CAPACITY
        building_data["assigned_villagers"] = []

    if building_id == RegionBuildingData.BUILDING_WARLEADER_SHELTER:
        building_data["housing_capacity"] = RegionBuildingData.WARLEADER_SHELTER_CAPACITY
        building_data["houses_warleader"] = true
        building_data["grants_generic_warleader"] = true

    if building_id == RegionBuildingData.BUILDING_WARRIOR_HUT:
        building_data["specialist_role"] = "warrior"
        building_data["specialist_housing_capacity"] = RegionBuildingData.SPECIALIST_HUT_CAPACITY
        building_data["assigned_villagers"] = []

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


func get_normal_housing_capacity() -> int:
    var housing_capacity: int = 0

    for building_index in range(region_buildings.size()):
        var building_variant: Variant = region_buildings[building_index]

        if typeof(building_variant) != TYPE_DICTIONARY:
            continue

        var building_data: Dictionary = building_variant
        var building_id: String = str(building_data.get("id", ""))

        if building_id != RegionBuildingData.BUILDING_SHELTER:
            continue

        if not bool(building_data.get("active", true)):
            continue

        housing_capacity += int(building_data.get("housing_capacity", 0))

    return housing_capacity


func has_available_normal_housing(current_villager_count: int) -> bool:
    return get_normal_housing_capacity() > current_villager_count


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


func is_storage_area_building(building_data: Dictionary) -> bool:
    return str(building_data.get("id", "")) == RegionBuildingData.BUILDING_STORAGE_AREA


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
