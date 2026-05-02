extends RefCounted
class_name SaveManager

const SAVE_DIRECTORY: String = "user://saves"
const SAVE_EXTENSION: String = ".json"
const AUTOSAVE_SUFFIX: String = "_auto_"

const SAVE_VERSION: int = 1

const KEY_SAVE_VERSION: String = "save_version"
const KEY_SAVE_NAME: String = "save_name"
const KEY_WORLD_NAME: String = "world_name"
const KEY_REGION_NAME: String = "region_name"
const KEY_CREATED_UNIX_TIME: String = "created_unix_time"
const KEY_UPDATED_UNIX_TIME: String = "updated_unix_time"
const KEY_WORLD_DATA: String = "world_data"
const KEY_REGION_DATA: String = "region_data"


static func ensure_save_directory_exists() -> void:
    if DirAccess.dir_exists_absolute(SAVE_DIRECTORY):
        return

    var error: Error = DirAccess.make_dir_recursive_absolute(SAVE_DIRECTORY)

    if error != OK:
        push_error("Failed to create save directory: " + SAVE_DIRECTORY + " Error: " + str(error))


static func get_save_path(save_name: String) -> String:
    var safe_name: String = sanitize_save_name(save_name)

    if safe_name == "":
        safe_name = "save"

    return SAVE_DIRECTORY + "/" + safe_name + SAVE_EXTENSION


static func get_autosave_path(region_name: String, autosave_index: int) -> String:
    var safe_region_name: String = sanitize_save_name(region_name)

    if safe_region_name == "":
        safe_region_name = "region"

    return (
        SAVE_DIRECTORY
        + "/"
        + safe_region_name
        + AUTOSAVE_SUFFIX
        + str(autosave_index)
        + SAVE_EXTENSION
    )


static func sanitize_save_name(raw_name: String) -> String:
    var safe_name: String = raw_name.strip_edges().to_lower()

    safe_name = safe_name.replace(" ", "_")
    safe_name = safe_name.replace("/", "_")
    safe_name = safe_name.replace("\\", "_")
    safe_name = safe_name.replace(":", "_")
    safe_name = safe_name.replace("*", "_")
    safe_name = safe_name.replace("?", "_")
    safe_name = safe_name.replace("\"", "_")
    safe_name = safe_name.replace("<", "_")
    safe_name = safe_name.replace(">", "_")
    safe_name = safe_name.replace("|", "_")

    while safe_name.contains("__"):
        safe_name = safe_name.replace("__", "_")

    return safe_name


static func build_base_save_data(
    save_name: String,
    world_name: String,
    region_name: String,
    world_data: Dictionary,
    region_data: Dictionary
) -> Dictionary:
    var current_time: int = Time.get_unix_time_from_system()

    return {
        KEY_SAVE_VERSION: SAVE_VERSION,
        KEY_SAVE_NAME: save_name,
        KEY_WORLD_NAME: world_name,
        KEY_REGION_NAME: region_name,
        KEY_CREATED_UNIX_TIME: current_time,
        KEY_UPDATED_UNIX_TIME: current_time,
        KEY_WORLD_DATA: world_data,
        KEY_REGION_DATA: region_data
    }


static func write_save(save_name: String, save_data: Dictionary) -> Dictionary:
    ensure_save_directory_exists()

    var save_path: String = get_save_path(save_name)

    return write_save_to_path(save_path, save_data)


static func write_autosave(region_name: String, autosave_index: int, save_data: Dictionary) -> Dictionary:
    ensure_save_directory_exists()

    var save_path: String = get_autosave_path(region_name, autosave_index)

    return write_save_to_path(save_path, save_data)


static func write_save_to_path(save_path: String, save_data: Dictionary) -> Dictionary:
    var write_data: Dictionary = save_data.duplicate(true)
    write_data[KEY_UPDATED_UNIX_TIME] = Time.get_unix_time_from_system()

    var json_text: String = JSON.stringify(write_data, "\t")

    var file := FileAccess.open(save_path, FileAccess.WRITE)

    if file == null:
        var error: Error = FileAccess.get_open_error()

        return {
            "success": false,
            "path": save_path,
            "message": "Failed to open save file for writing. Error: " + str(error)
        }

    file.store_string(json_text)
    file.close()

    return {
        "success": true,
        "path": save_path,
        "message": "Saved game to: " + save_path
    }


static func read_save(save_name: String) -> Dictionary:
    var save_path: String = get_save_path(save_name)

    return read_save_from_path(save_path)


static func read_save_from_path(save_path: String) -> Dictionary:
    if not FileAccess.file_exists(save_path):
        return {
            "success": false,
            "path": save_path,
            "message": "Save file does not exist."
        }

    var file := FileAccess.open(save_path, FileAccess.READ)

    if file == null:
        var error: Error = FileAccess.get_open_error()

        return {
            "success": false,
            "path": save_path,
            "message": "Failed to open save file for reading. Error: " + str(error)
        }

    var json_text: String = file.get_as_text()
    file.close()

    var json := JSON.new()
    var parse_error: Error = json.parse(json_text)

    if parse_error != OK:
        return {
            "success": false,
            "path": save_path,
            "message": "Failed to parse save JSON. Error: " + str(parse_error)
        }

    var parsed_data: Variant = json.data

    if typeof(parsed_data) != TYPE_DICTIONARY:
        return {
            "success": false,
            "path": save_path,
            "message": "Save file did not contain a dictionary."
        }

    return {
        "success": true,
        "path": save_path,
        "message": "Loaded save file: " + save_path,
        "data": parsed_data
    }


static func list_save_files() -> Array:
    ensure_save_directory_exists()

    var save_files: Array = []
    var directory := DirAccess.open(SAVE_DIRECTORY)

    if directory == null:
        return save_files

    directory.list_dir_begin()

    while true:
        var file_name: String = directory.get_next()

        if file_name == "":
            break

        if directory.current_is_dir():
            continue

        if not file_name.ends_with(SAVE_EXTENSION):
            continue

        save_files.append(file_name)

    directory.list_dir_end()
    save_files.sort()

    return save_files
    
static func get_save_path_from_file_name(file_name: String) -> String:
    return SAVE_DIRECTORY + "/" + file_name


static func get_save_modified_time(save_path: String) -> int:
    if not FileAccess.file_exists(save_path):
        return 0

    return int(FileAccess.get_modified_time(save_path))


static func list_save_file_infos() -> Array:
    ensure_save_directory_exists()

    var save_file_infos: Array = []
    var save_files: Array = list_save_files()

    for file_index in range(save_files.size()):
        var file_name: String = str(save_files[file_index])
        var save_path: String = get_save_path_from_file_name(file_name)

        save_file_infos.append({
            "file_name": file_name,
            "path": save_path,
            "modified_time": get_save_modified_time(save_path)
        })

    save_file_infos.sort_custom(_sort_save_infos_newest_first)

    return save_file_infos


static func _sort_save_infos_newest_first(a: Dictionary, b: Dictionary) -> bool:
    return int(a.get("modified_time", 0)) > int(b.get("modified_time", 0))


static func read_most_recent_save() -> Dictionary:
    var save_file_infos: Array = list_save_file_infos()

    if save_file_infos.is_empty():
        return {
            "success": false,
            "path": "",
            "message": "No save files found."
        }

    var newest_save: Dictionary = save_file_infos[0]
    var save_path: String = str(newest_save.get("path", ""))

    return read_save_from_path(save_path)
    
static func delete_save_file(file_name: String) -> Dictionary:
    ensure_save_directory_exists()

    var safe_file_name: String = file_name.strip_edges()

    if safe_file_name == "":
        return {
            "success": false,
            "path": "",
            "message": "Delete failed. Empty save file name."
        }

    if safe_file_name.contains("/") or safe_file_name.contains("\\"):
        return {
            "success": false,
            "path": "",
            "message": "Delete failed. Invalid save file name."
        }

    if not safe_file_name.ends_with(SAVE_EXTENSION):
        return {
            "success": false,
            "path": "",
            "message": "Delete failed. Save file must end with " + SAVE_EXTENSION + "."
        }

    var save_path: String = get_save_path_from_file_name(safe_file_name)

    if not FileAccess.file_exists(save_path):
        return {
            "success": false,
            "path": save_path,
            "message": "Delete failed. Save file does not exist."
        }

    var error: Error = DirAccess.remove_absolute(save_path)

    if error != OK:
        return {
            "success": false,
            "path": save_path,
            "message": "Delete failed. Error: " + str(error)
        }

    return {
        "success": true,
        "path": save_path,
        "message": "Deleted save file: " + safe_file_name
    }


static func is_valid_save_file_name(file_name: String) -> bool:
    var safe_file_name: String = file_name.strip_edges()

    if safe_file_name == "":
        return false

    if safe_file_name.contains("/") or safe_file_name.contains("\\"):
        return false

    return safe_file_name.ends_with(SAVE_EXTENSION)
