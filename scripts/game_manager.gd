extends CanvasLayer

@onready var score_label: Label = $ScoreLabel

var score = 0
var coins = 0

func _ready():
	 # initialize the current high score on game start
	updateScore()
	
func updateScore ():
	score_label.text = "Highest Score: %d\nScore: %d\nCoins: %d" % [
		int(Global.high_score), int(score), coins
	]
func addPoint(point):
	score += point
	if score >= Global.high_score: Global.high_score = score

		
	updateScore()

func addCoin():
	coins += 1
	addPoint(5)
	
