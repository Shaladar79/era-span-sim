extends RefCounted
class_name StoneAgeVillagerAssignmentData

const ROLE_VILLAGER: String = "villager"
const ROLE_MAKER: String = "maker"
const ROLE_THINKER: String = "thinker"
const ROLE_STONEWORKER: String = "stoneworker"
const ROLE_WOODWORKER: String = "woodworker"
const ROLE_GATHERER: String = "gatherer"
const ROLE_BONECARVER: String = "bonecarver"
const ROLE_HUNTER: String = "hunter"
const ROLE_WARRIOR: String = "warrior"
const ROLE_RITUALIST: String = "ritualist"
const ROLE_FISHER: String = "fisher"


static func get_default_role() -> String:
    return ROLE_VILLAGER


static func get_role_display_name(role_id: String) -> String:
    match role_id:
        ROLE_MAKER:
            return "Maker"
        ROLE_THINKER:
            return "Thinker"
        ROLE_STONEWORKER:
            return "Stoneworker"
        ROLE_WOODWORKER:
            return "Woodcarver"
        ROLE_GATHERER:
            return "Gatherer"
        ROLE_BONECARVER:
            return "Bonecarver"
        ROLE_HUNTER:
            return "Hunter"
        ROLE_WARRIOR:
            return "Warrior"
        ROLE_RITUALIST:
            return "Ritualist"
        ROLE_FISHER:
            return "Fisher"
        ROLE_VILLAGER:
            return "Villager"
        _:
            return role_id.capitalize()
