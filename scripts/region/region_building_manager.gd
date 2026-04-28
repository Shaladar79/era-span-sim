extends RefCounted
class_name RegionBuildingManager

const BUILD_MODE_NONE: String = "none"

var region_tiles: Array = []
var region_width: int = 0
var region_height: int = 0

var current_build_mode: String = BUILD_MODE_NONE
var current_building_id: String = ""

var region_buildings: Array = []


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

    if region_tiles.is_empty():
        return

    for y in range(region_height):
        for x in range(region_width):
            var tile_data: Dictionary = region_tiles[y][x]
            tile_data["occupied"] = false
            tile_data.erase("building_id")


func get_buildings() -> Array:
    return region_buildings


func get_current_building_id() -> String:
    return current_building_id


func get_current_build_mode() -> String:
    return current_build_mode


func is_in_build_mode() -> bool:
    return current_build_mode != BUILD_MODE_NONE and current_building_id != ""


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
    print("Cost: " + get_cost_text_from_dictionary(building_data.get("cost", {})))

    if bool(building_data.get("requires_campfire_range", false)):
        print("Placement Requirement: Must be within Campfire range.")


func cancel_build_mode() -> void:
    current_build_mode = BUILD_MODE_NONE
    current_building_id = ""

    print("Build mode cancelled.")


func try_place_current_building(
    origin_tile: Vector2i,
    inventory: RegionInventory
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
    var cost_variant: Variant = building_data.get("cost", {})
    var cost: Dictionary = {}

    if typeof(cost_variant) == TYPE_DICTIONARY:
        cost = cost_variant

    if not can_place_building(origin_tile, footprint_width, footprint_height):
        print("Cannot place " + building_name + " here.")
        print_building_placement_failure_reason(
            origin_tile,
            footprint_width,
            footprint_height
        )
        return false

    if not meets_campfire_range_requirement(building_data, origin_tile, footprint_width, footprint_height):
        print("Cannot place " + building_name + " here.")
        print("- Building must be within range " + str(RegionBuildingData.CAMPFIRE_BUILD_RADIUS) + " of a Campfire.")
        return false

    if not inventory.has_cost(cost):
        print("Not enough resources to build " + building_name + ".")
        print("Need: " + get_cost_text_from_dictionary(cost))
        return false

    inventory.spend_cost(cost)

    place_building(
        current_building_id,
        building_name,
        origin_tile,
        footprint_width,
        footprint_height
    )

    RegionBuildingData.notify_building_built(current_building_id)

    print(building_name + " built at: ", origin_tile)

    current_build_mode = BUILD_MODE_NONE
    current_building_id = ""

    return true


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

    if not meets_campfire_range_requirement(building_data, origin_tile, footprint_width, footprint_height):
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
) -> void:
    var building_data := {
        "id": building_id,
        "name": display_name,
        "x": origin_tile.x,
        "y": origin_tile.y,
        "width": footprint_width,
        "height": footprint_height,
        "active": true
    }

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


func is_tile_in_bounds(tile_position: Vector2i) -> bool:
    return (
        tile_position.x >= 0
        and tile_position.y >= 0
        and tile_position.x < region_width
        and tile_position.y < region_height
    )
