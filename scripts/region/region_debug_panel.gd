extends RefCounted
class_name RegionDebugPanel

const ACTION_MAX_RESOURCES: String = "max_resources"
const ACTION_ADD_ANIMAL_RESOURCES: String = "add_animal_resources"
const ACTION_ADD_RESEARCH_10: String = "add_research_10"
const ACTION_ADD_RESEARCH_50: String = "add_research_50"
const ACTION_ADD_RESEARCH_100: String = "add_research_100"
const ACTION_ADD_TEST_ITEMS: String = "add_test_items"
const ACTION_ADD_VILLAGER_1: String = "add_villager_1"
const ACTION_ADD_VILLAGER_5: String = "add_villager_5"
const ACTION_ADD_MAMMOTH_KILLS_5: String = "add_mammoth_kills_5"
const ACTION_ADD_BEAR_KILLS_6: String = "add_bear_kills_6"
const ACTION_SHOW_ANIMAL_KILL_COUNTS: String = "show_animal_kill_counts"
const ACTION_CLOSE: String = "close"

const DEBUG_PANEL_TITLE: String = "Debug Tools"

const TEST_ANIMAL_RESOURCE_AMOUNT: int = 25

const TEST_RESOURCE_NAMES: Array[String] = [
    "Wood",
    "Stone",
    "Fiber",
    "Flint",
    "Berries",
    "Mushrooms",
    "Reeds",
    "Clay",
    "Fish",
    "Meat",
    "Hide",
    "Bone",
    "Feather"
]

const TEST_ANIMAL_RESOURCE_NAMES: Array[String] = [
    "Meat",
    "Hide",
    "Bone",
    "Feather"
]


static func get_actions() -> Array:
    return [
        {
            "id": ACTION_MAX_RESOURCES,
            "label": "Max Resources"
        },
        {
            "id": ACTION_ADD_ANIMAL_RESOURCES,
            "label": "+Animal Resources"
        },
        {
            "id": ACTION_ADD_RESEARCH_10,
            "label": "+10 Research"
        },
        {
            "id": ACTION_ADD_RESEARCH_50,
            "label": "+50 Research"
        },
        {
            "id": ACTION_ADD_RESEARCH_100,
            "label": "+100 Research"
        },
        {
            "id": ACTION_ADD_TEST_ITEMS,
            "label": "Add Test Items"
        },
        {
            "id": ACTION_ADD_VILLAGER_1,
            "label": "+1 Villager"
        },
        {
            "id": ACTION_ADD_VILLAGER_5,
            "label": "+5 Villagers"
        },
                {
            "id": ACTION_ADD_MAMMOTH_KILLS_5,
            "label": "+5 Mammoth Kills"
        },
        {
            "id": ACTION_ADD_BEAR_KILLS_6,
            "label": "+6 Bear Kills"
        },
        {
            "id": ACTION_SHOW_ANIMAL_KILL_COUNTS,
            "label": "Show Kill Counts"
        },
        {
            "id": ACTION_CLOSE,
            "label": "Close"
        }
    ]


static func get_action_id_at_index(action_index: int) -> String:
    var actions: Array = get_actions()

    if action_index < 0:
        return ""

    if action_index >= actions.size():
        return ""

    var action_data: Dictionary = actions[action_index]

    return str(action_data.get("id", ""))


static func get_action_label_at_index(action_index: int) -> String:
    var actions: Array = get_actions()

    if action_index < 0:
        return ""

    if action_index >= actions.size():
        return ""

    var action_data: Dictionary = actions[action_index]

    return str(action_data.get("label", ""))


static func get_research_amount_for_action(action_id: String) -> int:
    match action_id:
        ACTION_ADD_RESEARCH_10:
            return 10
        ACTION_ADD_RESEARCH_50:
            return 50
        ACTION_ADD_RESEARCH_100:
            return 100
        _:
            return 0


static func get_villager_amount_for_action(action_id: String) -> int:
    match action_id:
        ACTION_ADD_VILLAGER_1:
            return 1
        ACTION_ADD_VILLAGER_5:
            return 5
        _:
            return 0


static func is_research_action(action_id: String) -> bool:
    return get_research_amount_for_action(action_id) > 0


static func is_villager_action(action_id: String) -> bool:
    return get_villager_amount_for_action(action_id) > 0


static func is_animal_resource_action(action_id: String) -> bool:
    return action_id == ACTION_ADD_ANIMAL_RESOURCES
    
static func is_animal_kill_debug_action(action_id: String) -> bool:
    return (
        action_id == ACTION_ADD_MAMMOTH_KILLS_5
        or action_id == ACTION_ADD_BEAR_KILLS_6
    )


static func get_animal_kill_debug_animal_id(action_id: String) -> String:
    match action_id:
        ACTION_ADD_MAMMOTH_KILLS_5:
            return RegionWildAnimalData.ANIMAL_MAMMOTH

        ACTION_ADD_BEAR_KILLS_6:
            return RegionWildAnimalData.ANIMAL_BROWN_BEAR

        _:
            return ""


static func get_animal_kill_debug_amount(action_id: String) -> int:
    match action_id:
        ACTION_ADD_MAMMOTH_KILLS_5:
            return 5

        ACTION_ADD_BEAR_KILLS_6:
            return 6

        _:
            return 0


static func is_show_animal_kill_counts_action(action_id: String) -> bool:
    return action_id == ACTION_SHOW_ANIMAL_KILL_COUNTS


static func get_test_item_outputs() -> Array:
    return [
        {
            "type": RegionRecipeData.OUTPUT_TYPE_ITEM,
            "id": RegionRecipeData.ITEM_POINTED_STICK,
            "name": "Pointed Stick",
            "amount": 1,
            "category": RegionItemInventory.CATEGORY_WEAPON,
            "description": "Debug test item."
        },
        {
            "type": RegionRecipeData.OUTPUT_TYPE_ITEM,
            "id": RegionRecipeData.ITEM_SIMPLE_HAND_AXE,
            "name": "Simple Hand Axe",
            "amount": 1,
            "category": RegionItemInventory.CATEGORY_TOOL,
            "description": "Debug test item."
        },
        {
            "type": RegionRecipeData.OUTPUT_TYPE_ITEM,
            "id": RegionRecipeData.ITEM_SHARP_STONE_KNIFE,
            "name": "Sharp Stone Knife",
            "amount": 1,
            "category": RegionItemInventory.CATEGORY_TOOL,
            "description": "Debug test item."
        },
        {
            "type": RegionRecipeData.OUTPUT_TYPE_ITEM,
            "id": RegionRecipeData.ITEM_CRUDE_CONTAINER,
            "name": "Crude Container",
            "amount": 1,
            "category": RegionItemInventory.CATEGORY_KIT,
            "description": "Debug test item."
        },
        {
            "type": RegionRecipeData.OUTPUT_TYPE_ITEM,
            "id": RegionRecipeData.ITEM_SLING,
            "name": "Sling",
            "amount": 1,
            "category": RegionItemInventory.CATEGORY_WEAPON,
            "description": "Debug test item."
        },
        {
            "type": RegionRecipeData.OUTPUT_TYPE_ITEM,
            "id": RegionRecipeData.ITEM_HERBAL_POULTICE,
            "name": "Herbal Poultice",
            "amount": 1,
            "category": RegionItemInventory.CATEGORY_MEDICINE,
            "description": "Debug test item."
        },

        # Stone Age T2 test items.
        {
            "type": RegionRecipeData.OUTPUT_TYPE_ITEM,
            "id": RegionRecipeData.ITEM_THROWING_SPEAR,
            "name": "Throwing Spear",
            "amount": 1,
            "category": RegionItemInventory.CATEGORY_WEAPON,
            "description": "Debug test item."
        },
        {
            "type": RegionRecipeData.OUTPUT_TYPE_ITEM,
            "id": RegionRecipeData.ITEM_STONE_TIPPED_SPEAR,
            "name": "Stone-Tipped Spear",
            "amount": 1,
            "category": RegionItemInventory.CATEGORY_WEAPON,
            "description": "Debug test item."
        },
        {
            "type": RegionRecipeData.OUTPUT_TYPE_ITEM,
            "id": RegionRecipeData.ITEM_STONE_CLUB,
            "name": "Stone Club",
            "amount": 1,
            "category": RegionItemInventory.CATEGORY_WEAPON,
            "description": "Debug test item."
        },
        {
            "type": RegionRecipeData.OUTPUT_TYPE_ITEM,
            "id": RegionRecipeData.ITEM_STONE_SCRAPER,
            "name": "Stone Scraper",
            "amount": 1,
            "category": RegionItemInventory.CATEGORY_TOOL,
            "description": "Debug test item."
        },
        {
            "type": RegionRecipeData.OUTPUT_TYPE_ITEM,
            "id": RegionRecipeData.ITEM_WORKED_HAND_AXE,
            "name": "Worked Hand Axe",
            "amount": 1,
            "category": RegionItemInventory.CATEGORY_TOOL,
            "description": "Debug test item."
        },

        # Stone Age T3 test items.
        {
            "type": RegionRecipeData.OUTPUT_TYPE_ITEM,
            "id": RegionRecipeData.ITEM_DRAG_SLED,
            "name": "Drag Sled",
            "amount": 1,
            "category": RegionItemInventory.CATEGORY_KIT,
            "description": "Debug test item."
        },
        {
            "type": RegionRecipeData.OUTPUT_TYPE_ITEM,
            "id": RegionRecipeData.ITEM_TENT_KIT,
            "name": "Tent Kit",
            "amount": 1,
            "category": RegionItemInventory.CATEGORY_KIT,
            "description": "Debug test item."
        },
        {
            "type": RegionRecipeData.OUTPUT_TYPE_ITEM,
            "id": RegionRecipeData.ITEM_ADVANCED_SLING,
            "name": "Advanced Sling",
            "amount": 1,
            "category": RegionItemInventory.CATEGORY_WEAPON,
            "description": "Debug test item."
        },
        {
            "type": RegionRecipeData.OUTPUT_TYPE_ITEM,
            "id": RegionRecipeData.ITEM_FLINT_TIPPED_HUNTING_SPEAR,
            "name": "Flint-Tipped Hunting Spear",
            "amount": 1,
            "category": RegionItemInventory.CATEGORY_WEAPON,
            "description": "Debug test item."
        },
        {
            "type": RegionRecipeData.OUTPUT_TYPE_ITEM,
            "id": RegionRecipeData.ITEM_FLINT_EDGED_HAND_AXE,
            "name": "Flint-Edged Hand Axe",
            "amount": 1,
            "category": RegionItemInventory.CATEGORY_TOOL,
            "description": "Debug test item."
        },
        {
            "type": RegionRecipeData.OUTPUT_TYPE_ITEM,
            "id": RegionRecipeData.ITEM_FLINT_EDGED_WOODSMAN_AXE,
            "name": "Flint-Edged Woodsman Axe",
            "amount": 1,
            "category": RegionItemInventory.CATEGORY_TOOL,
            "description": "Debug test item."
        },
        {
            "type": RegionRecipeData.OUTPUT_TYPE_ITEM,
            "id": RegionRecipeData.ITEM_FLINT_TIPPED_MINING_PICK,
            "name": "Flint-Tipped Mining Pick",
            "amount": 1,
            "category": RegionItemInventory.CATEGORY_TOOL,
            "description": "Debug test item."
        }
    ]


static func max_resources(inventory: RegionInventory) -> int:
    var changed_count: int = 0

    for resource_index in range(TEST_RESOURCE_NAMES.size()):
        var resource_name: String = str(TEST_RESOURCE_NAMES[resource_index])
        var resource_cap: int = inventory.get_resource_cap(resource_name)

        inventory.set_amount(resource_name, resource_cap)
        changed_count += 1

    return changed_count


static func add_animal_resources(inventory: RegionInventory) -> int:
    var changed_count: int = 0

    for resource_index in range(TEST_ANIMAL_RESOURCE_NAMES.size()):
        var resource_name: String = str(TEST_ANIMAL_RESOURCE_NAMES[resource_index])
        var accepted_amount: int = inventory.add_resource(
            resource_name,
            TEST_ANIMAL_RESOURCE_AMOUNT
        )

        if accepted_amount > 0:
            changed_count += 1

    return changed_count


static func add_test_items(item_inventory: RegionItemInventory) -> int:
    var outputs: Array = get_test_item_outputs()

    item_inventory.add_items_from_outputs(outputs)

    return outputs.size()
