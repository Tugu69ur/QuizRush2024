extends Node

var client = null
var session = null
var socket = null

var level_custom_data = {
	"selected_map": null,
	"selected_char": null,
	"selected_mode": null,
	"question": null,
	"gameplay": null,
	"map_name": null,
	"round": null,
	"question_num": null,
	"questions": null
}

func _ready():
	print(level_custom_data)
func initialize_nakama(client_obj, session_obj, socket_obj):
	client = client_obj
	session = session_obj
	socket = socket_obj
func send_level_data_to_nakama():
	# List existing storage objects in the "Levels" collection for the user
	var dataList = await client.list_storage_objects_async(session, "Levels", session.user_id, 5)
	var objects = dataList.objects
	var json_parser = JSON.new()
	var questions_list = []  # Ensure this is an array

	# Parse existing storage objects to retrieve questions
	for obj in objects:
		var parse_result = json_parser.parse(obj.value)
		if parse_result == OK:
			var data = json_parser.data  # Parsed data from the storage
			if data.has("Levels"):
				# Check if data["Levels"] is an array, convert it if necessary
				if data["Levels"] is Array:
					questions_list = data["Levels"]  # Get existing questions (if an array)
				else:
					# If "Levels" is not an array, wrap it into one
					questions_list = [data["Levels"]]

	# Add the new level data to the questions list
	questions_list.append(NakamaManager.level_custom_data)

	# Prepare the new data to write back to Nakama
	var json_data = {
		"Levels": questions_list
	}
	var level_data_json = JSON.stringify(json_data)

	var write_result = await client.write_storage_objects_async(session, [
	NakamaWriteStorageObject.new("Levels", "Levels", 1, 1, level_data_json, "")
	])

	if write_result:
		print("Level data successfully sent to Nakama.")
	else:
		print("Failed to send level data.")

