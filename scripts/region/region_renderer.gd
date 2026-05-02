extends RefCounted
class_name RegionRenderer

const REGION_TERRAIN_GRASS: String = RegionGenerator.REGION_TERRAIN_GRASS
const REGION_TERRAIN_FOREST: String = RegionGenerator.REGION_TERRAIN_FOREST
const REGION_TERRAIN_DIRT: String = RegionGenerator.REGION_TERRAIN_DIRT
const REGION_TERRAIN_ROCK: String = RegionGenerator.REGION_TERRAIN_ROCK
const REGION_TERRAIN_WATER: String = RegionGenerator.REGION_TERRAIN_WATER
const REGION_TERRAIN_MUD: String = RegionGenerator.REGION_TERRAIN_MUD
const REGION_TERRAIN_SHORE: String = RegionGenerator.REGION_TERRAIN_SHORE
const REGION_TERRAIN_DESERT: String = RegionGenerator.REGION_TERRAIN_DESERT
const REGION_TERRAIN_TUNDRA: String = RegionGenerator.REGION_TERRAIN_TUNDRA

const FEATURE_NONE: String = RegionGenerator.FEATURE_NONE
const FEATURE_TREE: String = RegionGenerator.FEATURE_TREE
const FEATURE_BUSH: String = RegionGenerator.FEATURE_BUSH
const FEATURE_STONE: String = RegionGenerator.FEATURE_STONE
const FEATURE_REEDS: String = RegionGenerator.FEATURE_REEDS

const RESOURCE_WOOD: String = RegionGenerator.RESOURCE_WOOD
const RESOURCE_BERRIES: String = RegionGenerator.RESOURCE_BERRIES
const RESOURCE_MUSHROOMS: String = RegionGenerator.RESOURCE_MUSHROOMS
const RESOURCE_STONE: String = RegionGenerator.RESOURCE_STONE
const RESOURCE_FLINT: String = RegionGenerator.RESOURCE_FLINT
const RESOURCE_REEDS: String = RegionGenerator.RESOURCE_REEDS
const RESOURCE_CLAY: String = RegionGenerator.RESOURCE_CLAY
const RESOURCE_FISH: String = RegionGenerator.RESOURCE_FISH
const RESOURCE_FIBER: String = RegionGenerator.RESOURCE_FIBER

const BUILDING_CAMPFIRE: String = RegionBuildingData.BUILDING_CAMPFIRE
const BUILDING_STORAGE_AREA: String = RegionBuildingData.BUILDING_STORAGE_AREA
const BUILDING_SHELTER: String = RegionBuildingData.BUILDING_SHELTER
const BUILDING_CHIEFTAINS_SHELTER: String = RegionBuildingData.BUILDING_CHIEFTAINS_SHELTER


func draw_all(
    canvas: CanvasItem,
    region_tiles: Array,
    region_width: int,
    region_height: int,
    region_tile_size: int,
    show_resource_markers: bool,
    show_campfire_radius: bool,
    building_manager: RegionBuildingManager,
    villager_manager: VillagerManager,
    wild_animals: Array,
    hovered_tile: Vector2i,
    selected_tile: Vector2i,
    is_dragging_villager: bool,
    drag_assignment_tile: Vector2i,
    harvest_assign_radius: int,
    simulation_paused: bool
) -> void:
    draw_region_tiles(
        canvas,
        region_tiles,
        region_width,
        region_height,
        region_tile_size
    )

    draw_region_features(
        canvas,
        region_tiles,
        region_width,
        region_height,
        region_tile_size
    )

    if show_resource_markers:
        draw_region_resource_markers(
            canvas,
            region_tiles,
            region_width,
            region_height,
            region_tile_size
        )

    if show_campfire_radius:
        draw_campfire_radius_markers(
            canvas,
            building_manager,
            region_tile_size
        )

    draw_buildings(
        canvas,
        building_manager,
        region_tile_size
    )

    draw_wild_animals(
        canvas,
        wild_animals,
        region_tile_size
    )

    draw_grave_markers(
        canvas,
        villager_manager,
        region_tile_size
    )

    draw_villagers(
        canvas,
        villager_manager
    )

    draw_chieftain(
        canvas,
        building_manager,
        region_tile_size
    )

    draw_villager_assignment_markers(
        canvas,
        villager_manager,
        region_width,
        region_height,
        region_tile_size
    )

    draw_villager_drag_preview(
        canvas,
        is_dragging_villager,
        drag_assignment_tile,
        harvest_assign_radius,
        region_width,
        region_height,
        region_tile_size
    )

    draw_grid_lines(
        canvas,
        region_width,
        region_height,
        region_tile_size
    )

    draw_building_preview(
        canvas,
        building_manager,
        hovered_tile,
        region_width,
        region_height,
        region_tile_size
    )

    draw_selected_tile(
        canvas,
        selected_tile,
        region_width,
        region_height,
        region_tile_size
    )

    draw_hovered_tile(
        canvas,
        hovered_tile,
        region_width,
        region_height,
        region_tile_size
    )

    draw_pause_overlay(
        canvas,
        simulation_paused
    )


func draw_region_tiles(
    canvas: CanvasItem,
    region_tiles: Array,
    region_width: int,
    region_height: int,
    region_tile_size: int
) -> void:
    for y in range(region_height):
        for x in range(region_width):
            var tile_data: Dictionary = region_tiles[y][x]
            var tile_color: Color = get_region_tile_color(tile_data)

            var tile_position := Vector2(x * region_tile_size, y * region_tile_size)
            var tile_rect := Rect2(
                tile_position,
                Vector2(region_tile_size, region_tile_size)
            )

            canvas.draw_rect(tile_rect, tile_color, true)


func draw_region_features(
    canvas: CanvasItem,
    region_tiles: Array,
    region_width: int,
    region_height: int,
    region_tile_size: int
) -> void:
    for y in range(region_height):
        for x in range(region_width):
            var tile_data: Dictionary = region_tiles[y][x]
            var feature: String = str(tile_data.get("feature", FEATURE_NONE))

            if feature == FEATURE_NONE:
                continue

            draw_region_feature(
                canvas,
                x,
                y,
                feature,
                region_tile_size
            )


func draw_region_feature(
    canvas: CanvasItem,
    tile_x: int,
    tile_y: int,
    feature: String,
    region_tile_size: int
) -> void:
    var tile_origin := Vector2(tile_x * region_tile_size, tile_y * region_tile_size)
    var center := tile_origin + Vector2(
        region_tile_size / 2.0,
        region_tile_size / 2.0
    )

    match feature:
        FEATURE_TREE:
            canvas.draw_circle(center, 5.0, Color(0.02, 0.22, 0.06))
        FEATURE_BUSH:
            canvas.draw_circle(center, 3.5, Color(0.10, 0.45, 0.10))
        FEATURE_STONE:
            canvas.draw_circle(center, 4.0, Color(0.55, 0.55, 0.55))
        FEATURE_REEDS:
            canvas.draw_circle(center, 3.5, Color(0.62, 0.72, 0.20))
        _:
            pass


func draw_region_resource_markers(
    canvas: CanvasItem,
    region_tiles: Array,
    region_width: int,
    region_height: int,
    region_tile_size: int
) -> void:
    for y in range(region_height):
        for x in range(region_width):
            var tile_data: Dictionary = region_tiles[y][x]
            var resources: Array = tile_data.get("resources", [])

            if resources.is_empty():
                continue

            draw_tile_resource_markers(
                canvas,
                x,
                y,
                resources,
                region_tile_size
            )


func draw_tile_resource_markers(
    canvas: CanvasItem,
    tile_x: int,
    tile_y: int,
    resources: Array,
    region_tile_size: int
) -> void:
    var marker_size: float = 3.0
    var marker_spacing: float = 5.0
    var max_markers: int = 4

    var tile_origin := Vector2(tile_x * region_tile_size, tile_y * region_tile_size)
    var start_position := tile_origin + Vector2(4, region_tile_size - 5)

    var marker_count: int = mini(resources.size(), max_markers)

    for i in range(marker_count):
        var resource: Variant = resources[i]

        if typeof(resource) != TYPE_DICTIONARY:
            continue

        var resource_dict: Dictionary = resource
        var resource_id: String = str(resource_dict.get("id", "unknown"))
        var marker_color: Color = get_resource_marker_color(resource_id)
        var marker_position := start_position + Vector2(i * marker_spacing, 0)

        draw_plus_marker(
            canvas,
            marker_position,
            marker_size,
            marker_color
        )


func draw_plus_marker(
    canvas: CanvasItem,
    position: Vector2,
    size: float,
    color: Color
) -> void:
    canvas.draw_line(
        Vector2(position.x - size, position.y),
        Vector2(position.x + size, position.y),
        color,
        1.5
    )

    canvas.draw_line(
        Vector2(position.x, position.y - size),
        Vector2(position.x, position.y + size),
        color,
        1.5
    )


func draw_campfire_radius_markers(
    canvas: CanvasItem,
    building_manager: RegionBuildingManager,
    region_tile_size: int
) -> void:
    var manager_buildings: Array = building_manager.get_buildings()

    for building_index in range(manager_buildings.size()):
        var building_variant: Variant = manager_buildings[building_index]

        if typeof(building_variant) != TYPE_DICTIONARY:
            continue

        var building_data: Dictionary = building_variant
        var building_id: String = str(building_data.get("id", ""))

        if building_id != BUILDING_CAMPFIRE:
            continue

        draw_campfire_radius_marker(
            canvas,
            building_data,
            region_tile_size
        )


func draw_campfire_radius_marker(
    canvas: CanvasItem,
    building_data: Dictionary,
    region_tile_size: int
) -> void:
    var tile_x: int = int(building_data.get("x", 0))
    var tile_y: int = int(building_data.get("y", 0))
    var width: int = int(building_data.get("width", 2))
    var height: int = int(building_data.get("height", 2))
    var radius: int = int(building_data.get("campfire_radius", RegionBuildingData.CAMPFIRE_BUILD_RADIUS))

    var center_tile := Vector2(
        float(tile_x) + float(width) / 2.0,
        float(tile_y) + float(height) / 2.0
    )

    var center_world := Vector2(
        center_tile.x * region_tile_size,
        center_tile.y * region_tile_size
    )

    var radius_pixels: float = float(radius * region_tile_size)

    canvas.draw_circle(
        center_world,
        radius_pixels,
        Color(1.0, 0.55, 0.12, 0.12)
    )

    canvas.draw_circle(
        center_world,
        radius_pixels,
        Color(1.0, 0.65, 0.20, 0.85),
        false,
        2.0
    )


func draw_buildings(
    canvas: CanvasItem,
    building_manager: RegionBuildingManager,
    region_tile_size: int
) -> void:
    var manager_buildings: Array = building_manager.get_buildings()

    for building_index in range(manager_buildings.size()):
        var building_variant: Variant = manager_buildings[building_index]

        if typeof(building_variant) != TYPE_DICTIONARY:
            continue

        var building_data: Dictionary = building_variant
        var building_id: String = str(building_data.get("id", "unknown"))

        match building_id:
            BUILDING_CAMPFIRE:
                draw_campfire_building(
                    canvas,
                    building_data,
                    region_tile_size
                )
            BUILDING_STORAGE_AREA:
                draw_storage_area_building(
                    canvas,
                    building_data,
                    region_tile_size
                )
            BUILDING_SHELTER:
                draw_shelter_building(
                    canvas,
                    building_data,
                    region_tile_size
                )
            BUILDING_CHIEFTAINS_SHELTER:
                draw_chieftains_shelter_building(
                    canvas,
                    building_data,
                    region_tile_size
                )
            _:
                draw_generic_building(
                    canvas,
                    building_data,
                    region_tile_size
                )


func draw_campfire_building(
    canvas: CanvasItem,
    building_data: Dictionary,
    region_tile_size: int
) -> void:
    var tile_x: int = int(building_data.get("x", 0))
    var tile_y: int = int(building_data.get("y", 0))
    var width: int = int(building_data.get("width", 2))
    var height: int = int(building_data.get("height", 2))

    var building_position := Vector2(tile_x * region_tile_size, tile_y * region_tile_size)
    var building_size := Vector2(width * region_tile_size, height * region_tile_size)
    var building_rect := Rect2(building_position, building_size)

    canvas.draw_rect(building_rect, Color(0.50, 0.22, 0.08, 0.95), true)
    canvas.draw_rect(building_rect, Color(1.0, 0.55, 0.12, 1.0), false, 2.0)

    var center := building_position + building_size / 2.0

    canvas.draw_circle(center, 6.0, Color(1.0, 0.42, 0.05, 1.0))
    canvas.draw_circle(center, 3.0, Color(1.0, 0.9, 0.2, 1.0))


func draw_shelter_building(
    canvas: CanvasItem,
    building_data: Dictionary,
    region_tile_size: int
) -> void:
    var tile_x: int = int(building_data.get("x", 0))
    var tile_y: int = int(building_data.get("y", 0))
    var width: int = int(building_data.get("width", 3))
    var height: int = int(building_data.get("height", 2))

    var building_position := Vector2(tile_x * region_tile_size, tile_y * region_tile_size)
    var building_size := Vector2(width * region_tile_size, height * region_tile_size)
    var building_rect := Rect2(building_position, building_size)

    canvas.draw_rect(building_rect, Color(0.34, 0.22, 0.11, 0.95), true)
    canvas.draw_rect(building_rect, Color(0.82, 0.66, 0.42, 1.0), false, 2.0)

    var roof_peak := building_position + Vector2(building_size.x / 2.0, 4.0)
    var roof_left := building_position + Vector2(4.0, building_size.y - 4.0)
    var roof_right := building_position + Vector2(building_size.x - 4.0, building_size.y - 4.0)

    canvas.draw_line(roof_left, roof_peak, Color(0.90, 0.78, 0.55, 1.0), 2.0)
    canvas.draw_line(roof_peak, roof_right, Color(0.90, 0.78, 0.55, 1.0), 2.0)


func draw_chieftains_shelter_building(
    canvas: CanvasItem,
    building_data: Dictionary,
    region_tile_size: int
) -> void:
    var tile_x: int = int(building_data.get("x", 0))
    var tile_y: int = int(building_data.get("y", 0))
    var width: int = int(building_data.get("width", 4))
    var height: int = int(building_data.get("height", 3))

    var building_position := Vector2(tile_x * region_tile_size, tile_y * region_tile_size)
    var building_size := Vector2(width * region_tile_size, height * region_tile_size)
    var building_rect := Rect2(building_position, building_size)

    canvas.draw_rect(building_rect, Color(0.30, 0.17, 0.08, 0.96), true)
    canvas.draw_rect(building_rect, Color(1.0, 0.82, 0.32, 1.0), false, 2.5)

    var roof_peak := building_position + Vector2(building_size.x / 2.0, 3.0)
    var roof_left := building_position + Vector2(4.0, building_size.y - 5.0)
    var roof_right := building_position + Vector2(building_size.x - 4.0, building_size.y - 5.0)

    canvas.draw_line(roof_left, roof_peak, Color(1.0, 0.90, 0.55, 1.0), 2.5)
    canvas.draw_line(roof_peak, roof_right, Color(1.0, 0.90, 0.55, 1.0), 2.5)

    var banner_top := building_position + Vector2(building_size.x - 8.0, 6.0)
    var banner_bottom := banner_top + Vector2(0.0, 18.0)

    canvas.draw_line(
        banner_top,
        banner_bottom,
        Color(0.95, 0.85, 0.45, 1.0),
        2.0
    )

    canvas.draw_rect(
        Rect2(banner_top + Vector2(0.0, 1.0), Vector2(8.0, 6.0)),
        Color(0.65, 0.10, 0.08, 1.0),
        true
    )


func draw_storage_area_building(
    canvas: CanvasItem,
    building_data: Dictionary,
    region_tile_size: int
) -> void:
    var tile_x: int = int(building_data.get("x", 0))
    var tile_y: int = int(building_data.get("y", 0))
    var width: int = int(building_data.get("width", 2))
    var height: int = int(building_data.get("height", 2))
    var storage_resource: String = str(building_data.get("storage_resource", ""))

    var building_position := Vector2(tile_x * region_tile_size, tile_y * region_tile_size)
    var building_size := Vector2(width * region_tile_size, height * region_tile_size)
    var building_rect := Rect2(building_position, building_size)

    canvas.draw_rect(building_rect, Color(0.24, 0.18, 0.10, 0.95), true)
    canvas.draw_rect(building_rect, Color(0.95, 0.82, 0.45, 1.0), false, 2.0)

    var center := building_position + building_size / 2.0
    var icon_rect := Rect2(center - Vector2(7, 6), Vector2(14, 12))

    canvas.draw_rect(icon_rect, Color(0.58, 0.42, 0.20, 1.0), true)
    canvas.draw_rect(icon_rect, Color(0.95, 0.85, 0.60, 1.0), false, 1.5)

    var label: String = "?"

    if storage_resource != "":
        label = get_short_resource_label(storage_resource)

    canvas.draw_string(
        ThemeDB.fallback_font,
        building_position + Vector2(3, 12),
        label,
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        12,
        Color(1.0, 1.0, 1.0, 1.0)
    )


func draw_generic_building(
    canvas: CanvasItem,
    building_data: Dictionary,
    region_tile_size: int
) -> void:
    var tile_x: int = int(building_data.get("x", 0))
    var tile_y: int = int(building_data.get("y", 0))
    var width: int = int(building_data.get("width", 1))
    var height: int = int(building_data.get("height", 1))

    var building_position := Vector2(tile_x * region_tile_size, tile_y * region_tile_size)
    var building_size := Vector2(width * region_tile_size, height * region_tile_size)
    var building_rect := Rect2(building_position, building_size)

    canvas.draw_rect(building_rect, Color(0.35, 0.22, 0.12, 0.90), true)
    canvas.draw_rect(building_rect, Color(0.85, 0.70, 0.45, 1.0), false, 2.0)


func draw_wild_animals(
    canvas: CanvasItem,
    wild_animals: Array,
    region_tile_size: int
) -> void:
    for animal_index in range(wild_animals.size()):
        var animal_variant: Variant = wild_animals[animal_index]

        if typeof(animal_variant) != TYPE_DICTIONARY:
            continue

        var animal_data: Dictionary = animal_variant

        if not bool(animal_data.get(RegionWildAnimalManager.KEY_ACTIVE, true)):
            continue

        draw_wild_animal(
            canvas,
            animal_data,
            region_tile_size
        )


func draw_wild_animal(
    canvas: CanvasItem,
    animal_data: Dictionary,
    region_tile_size: int
) -> void:
    var tile: Vector2i = animal_data.get(
        RegionWildAnimalManager.KEY_TILE,
        Vector2i(-1, -1)
    )

    if tile.x < 0 or tile.y < 0:
        return

    var center := Vector2(
        tile.x * region_tile_size + region_tile_size / 2.0,
        tile.y * region_tile_size + region_tile_size / 2.0
    )

    var dangerous: bool = bool(animal_data.get(RegionWildAnimalManager.KEY_DANGEROUS, false))
    var radius: float = StoneAgeTuning.WILD_ANIMAL_NORMAL_ICON_RADIUS
    var fill_color := Color(1.0, 0.88, 0.16, 1.0)
    var outline_color := Color(0.18, 0.12, 0.02, 1.0)

    if dangerous:
        radius = StoneAgeTuning.WILD_ANIMAL_DANGEROUS_ICON_RADIUS
        fill_color = Color(1.0, 0.12, 0.08, 1.0)
        outline_color = Color(0.18, 0.02, 0.02, 1.0)

    draw_star_marker(
        canvas,
        center,
        radius,
        fill_color,
        outline_color
    )


func draw_star_marker(
    canvas: CanvasItem,
    center: Vector2,
    radius: float,
    fill_color: Color,
    outline_color: Color
) -> void:
    var point_count: int = max(5, StoneAgeTuning.WILD_ANIMAL_ICON_POINTS)
    var inner_radius: float = radius * 0.45
    var points: PackedVector2Array = PackedVector2Array()

    for point_index in range(point_count * 2):
        var use_outer_radius: bool = point_index % 2 == 0
        var current_radius: float = inner_radius

        if use_outer_radius:
            current_radius = radius

        var angle: float = -PI / 2.0 + float(point_index) * PI / float(point_count)
        var point := center + Vector2(
            cos(angle) * current_radius,
            sin(angle) * current_radius
        )

        points.append(point)

    canvas.draw_colored_polygon(points, fill_color)

    for point_index in range(points.size()):
        var next_index: int = (point_index + 1) % points.size()

        canvas.draw_line(
            points[point_index],
            points[next_index],
            outline_color,
            1.25
        )

func draw_grave_markers(
    canvas: CanvasItem,
    villager_manager: VillagerManager,
    region_tile_size: int
) -> void:
    var manager_villagers: Array = villager_manager.get_villagers()

    for villager_index in range(manager_villagers.size()):
        var villager_variant: Variant = manager_villagers[villager_index]

        if typeof(villager_variant) != TYPE_DICTIONARY:
            continue

        var villager_data: Dictionary = villager_variant

        if str(villager_data.get("health_state", VillagerManager.HEALTH_STATE_HEALTHY)) != VillagerManager.HEALTH_STATE_DEAD:
            continue

        var death_tile: Vector2i = villager_data.get("death_tile", Vector2i(-1, -1))

        if death_tile.x < 0 or death_tile.y < 0:
            continue

        draw_grave_marker(
            canvas,
            death_tile,
            region_tile_size
        )


func draw_grave_marker(
    canvas: CanvasItem,
    death_tile: Vector2i,
    region_tile_size: int
) -> void:
    var center := Vector2(
        death_tile.x * region_tile_size + region_tile_size / 2.0,
        death_tile.y * region_tile_size + region_tile_size / 2.0
    )

    var outline_color := Color(0.08, 0.08, 0.08, 1.0)
    var grave_color := Color(0.86, 0.86, 0.82, 1.0)

    canvas.draw_line(
        center + Vector2(0.0, -6.0),
        center + Vector2(0.0, 6.0),
        outline_color,
        4.0
    )

    canvas.draw_line(
        center + Vector2(-4.0, -2.0),
        center + Vector2(4.0, -2.0),
        outline_color,
        4.0
    )

    canvas.draw_line(
        center + Vector2(0.0, -6.0),
        center + Vector2(0.0, 6.0),
        grave_color,
        2.0
    )

    canvas.draw_line(
        center + Vector2(-4.0, -2.0),
        center + Vector2(4.0, -2.0),
        grave_color,
        2.0
    )

func draw_villagers(
    canvas: CanvasItem,
    villager_manager: VillagerManager
) -> void:
    var manager_villagers: Array = villager_manager.get_villagers()

    for villager_index in range(manager_villagers.size()):
        var villager_variant: Variant = manager_villagers[villager_index]

        if typeof(villager_variant) != TYPE_DICTIONARY:
            continue

        var villager_data: Dictionary = villager_variant

        if str(villager_data.get("health_state", VillagerManager.HEALTH_STATE_HEALTHY)) == VillagerManager.HEALTH_STATE_DEAD:
            continue

        draw_villager(
            canvas,
            villager_data
        )


func draw_villager(
    canvas: CanvasItem,
    villager_data: Dictionary
) -> void:
    var center: Vector2 = villager_data.get("world_position", Vector2.ZERO)
    var state: String = str(villager_data.get("state", VillagerManager.VILLAGER_STATE_IDLE))
    var is_housed: bool = bool(villager_data.get("is_housed", false))

    var body_color := Color(0.85, 0.82, 0.72, 1.0)

    match state:
        VillagerManager.VILLAGER_STATE_MOVING:
            body_color = Color(0.75, 0.88, 0.95, 1.0)
        VillagerManager.VILLAGER_STATE_HARVESTING:
            body_color = Color(0.95, 0.82, 0.45, 1.0)
        _:
            body_color = Color(0.85, 0.82, 0.72, 1.0)

    if not is_housed:
        body_color = body_color.darkened(0.25)

    var outline_color := Color(0.15, 0.10, 0.08, 1.0)

    canvas.draw_circle(center + Vector2(0, 3), 4.2, body_color)
    canvas.draw_circle(center + Vector2(0, -3), 2.7, body_color)

    canvas.draw_line(
        center + Vector2(-4, 7),
        center + Vector2(4, 7),
        outline_color,
        2.0
    )

    canvas.draw_circle(center + Vector2(0, 3), 4.2, outline_color, false, 1.0)
    canvas.draw_circle(center + Vector2(0, -3), 2.7, outline_color, false, 1.0)


func draw_chieftain(
    canvas: CanvasItem,
    building_manager: RegionBuildingManager,
    region_tile_size: int
) -> void:
    if not building_manager.get_has_chieftain():
        return

    var chieftain_tile: Vector2i = building_manager.get_chieftain_tile()

    if chieftain_tile.x < 0 or chieftain_tile.y < 0:
        return

    var center := Vector2(
        chieftain_tile.x * region_tile_size + region_tile_size / 2.0,
        chieftain_tile.y * region_tile_size + region_tile_size / 2.0
    )

    draw_chieftain_piece(
        canvas,
        center
    )


func draw_chieftain_piece(
    canvas: CanvasItem,
    center: Vector2
) -> void:
    var body_color := Color(0.95, 0.86, 0.44, 1.0)
    var outline_color := Color(0.18, 0.11, 0.04, 1.0)
    var crown_color := Color(1.0, 0.95, 0.55, 1.0)

    canvas.draw_rect(
        Rect2(center + Vector2(-5.0, 5.0), Vector2(10.0, 3.0)),
        outline_color,
        true
    )

    canvas.draw_rect(
        Rect2(center + Vector2(-4.0, 1.0), Vector2(8.0, 6.0)),
        body_color,
        true
    )

    canvas.draw_rect(
        Rect2(center + Vector2(-4.0, 1.0), Vector2(8.0, 6.0)),
        outline_color,
        false,
        1.0
    )

    canvas.draw_circle(
        center + Vector2(0.0, -3.0),
        4.0,
        body_color
    )

    canvas.draw_circle(
        center + Vector2(0.0, -3.0),
        4.0,
        outline_color,
        false,
        1.0
    )

    var crown_base_left := center + Vector2(-5.0, -7.0)
    var crown_base_right := center + Vector2(5.0, -7.0)
    var crown_peak := center + Vector2(0.0, -12.0)

    canvas.draw_line(crown_base_left, crown_peak, crown_color, 2.0)
    canvas.draw_line(crown_peak, crown_base_right, crown_color, 2.0)
    canvas.draw_line(crown_base_left, crown_base_right, crown_color, 2.0)

    canvas.draw_line(
        center + Vector2(0.0, -15.0),
        center + Vector2(0.0, -10.0),
        crown_color,
        1.5
    )

    canvas.draw_line(
        center + Vector2(-2.5, -13.0),
        center + Vector2(2.5, -13.0),
        crown_color,
        1.5
    )


func draw_villager_assignment_markers(
    canvas: CanvasItem,
    villager_manager: VillagerManager,
    region_width: int,
    region_height: int,
    region_tile_size: int
) -> void:
    var manager_villagers: Array = villager_manager.get_villagers()

    for villager_index in range(manager_villagers.size()):
        var villager_variant: Variant = manager_villagers[villager_index]

        if typeof(villager_variant) != TYPE_DICTIONARY:
            continue

        var villager_data: Dictionary = villager_variant
        var assigned_center: Vector2i = villager_data.get(
            "assigned_harvest_center",
            VillagerManager.NO_ASSIGNED_AREA
        )

        var assigned_radius: int = int(villager_data.get("assigned_harvest_radius", 0))

        if not is_tile_in_bounds(
            assigned_center,
            region_width,
            region_height
        ):
            continue

        if assigned_radius <= 0:
            continue

        draw_harvest_area_marker(
            canvas,
            assigned_center,
            assigned_radius,
            region_tile_size,
            Color(0.95, 0.85, 0.25, 0.18),
            Color(0.95, 0.85, 0.25, 0.85)
        )


func draw_villager_drag_preview(
    canvas: CanvasItem,
    is_dragging_villager: bool,
    drag_assignment_tile: Vector2i,
    harvest_assign_radius: int,
    region_width: int,
    region_height: int,
    region_tile_size: int
) -> void:
    if not is_dragging_villager:
        return

    if not is_tile_in_bounds(
        drag_assignment_tile,
        region_width,
        region_height
    ):
        return

    draw_harvest_area_marker(
        canvas,
        drag_assignment_tile,
        harvest_assign_radius,
        region_tile_size,
        Color(0.25, 0.75, 1.0, 0.18),
        Color(0.25, 0.75, 1.0, 0.9)
    )


func draw_harvest_area_marker(
    canvas: CanvasItem,
    center_tile: Vector2i,
    radius: int,
    region_tile_size: int,
    fill_color: Color,
    outline_color: Color
) -> void:
    var center_world := Vector2(
        center_tile.x * region_tile_size + region_tile_size / 2.0,
        center_tile.y * region_tile_size + region_tile_size / 2.0
    )

    var radius_pixels: float = float(radius * region_tile_size)

    canvas.draw_circle(center_world, radius_pixels, fill_color)
    canvas.draw_circle(center_world, radius_pixels, outline_color, false, 2.0)


func draw_building_preview(
    canvas: CanvasItem,
    building_manager: RegionBuildingManager,
    hovered_tile: Vector2i,
    region_width: int,
    region_height: int,
    region_tile_size: int
) -> void:
    if not building_manager.is_in_build_mode():
        return

    if not is_tile_in_bounds(
        hovered_tile,
        region_width,
        region_height
    ):
        return

    var footprint: Vector2i = building_manager.get_current_building_footprint()
    var can_place := building_manager.can_place_current_building(hovered_tile)

    var preview_position := Vector2(
        hovered_tile.x * region_tile_size,
        hovered_tile.y * region_tile_size
    )

    var preview_size := Vector2(
        footprint.x * region_tile_size,
        footprint.y * region_tile_size
    )

    var preview_rect := Rect2(preview_position, preview_size)

    if can_place:
        canvas.draw_rect(preview_rect, Color(0.1, 0.9, 0.1, 0.28), true)
        canvas.draw_rect(preview_rect, Color(0.1, 1.0, 0.1, 0.95), false, 2.0)
    else:
        canvas.draw_rect(preview_rect, Color(0.9, 0.1, 0.1, 0.28), true)
        canvas.draw_rect(preview_rect, Color(1.0, 0.1, 0.1, 0.95), false, 2.0)


func draw_pause_overlay(
    canvas: CanvasItem,
    simulation_paused: bool
) -> void:
    if not simulation_paused:
        return

    var label_position := Vector2(16, 16)

    canvas.draw_rect(
        Rect2(label_position - Vector2(6, 4), Vector2(190, 26)),
        Color(0.0, 0.0, 0.0, 0.55),
        true
    )

    canvas.draw_string(
        ThemeDB.fallback_font,
        label_position + Vector2(0, 16),
        "PAUSED - assign orders",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        16,
        Color(1.0, 1.0, 1.0, 1.0)
    )


func draw_grid_lines(
    canvas: CanvasItem,
    region_width: int,
    region_height: int,
    region_tile_size: int
) -> void:
    var grid_color := Color(0, 0, 0, 0.25)

    for x in range(region_width + 1):
        var start_pos := Vector2(x * region_tile_size, 0)
        var end_pos := Vector2(x * region_tile_size, region_height * region_tile_size)

        canvas.draw_line(
            start_pos,
            end_pos,
            grid_color,
            1.0
        )

    for y in range(region_height + 1):
        var start_pos := Vector2(0, y * region_tile_size)
        var end_pos := Vector2(region_width * region_tile_size, y * region_tile_size)

        canvas.draw_line(
            start_pos,
            end_pos,
            grid_color,
            1.0
        )


func draw_selected_tile(
    canvas: CanvasItem,
    selected_tile: Vector2i,
    region_width: int,
    region_height: int,
    region_tile_size: int
) -> void:
    if not is_tile_in_bounds(
        selected_tile,
        region_width,
        region_height
    ):
        return

    var tile_position := Vector2(
        selected_tile.x * region_tile_size,
        selected_tile.y * region_tile_size
    )

    var tile_rect := Rect2(
        tile_position,
        Vector2(region_tile_size, region_tile_size)
    )

    canvas.draw_rect(
        tile_rect,
        Color(1.0, 0.9, 0.1, 1.0),
        false,
        2.0
    )


func draw_hovered_tile(
    canvas: CanvasItem,
    hovered_tile: Vector2i,
    region_width: int,
    region_height: int,
    region_tile_size: int
) -> void:
    if not is_tile_in_bounds(
        hovered_tile,
        region_width,
        region_height
    ):
        return

    var tile_position := Vector2(
        hovered_tile.x * region_tile_size,
        hovered_tile.y * region_tile_size
    )

    var tile_rect := Rect2(
        tile_position,
        Vector2(region_tile_size, region_tile_size)
    )

    canvas.draw_rect(tile_rect, Color(1, 1, 1, 0.22), true)
    canvas.draw_rect(tile_rect, Color(1, 1, 1, 0.9), false, 2.0)


func get_short_resource_label(resource_name: String) -> String:
    match resource_name:
        "Wood":
            return "Wd"
        "Stone":
            return "St"
        "Fiber":
            return "Fb"
        "Flint":
            return "Fl"
        "Berries":
            return "Br"
        "Mushrooms":
            return "Mu"
        "Reeds":
            return "Rd"
        "Clay":
            return "Cl"
        "Fish":
            return "Fi"
        "Meat":
            return "Mt"
        "Hide":
            return "Hd"
        "Bone":
            return "Bn"
        "Feather":
            return "Ft"
        _:
            return resource_name.substr(0, min(2, resource_name.length()))


func get_resource_marker_color(resource_id: String) -> Color:
    match resource_id:
        RESOURCE_WOOD:
            return Color(0.45, 0.25, 0.08)
        RESOURCE_BERRIES:
            return Color(0.90, 0.05, 0.08)
        RESOURCE_MUSHROOMS:
            return Color(0.55, 0.20, 0.75)
        RESOURCE_STONE:
            return Color(0.70, 0.70, 0.70)
        RESOURCE_FLINT:
            return Color(0.12, 0.12, 0.12)
        RESOURCE_REEDS:
            return Color(0.72, 0.82, 0.24)
        RESOURCE_CLAY:
            return Color(0.78, 0.34, 0.12)
        RESOURCE_FISH:
            return Color(0.45, 0.85, 1.00)
        RESOURCE_FIBER:
            return Color(0.78, 1.00, 0.55)
        _:
            return Color(1.0, 1.0, 1.0)


func get_region_tile_color(tile_data: Dictionary) -> Color:
    match tile_data.get("terrain", REGION_TERRAIN_GRASS):
        REGION_TERRAIN_GRASS:
            return Color(0.30, 0.62, 0.24)
        REGION_TERRAIN_FOREST:
            return Color(0.08, 0.34, 0.10)
        REGION_TERRAIN_DIRT:
            return Color(0.42, 0.30, 0.16)
        REGION_TERRAIN_ROCK:
            return Color(0.42, 0.42, 0.42)
        REGION_TERRAIN_WATER:
            return Color(0.13, 0.38, 0.72)
        REGION_TERRAIN_MUD:
            return Color(0.20, 0.24, 0.12)
        REGION_TERRAIN_SHORE:
            return Color(0.80, 0.74, 0.50)
        REGION_TERRAIN_DESERT:
            return Color(0.72, 0.58, 0.27)
        REGION_TERRAIN_TUNDRA:
            return Color(0.50, 0.62, 0.58)
        _:
            return Color(1, 0, 1)


func is_tile_in_bounds(
    tile_position: Vector2i,
    region_width: int,
    region_height: int
) -> bool:
    return (
        tile_position.x >= 0
        and tile_position.y >= 0
        and tile_position.x < region_width
        and tile_position.y < region_height
    )
