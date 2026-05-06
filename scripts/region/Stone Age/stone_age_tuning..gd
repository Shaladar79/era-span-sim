extends RefCounted
class_name StoneAgeTuning

const MAX_BELONGING_SLOTS: int = 2

const ROLE_STARTING_SKILL_MIN: int = 1
const ROLE_STARTING_SKILL_MAX: int = 4

# Weighted toward 2.
const ROLE_STARTING_SKILL_LEVEL_1_WEIGHT: int = 20
const ROLE_STARTING_SKILL_LEVEL_2_WEIGHT: int = 50
const ROLE_STARTING_SKILL_LEVEL_3_WEIGHT: int = 20
const ROLE_STARTING_SKILL_LEVEL_4_WEIGHT: int = 10

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
const THINKER_RESEARCH_BONUS_PER_THINKING_LEVEL: float = 0.1

const DEFAULT_ROLE_TOOL_SLOTS: int = 1
const DEFAULT_COMBAT_TOOL_SLOTS: int = 1
const DEFAULT_COMBAT_WEAPON_SLOTS: int = 1
const DEFAULT_COMBAT_ARMOR_SLOTS: int = 1

const GATHERERS_HUT_HARVEST_RADIUS: int = 6

const BASE_CRAFTING_DURATION: float = 10.0
const CRAFTING_SKILL_DURATION_REDUCTION_PER_LEVEL: float = 0.05
const MIN_CRAFTING_DURATION: float = 3.0

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

# Wild Animals / Hunting tuning.
const RESOURCE_MEAT: String = "Meat"
const RESOURCE_HIDE: String = "Hide"
const RESOURCE_BONE: String = "Bone"
const RESOURCE_FEATHER: String = "Feather"

const WILD_ANIMAL_ICON_POINTS: int = 5
const WILD_ANIMAL_NORMAL_ICON_RADIUS: float = 5.0
const WILD_ANIMAL_DANGEROUS_ICON_RADIUS: float = 6.0

const WILD_ANIMAL_REGION_SPAWN_MIN: int = 18
const WILD_ANIMAL_REGION_SPAWN_MAX: int = 34

const WILD_ANIMAL_DANGEROUS_SPAWN_CHANCE: float = 0.22
const WILD_ANIMAL_MAX_DANGEROUS_SPAWNS: int = 8

const WILD_ANIMAL_MIN_DISTANCE_FROM_MAP_EDGE: int = 3
const WILD_ANIMAL_MIN_DISTANCE_BETWEEN_ANIMALS: int = 4
const WILD_ANIMAL_SPAWN_ATTEMPTS_PER_ANIMAL: int = 40

const WILD_ANIMAL_CAMPFIRE_AVOIDANCE_RADIUS_BONUS: int = 2
const WILD_ANIMAL_RELOCATION_ATTEMPTS: int = 60

const WILD_ANIMAL_WANDER_INTERVAL_MIN: float = 2.5
const WILD_ANIMAL_WANDER_INTERVAL_MAX: float = 3.0
const WILD_ANIMAL_DANGEROUS_WANDER_INTERVAL_MIN: float = 3.5
const WILD_ANIMAL_DANGEROUS_WANDER_INTERVAL_MAX: float = 5.0

const WILD_ANIMAL_WANDER_CHANCE: float = 0.80
const WILD_ANIMAL_DANGEROUS_WANDER_CHANCE: float = 0.75
const WILD_ANIMAL_WANDER_ATTEMPTS: int = 8

const NORMAL_ANIMAL_DEFAULT_REQUIRED_HUNTERS: int = 1
const LARGE_NORMAL_ANIMAL_DEFAULT_REQUIRED_HUNTERS: int = 2
const DANGEROUS_ANIMAL_DEFAULT_REQUIRED_HUNTERS: int = 2
const LARGE_DANGEROUS_ANIMAL_DEFAULT_REQUIRED_HUNTERS: int = 3
const EXTREME_DANGEROUS_ANIMAL_DEFAULT_REQUIRED_HUNTERS: int = 5

const NORMAL_ANIMAL_BASE_INJURY_CHANCE: float = 0.0
const NORMAL_ANIMAL_BASE_DEATH_CHANCE: float = 0.0

const DANGEROUS_ANIMAL_BASE_INJURY_CHANCE: float = 0.25
const DANGEROUS_ANIMAL_BASE_DEATH_CHANCE: float = 0.03

const HIGH_DANGER_ANIMAL_BASE_INJURY_CHANCE: float = 0.40
const HIGH_DANGER_ANIMAL_BASE_DEATH_CHANCE: float = 0.08

const EXTREME_DANGER_ANIMAL_BASE_INJURY_CHANCE: float = 0.60
const EXTREME_DANGER_ANIMAL_BASE_DEATH_CHANCE: float = 0.15

const SMALL_ANIMAL_MEAT_YIELD: int = 2
const SMALL_ANIMAL_HIDE_YIELD: int = 1
const SMALL_ANIMAL_BONE_YIELD: int = 1
const SMALL_BIRD_FEATHER_YIELD: int = 3

const MEDIUM_ANIMAL_MEAT_YIELD: int = 6
const MEDIUM_ANIMAL_HIDE_YIELD: int = 2
const MEDIUM_ANIMAL_BONE_YIELD: int = 2

const LARGE_ANIMAL_MEAT_YIELD: int = 12
const LARGE_ANIMAL_HIDE_YIELD: int = 4
const LARGE_ANIMAL_BONE_YIELD: int = 4

const HUGE_ANIMAL_MEAT_YIELD: int = 30
const HUGE_ANIMAL_HIDE_YIELD: int = 10
const HUGE_ANIMAL_BONE_YIELD: int = 12

const PREDATOR_MEAT_YIELD: int = 5
const PREDATOR_HIDE_YIELD: int = 3
const PREDATOR_BONE_YIELD: int = 3

const LARGE_PREDATOR_MEAT_YIELD: int = 10
const LARGE_PREDATOR_HIDE_YIELD: int = 6
const LARGE_PREDATOR_BONE_YIELD: int = 6

const HUGE_PREDATOR_MEAT_YIELD: int = 14
const HUGE_PREDATOR_HIDE_YIELD: int = 8
const HUGE_PREDATOR_BONE_YIELD: int = 8

# Future unlock notes.
const HIDE_ARMOR_UNLOCK_NOTE: String = "Unlocked after Hunter Hut is researched, built, hunters are assigned, and hide is obtained from hunted wild animals."

const FUTURE_HEALER_HUT_NOTE: String = "Healer's Hut unlocks after Spiritual Leader's Hut. It creates the Healer role, uses Medicine skill, counts as shelter, and later supports building-slot upgrades like Herb Drying Rack."

const FUTURE_FISHING_HUT_NOTE: String = "Fishing Hut unlocks by research. It creates the Fisher role, uses Fishing skill, counts as shelter, and later supports tools like Fish Trap and Fishing Rod."
