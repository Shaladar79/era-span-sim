extends RefCounted
class_name StoneAgeTuning

const MAX_BELONGING_SLOTS: int = 2

const BASE_SKILL_START_MIN: int = 0
const BASE_SKILL_START_MAX: int = 3

const ROLE_SKILL_START_MIN: int = 2
const ROLE_SKILL_START_MAX: int = 4

const HUNTER_HEALTH_PER_LEVEL: int = 2
const WARRIOR_HEALTH_PER_LEVEL: int = 3

const HUNTER_BASE_ATTACK: int = 2
const HUNTER_BASE_DEFENSE: int = 1

const WARRIOR_BASE_ATTACK: int = 3
const WARRIOR_BASE_DEFENSE: int = 2

const THINKER_BASE_RESEARCH_PER_SECOND: float = 1.0
const THINKER_RESEARCH_BONUS_PER_THINKING_LEVEL: float = 0.05

const DEFAULT_ROLE_TOOL_SLOTS: int = 1
const DEFAULT_COMBAT_TOOL_SLOTS: int = 1
const DEFAULT_COMBAT_WEAPON_SLOTS: int = 1
const DEFAULT_COMBAT_ARMOR_SLOTS: int = 1

const CRAFTING_TIER_1: String = "stone_age_t1"
const CRAFTING_TIER_2: String = "stone_age_t2"
const CRAFTING_TIER_3: String = "stone_age_t3"

const DEFAULT_CRAFT_TIME: float = 10.0

const ITEM_FUNCTION_BASIC_TOOL: String = "basic_tool"
const ITEM_FUNCTION_TOOL_BONUS: String = "tool_bonus"
const ITEM_FUNCTION_WEAPON_STATS: String = "weapon_stats"
const ITEM_FUNCTION_ARMOR_STATS: String = "armor_stats"
const ITEM_FUNCTION_CONSUMABLE_EFFECT: String = "consumable_effect"
const ITEM_FUNCTION_BUILDING_COST_ITEM: String = "building_cost_item"
const ITEM_FUNCTION_CAMP_MOVE_REQUIREMENT: String = "camp_move_requirement"
const ITEM_FUNCTION_STORAGE_BELONGING: String = "storage_belonging"
const ITEM_FUNCTION_PREPARATION_TOOL: String = "preparation_tool"
const ITEM_FUNCTION_SPEED_BELONGING: String = "speed_belonging"
const ITEM_FUNCTION_ROLE_BELONGING: String = "role_belonging"

# Future unlock notes.
const HIDE_ARMOR_UNLOCK_NOTE: String = "Unlocked after Hunter Hut is researched, built, hunters are assigned, and hide is obtained from hunted wild animals."

const FUTURE_HEALER_HUT_NOTE: String = "Healer's Hut unlocks after Spiritual Leader's Hut. It creates the Healer role, uses Medicine skill, counts as shelter, and later supports building-slot upgrades like Herb Drying Rack."

const FUTURE_FISHING_HUT_NOTE: String = "Fishing Hut unlocks by research. It creates the Fisher role, uses Fishing skill, counts as shelter, and later supports tools like Fish Trap and Fishing Rod."
