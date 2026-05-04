extends RefCounted
class_name StoneAgeProgression


static func update_building_trigger_unlocks(
    _building_manager: RegionBuildingManager
) -> Array:
    # Building-trigger unlocks are disabled for now.
    # Stone Age progression now runs through StoneAgeResearchData / RegionResearch.
    return []
