extends RefCounted
class_name RegionWildAnimalData

const AGE_STONE: String = "stone_age"
const AGE_BRONZE: String = "bronze_age"
const AGE_IRON: String = "iron_age"

const ANIMAL_RABBIT: String = "rabbit"
const ANIMAL_DEER: String = "deer"
const ANIMAL_ELK: String = "elk"
const ANIMAL_WILD_PIG: String = "wild_pig"
const ANIMAL_GAME_BIRD: String = "game_bird"

const ANIMAL_WOLF_PACK: String = "wolf_pack"
const ANIMAL_BOAR: String = "boar"
const ANIMAL_BROWN_BEAR: String = "brown_bear"
const ANIMAL_CAVE_LION: String = "cave_lion"
const ANIMAL_MAMMOTH: String = "mammoth"
const ANIMAL_SABER_TOOTH_CAT: String = "saber_tooth_cat"

const ANIMAL_BROKEN_TUSK: String = "broken_tusk"
const ANIMAL_DIRE_BEAR: String = "dire_bear"

const SPECIES_RABBIT: String = "rabbit"
const SPECIES_DEER: String = "deer"
const SPECIES_ELK: String = "elk"
const SPECIES_PIG: String = "pig"
const SPECIES_BIRD: String = "bird"
const SPECIES_WOLF: String = "wolf"
const SPECIES_BOAR: String = "boar"
const SPECIES_BEAR: String = "bear"
const SPECIES_LION: String = "lion"
const SPECIES_MAMMOTH: String = "mammoth"
const SPECIES_SABER_TOOTH_CAT: String = "saber_tooth_cat"

const DANGER_NONE: String = "none"
const DANGER_MEDIUM: String = "medium"
const DANGER_HIGH: String = "high"
const DANGER_EXTREME: String = "extreme"

const TERRAIN_ANY: String = "any"
const TERRAIN_GRASS: String = "grass"
const TERRAIN_FOREST: String = "forest"
const TERRAIN_HILLS: String = "hills"
const TERRAIN_MOUNTAIN_EDGE: String = "mountain_edge"
const TERRAIN_TUNDRA: String = "tundra"
const TERRAIN_WATER_EDGE: String = "water_edge"

const TRIGGER_TYPE_KILL_COUNT: String = "kill_count"

const KEY_ID: String = "id"
const KEY_NAME: String = "name"
const KEY_SPECIES: String = "species"
const KEY_DANGEROUS: String = "dangerous"
const KEY_DANGER_LEVEL: String = "danger_level"
const KEY_REQUIRED_HUNTERS: String = "required_hunters"
const KEY_CAN_INJURE_HUNTERS: String = "can_injure_hunters"
const KEY_CAN_KILL_HUNTERS: String = "can_kill_hunters"
const KEY_INJURY_CHANCE: String = "injury_chance"
const KEY_DEATH_CHANCE: String = "death_chance"
const KEY_HUNT_DAMAGE: String = "hunt_damage"
const KEY_HUNT_TIME_MODIFIER: String = "hunt_time_modifier"
const KEY_YIELDS: String = "yields"
const KEY_AGES: String = "ages"
const KEY_TERRAIN_BIAS: String = "terrain_bias"
const KEY_SPAWN_WEIGHT: String = "spawn_weight"
const KEY_ICON_COLOR_TYPE: String = "icon_color_type"

const KEY_CAN_RESPAWN: String = "can_respawn"
const KEY_RESPAWN_TIME: String = "respawn_time"
const KEY_MAX_ACTIVE: String = "max_active"

const KEY_IS_UNIQUE: String = "is_unique"
const KEY_UNIQUE_ID: String = "unique_id"
const KEY_UNIQUE_REPEATABLE: String = "unique_repeatable"
const KEY_UNIQUE_MAX_SPAWNS: String = "unique_max_spawns"
const KEY_SPAWN_TRIGGER: String = "spawn_trigger"

const KEY_TRIGGER_TYPE: String = "type"
const KEY_TRIGGER_ANIMAL_ID: String = "animal_id"
const KEY_TRIGGER_COUNT: String = "count"
const KEY_TRIGGER_REPEAT_INTERVAL: String = "repeat_interval"

const ICON_COLOR_NORMAL: String = "normal"
const ICON_COLOR_DANGEROUS: String = "dangerous"
const ICON_COLOR_UNIQUE: String = "unique"


static func get_all_animals() -> Array:
    return [
        get_rabbit(),
        get_deer(),
        get_elk(),
        get_wild_pig(),
        get_game_bird(),
        get_wolf_pack(),
        get_boar(),
        get_brown_bear(),
        get_cave_lion(),
        get_mammoth(),
        get_saber_tooth_cat()
    ]


static func get_all_unique_animals() -> Array:
    return [
        get_broken_tusk(),
        get_dire_bear()
    ]


static func get_stone_age_animals() -> Array:
    return get_animals_for_age(AGE_STONE)


static func get_animals_for_age(age_id: String) -> Array:
    var output: Array = []
    var all_animals: Array = get_all_animals()

    for animal_index in range(all_animals.size()):
        var animal_data: Dictionary = all_animals[animal_index]
        var ages: Array = animal_data.get(KEY_AGES, [])

        if ages.has(age_id):
            output.append(animal_data)

    return output


static func get_unique_animals_for_age(age_id: String) -> Array:
    var output: Array = []
    var all_unique_animals: Array = get_all_unique_animals()

    for animal_index in range(all_unique_animals.size()):
        var animal_data: Dictionary = all_unique_animals[animal_index]
        var ages: Array = animal_data.get(KEY_AGES, [])

        if ages.has(age_id):
            output.append(animal_data)

    return output


static func get_normal_animals_for_age(age_id: String) -> Array:
    var output: Array = []
    var animals: Array = get_animals_for_age(age_id)

    for animal_index in range(animals.size()):
        var animal_data: Dictionary = animals[animal_index]

        if bool(animal_data.get(KEY_DANGEROUS, false)):
            continue

        output.append(animal_data)

    return output


static func get_dangerous_animals_for_age(age_id: String) -> Array:
    var output: Array = []
    var animals: Array = get_animals_for_age(age_id)

    for animal_index in range(animals.size()):
        var animal_data: Dictionary = animals[animal_index]

        if not bool(animal_data.get(KEY_DANGEROUS, false)):
            continue

        output.append(animal_data)

    return output


static func get_animal(animal_id: String) -> Dictionary:
    var all_animals: Array = get_all_animals()

    for animal_index in range(all_animals.size()):
        var animal_data: Dictionary = all_animals[animal_index]

        if str(animal_data.get(KEY_ID, "")) == animal_id:
            return animal_data.duplicate(true)

    var all_unique_animals: Array = get_all_unique_animals()

    for unique_index in range(all_unique_animals.size()):
        var unique_animal_data: Dictionary = all_unique_animals[unique_index]

        if str(unique_animal_data.get(KEY_ID, "")) == animal_id:
            return unique_animal_data.duplicate(true)

    return {}


static func get_rabbit() -> Dictionary:
    return make_animal(
        ANIMAL_RABBIT,
        "Rabbit",
        SPECIES_RABBIT,
        false,
        DANGER_NONE,
        StoneAgeTuning.NORMAL_ANIMAL_DEFAULT_REQUIRED_HUNTERS,
        {
            StoneAgeTuning.RESOURCE_MEAT: StoneAgeTuning.SMALL_ANIMAL_MEAT_YIELD,
            StoneAgeTuning.RESOURCE_HIDE: StoneAgeTuning.SMALL_ANIMAL_HIDE_YIELD,
            StoneAgeTuning.RESOURCE_BONE: StoneAgeTuning.SMALL_ANIMAL_BONE_YIELD
        },
        [
            AGE_STONE,
            AGE_BRONZE,
            AGE_IRON
        ],
        [
            TERRAIN_GRASS,
            TERRAIN_FOREST
        ],
        18,
        -2.0,
        true,
        90.0,
        12
    )


static func get_deer() -> Dictionary:
    return make_animal(
        ANIMAL_DEER,
        "Deer",
        SPECIES_DEER,
        false,
        DANGER_NONE,
        StoneAgeTuning.NORMAL_ANIMAL_DEFAULT_REQUIRED_HUNTERS,
        {
            StoneAgeTuning.RESOURCE_MEAT: StoneAgeTuning.MEDIUM_ANIMAL_MEAT_YIELD,
            StoneAgeTuning.RESOURCE_HIDE: StoneAgeTuning.MEDIUM_ANIMAL_HIDE_YIELD,
            StoneAgeTuning.RESOURCE_BONE: StoneAgeTuning.MEDIUM_ANIMAL_BONE_YIELD
        },
        [
            AGE_STONE,
            AGE_BRONZE,
            AGE_IRON
        ],
        [
            TERRAIN_GRASS,
            TERRAIN_FOREST
        ],
        16,
        2.0,
        true,
        150.0,
        10
    )


static func get_elk() -> Dictionary:
    return make_animal(
        ANIMAL_ELK,
        "Elk",
        SPECIES_ELK,
        false,
        DANGER_NONE,
        StoneAgeTuning.LARGE_NORMAL_ANIMAL_DEFAULT_REQUIRED_HUNTERS,
        {
            StoneAgeTuning.RESOURCE_MEAT: StoneAgeTuning.LARGE_ANIMAL_MEAT_YIELD,
            StoneAgeTuning.RESOURCE_HIDE: StoneAgeTuning.LARGE_ANIMAL_HIDE_YIELD,
            StoneAgeTuning.RESOURCE_BONE: StoneAgeTuning.LARGE_ANIMAL_BONE_YIELD
        },
        [
            AGE_STONE,
            AGE_BRONZE,
            AGE_IRON
        ],
        [
            TERRAIN_FOREST,
            TERRAIN_TUNDRA
        ],
        9,
        6.0,
        true,
        210.0,
        7
    )


static func get_wild_pig() -> Dictionary:
    return make_animal(
        ANIMAL_WILD_PIG,
        "Wild Pig",
        SPECIES_PIG,
        false,
        DANGER_NONE,
        StoneAgeTuning.LARGE_NORMAL_ANIMAL_DEFAULT_REQUIRED_HUNTERS,
        {
            StoneAgeTuning.RESOURCE_MEAT: StoneAgeTuning.MEDIUM_ANIMAL_MEAT_YIELD + 2,
            StoneAgeTuning.RESOURCE_HIDE: StoneAgeTuning.SMALL_ANIMAL_HIDE_YIELD,
            StoneAgeTuning.RESOURCE_BONE: StoneAgeTuning.MEDIUM_ANIMAL_BONE_YIELD
        },
        [
            AGE_STONE,
            AGE_BRONZE,
            AGE_IRON
        ],
        [
            TERRAIN_GRASS,
            TERRAIN_FOREST
        ],
        12,
        3.0,
        true,
        160.0,
        8
    )


static func get_game_bird() -> Dictionary:
    return make_animal(
        ANIMAL_GAME_BIRD,
        "Game Bird",
        SPECIES_BIRD,
        false,
        DANGER_NONE,
        StoneAgeTuning.NORMAL_ANIMAL_DEFAULT_REQUIRED_HUNTERS,
        {
            StoneAgeTuning.RESOURCE_MEAT: StoneAgeTuning.SMALL_ANIMAL_MEAT_YIELD,
            StoneAgeTuning.RESOURCE_BONE: StoneAgeTuning.SMALL_ANIMAL_BONE_YIELD,
            StoneAgeTuning.RESOURCE_FEATHER: StoneAgeTuning.SMALL_BIRD_FEATHER_YIELD
        },
        [
            AGE_STONE,
            AGE_BRONZE,
            AGE_IRON
        ],
        [
            TERRAIN_GRASS,
            TERRAIN_FOREST
        ],
        14,
        -1.0,
        true,
        100.0,
        10
    )


static func get_wolf_pack() -> Dictionary:
    return make_animal(
        ANIMAL_WOLF_PACK,
        "Wolf Pack",
        SPECIES_WOLF,
        true,
        DANGER_MEDIUM,
        StoneAgeTuning.DANGEROUS_ANIMAL_DEFAULT_REQUIRED_HUNTERS,
        {
            StoneAgeTuning.RESOURCE_MEAT: StoneAgeTuning.PREDATOR_MEAT_YIELD,
            StoneAgeTuning.RESOURCE_HIDE: StoneAgeTuning.PREDATOR_HIDE_YIELD,
            StoneAgeTuning.RESOURCE_BONE: StoneAgeTuning.PREDATOR_BONE_YIELD
        },
        [
            AGE_STONE,
            AGE_BRONZE,
            AGE_IRON
        ],
        [
            TERRAIN_GRASS,
            TERRAIN_FOREST,
            TERRAIN_TUNDRA
        ],
        8,
        6.0,
        true,
        240.0,
        6
    )


static func get_boar() -> Dictionary:
    return make_animal(
        ANIMAL_BOAR,
        "Boar",
        SPECIES_BOAR,
        true,
        DANGER_MEDIUM,
        StoneAgeTuning.DANGEROUS_ANIMAL_DEFAULT_REQUIRED_HUNTERS,
        {
            StoneAgeTuning.RESOURCE_MEAT: StoneAgeTuning.MEDIUM_ANIMAL_MEAT_YIELD + 2,
            StoneAgeTuning.RESOURCE_HIDE: StoneAgeTuning.MEDIUM_ANIMAL_HIDE_YIELD,
            StoneAgeTuning.RESOURCE_BONE: StoneAgeTuning.MEDIUM_ANIMAL_BONE_YIELD
        },
        [
            AGE_STONE,
            AGE_BRONZE,
            AGE_IRON
        ],
        [
            TERRAIN_GRASS,
            TERRAIN_FOREST
        ],
        7,
        6.0,
        true,
        220.0,
        6
    )


static func get_brown_bear() -> Dictionary:
    return make_animal(
        ANIMAL_BROWN_BEAR,
        "Brown Bear",
        SPECIES_BEAR,
        true,
        DANGER_HIGH,
        StoneAgeTuning.LARGE_DANGEROUS_ANIMAL_DEFAULT_REQUIRED_HUNTERS,
        {
            StoneAgeTuning.RESOURCE_MEAT: StoneAgeTuning.LARGE_PREDATOR_MEAT_YIELD,
            StoneAgeTuning.RESOURCE_HIDE: StoneAgeTuning.LARGE_PREDATOR_HIDE_YIELD,
            StoneAgeTuning.RESOURCE_BONE: StoneAgeTuning.LARGE_PREDATOR_BONE_YIELD
        },
        [
            AGE_STONE,
            AGE_BRONZE,
            AGE_IRON
        ],
        [
            TERRAIN_FOREST,
            TERRAIN_HILLS,
            TERRAIN_MOUNTAIN_EDGE
        ],
        5,
        10.0,
        true,
        300.0,
        4
    )


static func get_cave_lion() -> Dictionary:
    return make_animal(
        ANIMAL_CAVE_LION,
        "Cave Lion",
        SPECIES_LION,
        true,
        DANGER_HIGH,
        StoneAgeTuning.LARGE_DANGEROUS_ANIMAL_DEFAULT_REQUIRED_HUNTERS,
        {
            StoneAgeTuning.RESOURCE_MEAT: StoneAgeTuning.LARGE_PREDATOR_MEAT_YIELD,
            StoneAgeTuning.RESOURCE_HIDE: StoneAgeTuning.LARGE_PREDATOR_HIDE_YIELD,
            StoneAgeTuning.RESOURCE_BONE: StoneAgeTuning.LARGE_PREDATOR_BONE_YIELD
        },
        [
            AGE_STONE
        ],
        [
            TERRAIN_GRASS,
            TERRAIN_HILLS,
            TERRAIN_MOUNTAIN_EDGE
        ],
        4,
        10.0,
        true,
        300.0,
        3
    )


static func get_mammoth() -> Dictionary:
    return make_animal(
        ANIMAL_MAMMOTH,
        "Mammoth",
        SPECIES_MAMMOTH,
        true,
        DANGER_EXTREME,
        StoneAgeTuning.EXTREME_DANGEROUS_ANIMAL_DEFAULT_REQUIRED_HUNTERS,
        {
            StoneAgeTuning.RESOURCE_MEAT: StoneAgeTuning.HUGE_ANIMAL_MEAT_YIELD,
            StoneAgeTuning.RESOURCE_HIDE: StoneAgeTuning.HUGE_ANIMAL_HIDE_YIELD,
            StoneAgeTuning.RESOURCE_BONE: StoneAgeTuning.HUGE_ANIMAL_BONE_YIELD
        },
        [
            AGE_STONE
        ],
        [
            TERRAIN_TUNDRA,
            TERRAIN_GRASS
        ],
        3,
        16.0,
        true,
        420.0,
        3
    )


static func get_saber_tooth_cat() -> Dictionary:
    return make_animal(
        ANIMAL_SABER_TOOTH_CAT,
        "Saber-Tooth Cat",
        SPECIES_SABER_TOOTH_CAT,
        true,
        DANGER_HIGH,
        StoneAgeTuning.LARGE_DANGEROUS_ANIMAL_DEFAULT_REQUIRED_HUNTERS,
        {
            StoneAgeTuning.RESOURCE_MEAT: StoneAgeTuning.LARGE_PREDATOR_MEAT_YIELD,
            StoneAgeTuning.RESOURCE_HIDE: StoneAgeTuning.LARGE_PREDATOR_HIDE_YIELD,
            StoneAgeTuning.RESOURCE_BONE: StoneAgeTuning.LARGE_PREDATOR_BONE_YIELD
        },
        [
            AGE_STONE
        ],
        [
            TERRAIN_GRASS,
            TERRAIN_TUNDRA,
            TERRAIN_HILLS
        ],
        4,
        10.0,
        true,
        300.0,
        3
    )


static func get_broken_tusk() -> Dictionary:
    var animal_data: Dictionary = make_animal(
        ANIMAL_BROKEN_TUSK,
        "Broken Tusk",
        SPECIES_MAMMOTH,
        true,
        DANGER_EXTREME,
        6,
        {
            StoneAgeTuning.RESOURCE_MEAT: StoneAgeTuning.HUGE_ANIMAL_MEAT_YIELD + 50,
            StoneAgeTuning.RESOURCE_HIDE: StoneAgeTuning.HUGE_ANIMAL_HIDE_YIELD + 12,
            StoneAgeTuning.RESOURCE_BONE: StoneAgeTuning.HUGE_ANIMAL_BONE_YIELD + 12
        },
        [
            AGE_STONE
        ],
        [
            TERRAIN_TUNDRA,
            TERRAIN_GRASS
        ],
        0,
        24.0,
        false,
        CoreTuning.UNIQUE_ANIMAL_NO_RESPAWN_TIME,
        1,
        true,
        ANIMAL_BROKEN_TUSK,
        false,
        1,
        make_kill_count_trigger(
            ANIMAL_MAMMOTH,
            5,
            0
        )
    )

    animal_data[KEY_INJURY_CHANCE] = 0.55
    animal_data[KEY_DEATH_CHANCE] = 0.12
    animal_data[KEY_HUNT_DAMAGE] = 10
    animal_data[KEY_ICON_COLOR_TYPE] = ICON_COLOR_UNIQUE

    return animal_data


static func get_dire_bear() -> Dictionary:
    var animal_data: Dictionary = make_animal(
        ANIMAL_DIRE_BEAR,
        "Dire Bear",
        SPECIES_BEAR,
        true,
        DANGER_EXTREME,
        5,
        {
            StoneAgeTuning.RESOURCE_MEAT: StoneAgeTuning.LARGE_PREDATOR_MEAT_YIELD + 8,
            StoneAgeTuning.RESOURCE_HIDE: StoneAgeTuning.LARGE_PREDATOR_HIDE_YIELD + 4,
            StoneAgeTuning.RESOURCE_BONE: StoneAgeTuning.LARGE_PREDATOR_BONE_YIELD + 4
        },
        [
            AGE_STONE,
            AGE_BRONZE,
            AGE_IRON
        ],
        [
            TERRAIN_FOREST,
            TERRAIN_HILLS,
            TERRAIN_MOUNTAIN_EDGE
        ],
        0,
        18.0,
        false,
        CoreTuning.UNIQUE_ANIMAL_NO_RESPAWN_TIME,
        1,
        true,
        ANIMAL_DIRE_BEAR,
        true,
        CoreTuning.UNIQUE_ANIMAL_UNLIMITED_SPAWNS,
        make_kill_count_trigger(
            ANIMAL_BROWN_BEAR,
            6,
            6
        )
    )

    animal_data[KEY_INJURY_CHANCE] = 0.50
    animal_data[KEY_DEATH_CHANCE] = 0.10
    animal_data[KEY_HUNT_DAMAGE] = 8
    animal_data[KEY_ICON_COLOR_TYPE] = ICON_COLOR_UNIQUE

    return animal_data


static func make_animal(
    animal_id: String,
    animal_name: String,
    species: String,
    dangerous: bool,
    danger_level: String,
    required_hunters: int,
    yields: Dictionary,
    ages: Array,
    terrain_bias: Array,
    spawn_weight: int,
    hunt_time_modifier: float = 0.0,
    can_respawn: bool = true,
    respawn_time: float = CoreTuning.ANIMAL_RESPAWN_DEFAULT_TIME,
    max_active: int = 0,
    is_unique: bool = false,
    unique_id: String = "",
    unique_repeatable: bool = false,
    unique_max_spawns: int = 0,
    spawn_trigger: Dictionary = {}
) -> Dictionary:
    return {
        KEY_ID: animal_id,
        KEY_NAME: animal_name,
        KEY_SPECIES: species,
        KEY_DANGEROUS: dangerous,
        KEY_DANGER_LEVEL: danger_level,
        KEY_REQUIRED_HUNTERS: required_hunters,
        KEY_CAN_INJURE_HUNTERS: dangerous,
        KEY_CAN_KILL_HUNTERS: dangerous,
        KEY_INJURY_CHANCE: get_injury_chance_for_danger_level(danger_level),
        KEY_DEATH_CHANCE: get_death_chance_for_danger_level(danger_level),
        KEY_HUNT_DAMAGE: get_hunt_damage_for_danger_level(danger_level),
        KEY_HUNT_TIME_MODIFIER: hunt_time_modifier,
        KEY_YIELDS: yields.duplicate(true),
        KEY_AGES: ages.duplicate(true),
        KEY_TERRAIN_BIAS: terrain_bias.duplicate(true),
        KEY_SPAWN_WEIGHT: spawn_weight,
        KEY_ICON_COLOR_TYPE: get_icon_color_type(dangerous, is_unique),
        KEY_CAN_RESPAWN: can_respawn,
        KEY_RESPAWN_TIME: max(0.0, respawn_time),
        KEY_MAX_ACTIVE: max(0, max_active),
        KEY_IS_UNIQUE: is_unique,
        KEY_UNIQUE_ID: unique_id,
        KEY_UNIQUE_REPEATABLE: unique_repeatable,
        KEY_UNIQUE_MAX_SPAWNS: max(0, unique_max_spawns),
        KEY_SPAWN_TRIGGER: spawn_trigger.duplicate(true)
    }


static func make_kill_count_trigger(
    animal_id: String,
    count: int,
    repeat_interval: int
) -> Dictionary:
    return {
        KEY_TRIGGER_TYPE: TRIGGER_TYPE_KILL_COUNT,
        KEY_TRIGGER_ANIMAL_ID: animal_id,
        KEY_TRIGGER_COUNT: max(1, count),
        KEY_TRIGGER_REPEAT_INTERVAL: max(0, repeat_interval)
    }


static func get_injury_chance_for_danger_level(danger_level: String) -> float:
    match danger_level:
        DANGER_MEDIUM:
            return StoneAgeTuning.DANGEROUS_ANIMAL_BASE_INJURY_CHANCE
        DANGER_HIGH:
            return StoneAgeTuning.HIGH_DANGER_ANIMAL_BASE_INJURY_CHANCE
        DANGER_EXTREME:
            return StoneAgeTuning.EXTREME_DANGER_ANIMAL_BASE_INJURY_CHANCE
        _:
            return StoneAgeTuning.NORMAL_ANIMAL_BASE_INJURY_CHANCE


static func get_death_chance_for_danger_level(danger_level: String) -> float:
    match danger_level:
        DANGER_MEDIUM:
            return StoneAgeTuning.DANGEROUS_ANIMAL_BASE_DEATH_CHANCE
        DANGER_HIGH:
            return StoneAgeTuning.HIGH_DANGER_ANIMAL_BASE_DEATH_CHANCE
        DANGER_EXTREME:
            return StoneAgeTuning.EXTREME_DANGER_ANIMAL_BASE_DEATH_CHANCE
        _:
            return StoneAgeTuning.NORMAL_ANIMAL_BASE_DEATH_CHANCE


static func get_hunt_damage_for_danger_level(danger_level: String) -> int:
    match danger_level:
        DANGER_MEDIUM:
            return 3
        DANGER_HIGH:
            return 5
        DANGER_EXTREME:
            return 8
        _:
            return 0


static func get_icon_color_type(
    dangerous: bool,
    is_unique: bool = false
) -> String:
    if is_unique:
        return ICON_COLOR_UNIQUE

    if dangerous:
        return ICON_COLOR_DANGEROUS

    return ICON_COLOR_NORMAL
