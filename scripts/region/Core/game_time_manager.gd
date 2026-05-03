extends RefCounted
class_name GameTimeManager

const SECONDS_PER_DAY: float = 600.0
const DAYS_PER_MONTH: int = 3
const MONTHS_PER_YEAR: int = 10
const DAYS_PER_YEAR: int = DAYS_PER_MONTH * MONTHS_PER_YEAR

const SAVE_KEY_ELAPSED_DAY_SECONDS: String = "elapsed_day_seconds"
const SAVE_KEY_TOTAL_DAYS_ELAPSED: String = "total_days_elapsed"
const SAVE_KEY_CURRENT_DAY: String = "current_day"
const SAVE_KEY_CURRENT_MONTH: String = "current_month"
const SAVE_KEY_CURRENT_YEAR: String = "current_year"

var elapsed_day_seconds: float = 0.0
var total_days_elapsed: int = 0
var current_day: int = 1
var current_month: int = 1
var current_year: int = 1


func reset() -> void:
    elapsed_day_seconds = 0.0
    total_days_elapsed = 0
    current_day = 1
    current_month = 1
    current_year = 1


func update(delta: float) -> Dictionary:
    var result: Dictionary = get_current_time_result()

    if delta <= 0.0:
        return result

    var old_month: int = current_month
    var old_year: int = current_year

    elapsed_day_seconds += delta

    var days_advanced: int = int(floor(elapsed_day_seconds / SECONDS_PER_DAY))

    if days_advanced <= 0:
        return result

    elapsed_day_seconds -= float(days_advanced) * SECONDS_PER_DAY
    total_days_elapsed += days_advanced

    recalculate_calendar_from_total_days()

    result["day_changed"] = true
    result["month_changed"] = current_month != old_month or current_year != old_year
    result["year_changed"] = current_year != old_year
    result["days_advanced"] = days_advanced
    result["current_day"] = current_day
    result["current_month"] = current_month
    result["current_year"] = current_year
    result["total_days_elapsed"] = total_days_elapsed

    return result


func get_current_time_result() -> Dictionary:
    return {
        "day_changed": false,
        "month_changed": false,
        "year_changed": false,
        "days_advanced": 0,
        "current_day": current_day,
        "current_month": current_month,
        "current_year": current_year,
        "total_days_elapsed": total_days_elapsed
    }


func recalculate_calendar_from_total_days() -> void:
    var year_index: int = int(floor(float(total_days_elapsed) / float(DAYS_PER_YEAR)))
    var day_of_year_index: int = total_days_elapsed % DAYS_PER_YEAR
    var month_index: int = int(floor(float(day_of_year_index) / float(DAYS_PER_MONTH)))
    var day_index: int = day_of_year_index % DAYS_PER_MONTH

    current_year = year_index + 1
    current_month = month_index + 1
    current_day = day_index + 1


func get_save_data() -> Dictionary:
    return {
        SAVE_KEY_ELAPSED_DAY_SECONDS: elapsed_day_seconds,
        SAVE_KEY_TOTAL_DAYS_ELAPSED: total_days_elapsed,
        SAVE_KEY_CURRENT_DAY: current_day,
        SAVE_KEY_CURRENT_MONTH: current_month,
        SAVE_KEY_CURRENT_YEAR: current_year
    }


func load_save_data(save_data: Dictionary) -> void:
    if save_data.is_empty():
        reset()
        return

    elapsed_day_seconds = float(save_data.get(SAVE_KEY_ELAPSED_DAY_SECONDS, 0.0))
    total_days_elapsed = max(0, int(save_data.get(SAVE_KEY_TOTAL_DAYS_ELAPSED, 0)))

    recalculate_calendar_from_total_days()

    elapsed_day_seconds = clamp(elapsed_day_seconds, 0.0, SECONDS_PER_DAY - 0.001)
