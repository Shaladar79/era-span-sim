extends RefCounted
class_name RegionResearch

const RESEARCH_TICK_INTERVAL: float = 60.0

var research_points: int = 0
var research_timer: float = 0.0


func reset() -> void:
    research_points = 0
    research_timer = 0.0


func update(
    delta: float,
    building_manager: RegionBuildingManager
) -> void:
    research_timer += delta

    if research_timer < RESEARCH_TICK_INTERVAL:
        return

    research_timer -= RESEARCH_TICK_INTERVAL

    var research_per_minute: int = get_total_research_per_minute(building_manager)

    if research_per_minute <= 0:
        return

    add_research(research_per_minute)

    print(
        "Research gained: ",
        research_per_minute,
        ". Total Research: ",
        research_points
    )


func get_total_research_per_minute(building_manager: RegionBuildingManager) -> int:
    var total_research: int = 0
    var buildings: Array = building_manager.get_buildings()

    for building_index in range(buildings.size()):
        var building_variant: Variant = buildings[building_index]

        if typeof(building_variant) != TYPE_DICTIONARY:
            continue

        var building_data: Dictionary = building_variant
        var building_id: String = str(building_data.get("id", ""))

        if building_id != RegionBuildingData.BUILDING_THINKERS_SPOT:
            continue

        if not bool(building_data.get("active", true)):
            continue

        total_research += int(building_data.get(
            "research_per_minute",
            RegionBuildingData.THINKERS_SPOT_RESEARCH_PER_MINUTE
        ))

    return total_research


func add_research(amount: int) -> void:
    if amount <= 0:
        return

    research_points += amount


func spend_research(amount: int) -> bool:
    if amount <= 0:
        return true

    if research_points < amount:
        return false

    research_points -= amount
    return true


func get_research_points() -> int:
    return research_points


func set_research_points(amount: int) -> void:
    research_points = max(0, amount)


func print_research_status(building_manager: RegionBuildingManager) -> void:
    print("")
    print("Research:")
    print("Stored Research: " + str(research_points))
    print("Research per Minute: " + str(get_total_research_per_minute(building_manager)))
    print("")
