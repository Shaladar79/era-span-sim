extends RefCounted
class_name HeroData

const HERO_WARLEADER: String = "warleader"
const HERO_CHIEFTAIN: String = "chieftain"
const HERO_SPIRITUAL_LEADER: String = "spiritual_leader"

const VISUAL_PIECE_ROOK: String = "rook"
const VISUAL_PIECE_KING: String = "king"
const VISUAL_PIECE_BISHOP: String = "bishop"

const VISUAL_COLOR_BLUE: String = "blue"
const VISUAL_COLOR_YELLOW: String = "yellow"
const VISUAL_COLOR_PURPLE: String = "purple"

const HERO_STATE_WANDERING: String = "wandering"

const KEY_HERO_TYPE: String = "hero_type"
const KEY_DISPLAY_NAME: String = "display_name"
const KEY_VISUAL_PIECE: String = "visual_piece"
const KEY_VISUAL_COLOR: String = "visual_color"
const KEY_SOURCE_BUILDINGS: String = "source_buildings"

const NAME_POOL: Array[String] = [
    "Koru",
    "Toma",
    "Maku",
    "Roka",
    "Banu",
    "Laka",
    "Nori",
    "Tavi",
    "Daru",
    "Moro",
    "Kava",
    "Ranu",
    "Teko",
    "Vaku",
    "Naku",
    "Loma",
    "Beko",
    "Saru",
    "Pavi",
    "Kito"
]


static func get_all_hero_types() -> Array:
    return [
        HERO_WARLEADER,
        HERO_CHIEFTAIN,
        HERO_SPIRITUAL_LEADER
    ]


static func get_hero_definition(hero_type: String) -> Dictionary:
    match hero_type:
        HERO_WARLEADER:
            return {
                KEY_HERO_TYPE: HERO_WARLEADER,
                KEY_DISPLAY_NAME: "Warleader",
                KEY_VISUAL_PIECE: VISUAL_PIECE_ROOK,
                KEY_VISUAL_COLOR: VISUAL_COLOR_BLUE,
                KEY_SOURCE_BUILDINGS: [
                    RegionBuildingData.BUILDING_WARLEADER_SHELTER
                ]
            }

        HERO_CHIEFTAIN:
            return {
                KEY_HERO_TYPE: HERO_CHIEFTAIN,
                KEY_DISPLAY_NAME: "Chieftain",
                KEY_VISUAL_PIECE: VISUAL_PIECE_KING,
                KEY_VISUAL_COLOR: VISUAL_COLOR_YELLOW,
                KEY_SOURCE_BUILDINGS: [
                    RegionBuildingData.BUILDING_CHIEFTAINS_SHELTER,
                    RegionBuildingData.BUILDING_CHIEFTAINS_TENT
                ]
            }

        HERO_SPIRITUAL_LEADER:
            return {
                KEY_HERO_TYPE: HERO_SPIRITUAL_LEADER,
                KEY_DISPLAY_NAME: "Spiritual Leader",
                KEY_VISUAL_PIECE: VISUAL_PIECE_BISHOP,
                KEY_VISUAL_COLOR: VISUAL_COLOR_PURPLE,
                KEY_SOURCE_BUILDINGS: [
                    RegionBuildingData.BUILDING_SPIRITUAL_LEADER_TENT
                ]
            }

        _:
            return {}


static func get_hero_type_for_building(building_id: String) -> String:
    var hero_types: Array = get_all_hero_types()

    for hero_index in range(hero_types.size()):
        var hero_type: String = str(hero_types[hero_index])
        var hero_definition: Dictionary = get_hero_definition(hero_type)
        var source_buildings: Array = hero_definition.get(KEY_SOURCE_BUILDINGS, [])

        if source_buildings.has(building_id):
            return hero_type

    return ""


static func get_hero_display_name(hero_type: String) -> String:
    var hero_definition: Dictionary = get_hero_definition(hero_type)

    if hero_definition.is_empty():
        return hero_type.capitalize()

    return str(hero_definition.get(KEY_DISPLAY_NAME, hero_type.capitalize()))


static func get_hero_visual_piece(hero_type: String) -> String:
    var hero_definition: Dictionary = get_hero_definition(hero_type)

    if hero_definition.is_empty():
        return VISUAL_PIECE_ROOK

    return str(hero_definition.get(KEY_VISUAL_PIECE, VISUAL_PIECE_ROOK))


static func get_hero_visual_color(hero_type: String) -> String:
    var hero_definition: Dictionary = get_hero_definition(hero_type)

    if hero_definition.is_empty():
        return VISUAL_COLOR_YELLOW

    return str(hero_definition.get(KEY_VISUAL_COLOR, VISUAL_COLOR_YELLOW))


static func get_hero_color(hero_type: String) -> Color:
    var visual_color: String = get_hero_visual_color(hero_type)

    match visual_color:
        VISUAL_COLOR_BLUE:
            return Color(0.15, 0.42, 1.0, 1.0)

        VISUAL_COLOR_PURPLE:
            return Color(0.62, 0.25, 1.0, 1.0)

        VISUAL_COLOR_YELLOW:
            return Color(1.0, 0.86, 0.20, 1.0)

        _:
            return Color(1.0, 1.0, 1.0, 1.0)


static func generate_hero_name(rng: RandomNumberGenerator) -> String:
    if NAME_POOL.is_empty():
        return "Koru"

    var name_index: int = rng.randi_range(0, NAME_POOL.size() - 1)

    return str(NAME_POOL[name_index])
