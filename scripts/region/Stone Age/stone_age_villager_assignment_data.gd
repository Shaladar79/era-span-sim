extends RefCounted
class_name StoneAgeVillagerAssignmentData

const ROLE_VILLAGER: String = "villager"
const ROLE_CRAFTER: String = "crafter"
const ROLE_THINKER: String = "thinker"
const ROLE_GATHERER: String = "gatherer"
const ROLE_HUNTER: String = "hunter"
const ROLE_WARRIOR: String = "warrior"
const ROLE_RITUALIST: String = "ritualist"
const ROLE_FISHER: String = "fisher"

# Legacy role aliases kept so older building/item references do not break while
# Stone Age work roles are being simplified.
const ROLE_MAKER: String = ROLE_CRAFTER
const ROLE_STONEWORKER: String = ROLE_CRAFTER
const ROLE_WOODWORKER: String = ROLE_CRAFTER
const ROLE_BONECARVER: String = ROLE_CRAFTER


static func get_default_role() -> String:
    return ROLE_VILLAGER


static func get_role_display_name(role_id: String) -> String:
    match role_id:
        ROLE_CRAFTER:
            return "Crafter"
        ROLE_THINKER:
            return "Thinker"
        ROLE_GATHERER:
            return "Gatherer"
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


static func get_role_granted_skill(role_id: String) -> String:
    match role_id:
        ROLE_GATHERER:
            return "gathering"
        ROLE_CRAFTER:
            return "crafting"
        ROLE_THINKER:
            return "thinking"
        ROLE_RITUALIST:
            return "rituals"
        ROLE_FISHER:
            return "fishing"
        _:
            return ""


static func role_grants_skill(role_id: String) -> bool:
    return get_role_granted_skill(role_id) != ""


static func is_crafter_role(role_id: String) -> bool:
    return role_id == ROLE_CRAFTER


static func is_gatherer_role(role_id: String) -> bool:
    return role_id == ROLE_GATHERER
