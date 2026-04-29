extends RefCounted
class_name VillagerNameGenerator

const GENDER_MALE: String = "male"
const GENDER_FEMALE: String = "female"

const NAME_ERA_STONE: String = "stone_age"

const STONE_MALE_NAMES: Array = [
    "Tog",
    "Dun",
    "Brak",
    "Mok",
    "Ruk",
    "Gor",
    "Vek",
    "Tor",
    "Karn",
    "Bren",
    "Orn",
    "Garr",
    "Vor",
    "Korr",
    "Drak",
    "Nok",
    "Harn",
    "Tarn",
    "Bor",
    "Grun"
]

const STONE_FEMALE_NAMES: Array = [
    "Ka",
    "Ma",
    "Na",
    "Eka",
    "Tala",
    "Mira",
    "Sora",
    "Nema",
    "Raka",
    "Vena",
    "Luma",
    "Hala",
    "Dena",
    "Ona",
    "Tavi",
    "Kessa",
    "Esh",
    "Rin",
    "Vala",
    "Mara"
]


static func generate_gender(rng: RandomNumberGenerator) -> String:
    if rng.randf() < 0.5:
        return GENDER_MALE

    return GENDER_FEMALE


static func generate_name(
    rng: RandomNumberGenerator,
    gender: String,
    used_names: Array,
    name_era: String = NAME_ERA_STONE
) -> String:
    var candidate_name: String = ""

    match name_era:
        NAME_ERA_STONE:
            candidate_name = generate_stone_age_name(
                rng,
                gender
            )
        _:
            candidate_name = generate_stone_age_name(
                rng,
                gender
            )

    var attempt_count: int = 0

    while used_names.has(candidate_name) and attempt_count < 20:
        match name_era:
            NAME_ERA_STONE:
                candidate_name = generate_stone_age_name(
                    rng,
                    gender
                )
            _:
                candidate_name = generate_stone_age_name(
                    rng,
                    gender
                )

        attempt_count += 1

    if used_names.has(candidate_name):
        candidate_name = candidate_name + str(rng.randi_range(2, 99))

    return candidate_name


static func generate_stone_age_name(
    rng: RandomNumberGenerator,
    gender: String
) -> String:
    if gender == GENDER_FEMALE:
        return str(STONE_FEMALE_NAMES[rng.randi_range(0, STONE_FEMALE_NAMES.size() - 1)])

    return str(STONE_MALE_NAMES[rng.randi_range(0, STONE_MALE_NAMES.size() - 1)])
