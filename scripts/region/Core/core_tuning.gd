extends RefCounted
class_name CoreTuning

const BASE_VILLAGER_HEALTH: int = 5

const HUNGER_FULL: int = 100
const HUNGER_EAT_THRESHOLD: int = 50
const HUNGER_LOSS_PER_DAY: int = 25
const FOOD_RESTORE_AMOUNT: int = 35
const STARVATION_HUNGER_THRESHOLD: int = 0
const STARVATION_HEALTH_LOSS_PER_DAY: int = 1
const STARVATION_SICKNESS_CHANCE_PER_DAY: float = 0.20

const BASE_SPEED: int = 100
const MIN_BASE_SPEED: int = 90
const MAX_BASE_SPEED: int = 100
const MIN_SPEED: int = 10

const DEFAULT_SKILL_CAP: int = 10

const BASE_BELONGING_SLOTS: int = 1

const DEFAULT_ASSIGNED_WORK_RADIUS: int = 3

const STARTING_POPULATION: int = 3
const POPULATION_GROWTH_INTERVAL: float = 90.0
const POPULATION_GROWTH_CHANCE: float = 0.65

const VILLAGER_MOVE_INTERVAL: float = 0.18
const DEFAULT_HARVEST_DURATION: float = 3.0

const SKILL_HARVEST_SPEED_BONUS_PER_LEVEL: float = 0.02

# Core hunting timing.
const HUNT_BASE_DURATION: float = 10.0
const HUNT_REQUIRED_HUNTER_DURATION_BONUS: float = 2.0
const HUNTING_SKILL_DURATION_REDUCTION_PER_LEVEL: float = 0.25
const HUNT_MIN_DURATION: float = 4.0

# Legacy danger duration modifiers.
# These remain for compatibility, but animal-specific hunt_time_modifier should drive new tuning.
const HUNT_NORMAL_DURATION_MODIFIER: float = 0.0
const HUNT_DANGEROUS_DURATION_MODIFIER: float = 4.0
const HUNT_HIGH_DANGER_DURATION_MODIFIER: float = 8.0
const HUNT_EXTREME_DANGER_DURATION_MODIFIER: float = 14.0

# Core dangerous hunting tick tuning.
const HUNT_DANGER_TICK_INTERVAL: float = 10.0
const HUNT_EVADE_INJURY_CHANCE_REDUCTION_PER_LEVEL: float = 0.02
const HUNT_MIN_INJURY_CHANCE: float = 0.02
const HUNT_MIN_DAMAGE: int = 1
const HUNT_NO_REPLACEMENT_TIME_PENALTY: float = 10.0

# Core wild animal respawn and unique trigger tuning.
const ANIMAL_RESPAWN_DEFAULT_TIME: float = 180.0
const ANIMAL_RESPAWN_CHECK_INTERVAL: float = 5.0
const UNIQUE_ANIMAL_NO_RESPAWN_TIME: float = 0.0
const UNIQUE_ANIMAL_UNLIMITED_SPAWNS: int = 0
