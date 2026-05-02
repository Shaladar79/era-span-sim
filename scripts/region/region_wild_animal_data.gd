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

const KEY_ID: String = "id"
const KEY_NAME: String = "name"
const KEY_DANGEROUS: String = "dangerous"
const KEY_DANGER_LEVEL: String = "danger_level"
const KEY_REQUIRED_HUNTERS: String = "required_hunters"
const KEY_CAN_INJURE_HUNTERS: String = "can_injure_hunters"
const KEY_CAN_KILL_HUNTERS: String = "can_kill_hunters"
const KEY_INJURY_CHANCE: String = "injury_chance"
const KEY_DEATH_CHANCE: String = "death_chance"
const KEY_YIELDS: String = "yields"
const KEY_AGES: String = "ages"
const KEY_TERRAIN_BIAS: String = "terrain_bias"
const KEY_SPAWN_WEIGHT: String = "spawn_weight"
const KEY_ICON_COLOR_TYPE: String = "icon_color_type"

const ICON_COLOR_NORMAL: String = "normal"
const ICON_COLOR_DANGEROUS: String = "dangerous"


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

    return {}


static func get_rabbit() -> Dictionary:
    return make_animal(
        ANIMAL_RABBIT,
        "Rabbit",
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
        18
    )


static func get_deer() -> Dictionary:
    return make_animal(
        ANIMAL_DEER,
        "Deer",
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
        16
    )


static func get_elk() -> Dictionary:
    return make_animal(
        ANIMAL_ELK,
        "Elk",
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
        9
    )


static func get_wild_pig() -> Dictionary:
    return make_animal(
        ANIMAL_WILD_PIG,
        "Wild Pig",
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
        12
    )


static func get_game_bird() -> Dictionary:
    return make_animal(
        ANIMAL_GAME_BIRD,
        "Game Bird",
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
        14
    )


static func get_wolf_pack() -> Dictionary:
    return make_animal(
        ANIMAL_WOLF_PACK,
        "Wolf Pack",
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
        8
    )


static func get_boar() -> Dictionary:
    return make_animal(
        ANIMAL_BOAR,
        "Boar",
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
        7
    )


static func get_brown_bear() -> Dictionary:
    return make_animal(
        ANIMAL_BROWN_BEAR,
        "Brown Bear",
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
        5
    )


static func get_cave_lion() -> Dictionary:
    return make_animal(
        ANIMAL_CAVE_LION,
        "Cave Lion",
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
        4
    )


static func get_mammoth() -> Dictionary:
    return make_animal(
        ANIMAL_MAMMOTH,
        "Mammoth",
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
        3
    )


static func get_saber_tooth_cat() -> Dictionary:
    return make_animal(
        ANIMAL_SABER_TOOTH_CAT,
        "Saber-Tooth Cat",
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
        4
    )


static func make_animal(
    animal_id: String,
    animal_name: String,
    dangerous: bool,
    danger_level: String,
    required_hunters: int,
    yields: Dictionary,
    ages: Array,
    terrain_bias: Array,
    spawn_weight: int
) -> Dictionary:
    return {
        KEY_ID: animal_id,
        KEY_NAME: animal_name,
        KEY_DANGEROUS: dangerous,
        KEY_DANGER_LEVEL: danger_level,
        KEY_REQUIRED_HUNTERS: required_hunters,
        KEY_CAN_INJURE_HUNTERS: dangerous,
        KEY_CAN_KILL_HUNTERS: dangerous,
        KEY_INJURY_CHANCE: get_injury_chance_for_danger_level(danger_level),
        KEY_DEATH_CHANCE: get_death_chance_for_danger_level(danger_level),
        KEY_YIELDS: yields.duplicate(true),
        KEY_AGES: ages.duplicate(true),
        KEY_TERRAIN_BIAS: terrain_bias.duplicate(true),
        KEY_SPAWN_WEIGHT: spawn_weight,
        KEY_ICON_COLOR_TYPE: get_icon_color_type(dangerous)
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


static func get_icon_color_type(dangerous: bool) -> String:
    if dangerous:
        return ICON_COLOR_DANGEROUS

    return ICON_COLOR_NORMAL
