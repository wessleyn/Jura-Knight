extends CanvasLayer

@onready var score_label: Label = $ScoreLabel
@onready var coin_label: Label = $"Coin Label"
@onready var thirst_bar: TextureProgressBar = $ThirstBar
@onready var health_bar: TextureProgressBar = $HealthBar

var score = 0
var coins = 0
var health = 50
var thirst = 0

func _ready():
	updateScore()
	updateStats()

func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("exit")):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
		
func updateScore ():
	score_label.text = "Highest Score: %d\nScore: %d" % [
		int(Global.high_score), int(score)
	]

func updateStats():
	health_bar.value = int(health)
	thirst_bar.value = int(thirst)
	coin_label.text = str(coins)

func addPoint(point):
	score += point
	if score >= Global.high_score: Global.high_score = score
	updateScore()

func addCoin():
	coins += 1
	addPoint(5)
	updateStats()

func increaseThirst(point):
	thirst += point
	Global.Knight_SPEED -= point 
	updateStats()
	
func relieveThirst(point):
	thirst -= point
	Global.Knight_SPEED += point
	updateStats()
	
func takeDamage(point, body):
	health -= point
	updateStats()
	if(health <= 0): 
		body.getKilled()
	
func takeHealing(point):
	health += point
	updateStats()
