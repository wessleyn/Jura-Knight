extends CanvasLayer

@onready var score_label: Label = $ScoreLabel

var score = 0
var coins = 0

func _ready():
	 # initialize the current high score on game start
	updateScore()
	
func updateScore ():
	score_label.text = "Highest Score: " + str(Global.high_score) + "\nScore: " + str(score)  +  "\nCoins: " + str(coins) 
	
func addPoint():
	score += 1
	if score >= Global.high_score:
		setHighestScore()
		
	updateScore()

func addCoin():
	coins += 1
	addPoint()
	
func setHighestScore():
	Global.high_score = score
