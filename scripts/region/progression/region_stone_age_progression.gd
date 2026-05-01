extends RefCounted
class_name RegionStoneAgeProgression


static func update_building_trigger_unlocks(
    building_manager: RegionBuildingManager
) -> Array:
    return StoneAgeProgression.update_building_trigger_unlocks(
        building_manager
    )
