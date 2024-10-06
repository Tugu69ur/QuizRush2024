extends Node

var COLLECTION_ID = "Status"

@export var quiz: QuizTheme
@export var color_right: Color
@export var color_wrong: Color

var buttons: Array[Button]
var index: int = 0
var correct: int = 0

var current_quiz: QuizRush:
	get: return quiz.theme[index]
	

@onready var question_text: Label = $Control/qInfo/QuestionText
@onready var question_image: TextureRect = $Control/qInfo/imageHolder/questionImage

func _ready():
	for button in buttons:
		button.visible = false
		button.disabled = true
	get_tree().paused = false
	$Timer.start()
	
func _on_timer_timeout():
	
	get_tree().paused = true
	$Control.visible= true
	for button in buttons:
		button.visible = true
		button.disabled = false
	correct=0
	for button in $Control/qHolder.get_children():
		buttons.append(button)
	load_quiz()
	
func load_quiz():
	if index >= quiz.theme.size(): 
		$Control.visible= false
		get_tree().paused = false
		
		print(correct)
		return
		
	question_text.text = current_quiz.question_info
	
	var options = current_quiz.options
	for i in buttons.size():
		buttons[i].text = options[i]
		buttons[i].pressed.connect(_buttons_answer.bind(buttons[i]))
	
	match current_quiz.type:
		Enum.qType.TEXT:
			$Control/qInfo/imageHolder.hide()
		Enum.qType.IMAGE:
			$Control/qInfo/imageHolder.show()
			question_image.texture = current_quiz.qImage
		
func _buttons_answer(button) ->void:
	if current_quiz.correct == button.text:
		button.modulate = color_right
		$Correct.play()
		correct+=1
	else:
		button.modulate = color_wrong
		$Incorrect.play()
	_next_quiz()
	
	
func _next_quiz() ->void:
	for bt in buttons:
		bt.pressed.disconnect(_buttons_answer)
		
	await get_tree().create_timer(2).timeout
	
	for bt in buttons:
		bt.modulate = Color.WHITE
		
	index += 1
	load_quiz()

	
func _on_button_pressed():
	get_tree().reload_current_scene()
	

func _on_logout_pressed():
	get_tree().change_scene_to_file("res://Scenes/Authentication.tscn")
