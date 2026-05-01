extends RefCounted
class_name StoneAgeProgression


static func update_building_trigger_unlocks(
    building_manager: RegionBuildingManager
) -> Array:
    var unlock_messages: Array = []

    _unlock_after_campfire_built(
        building_manager,
        unlock_messages
    )

    _unlock_after_three_shelters_built(
        building_manager,
        unlock_messages
    )

    _unlock_after_chieftains_shelter_built(
        building_manager,
        unlock_messages
    )

    return unlock_messages


static func _unlock_after_campfire_built(
    building_manager: RegionBuildingManager,
    unlock_messages: Array
) -> void:
    var campfire_count: int = building_manager.get_building_count_by_id(
        RegionBuildingData.BUILDING_CAMPFIRE
    )

    if campfire_count <= 0:
        return

    _unlock_building_if_needed(
        RegionBuildingData.BUILDING_SHELTER,
        "Shelter construction unlocked.",
        unlock_messages
    )

    _unlock_building_if_needed(
        RegionBuildingData.BUILDING_STORAGE_AREA,
        "Storage Area construction unlocked.",
        unlock_messages
    )


static func _unlock_after_three_shelters_built(
    building_manager: RegionBuildingManager,
    unlock_messages: Array
) -> void:
    var shelter_count: int = building_manager.get_building_count_by_id(
        RegionBuildingData.BUILDING_SHELTER
    )

    if shelter_count < RegionBuildingData.CHIEFTAINS_SHELTER_REQUIRED_SHELTERS:
        return

    _unlock_building_if_needed(
        RegionBuildingData.BUILDING_CHIEFTAINS_SHELTER,
        "Chieftain's Shelter unlocked.",
        unlock_messages
    )


static func _unlock_after_chieftains_shelter_built(
    building_manager: RegionBuildingManager,
    unlock_messages: Array
) -> void:
    var chieftains_shelter_count: int = building_manager.get_building_count_by_id(
        RegionBuildingData.BUILDING_CHIEFTAINS_SHELTER
    )

    if chieftains_shelter_count <= 0:
        return

    _unlock_building_if_needed(
        RegionBuildingData.BUILDING_MAKING_SPOT,
        "Making Spot unlocked.",
        unlock_messages
    )

    _unlock_building_if_needed(
        RegionBuildingData.BUILDING_THINKERS_SPOT,
        "Thinker's Spot unlocked.",
        unlock_messages
    )


static func _unlock_building_if_needed(
    building_id: String,
    message: String,
    unlock_messages: Array
) -> void:
    if building_id == "":
        return

    if RegionBuildingData.is_building_unlocked(building_id):
        return

    RegionBuildingData.unlock_building(building_id)

    if message != "":
        unlock_messages.append(message)
