extends CanvasLayer

@onready var score_label: Label = $ScoreLabel
@onready var game_over: Label = $GameOver

var score = 0
var coins = 0
var HighestScore = 0

func updateScore (score, coin, HighestScore):
	score_label.text = "Highest Score: " + str(HighestScore) + "\nScore: " + str(score)  +  "\nCoins: " + str(coins) 
	
func addPoint():
	score += 1
	if score >= HighestScore:
		setHighestScore()
		
	updateScore(score, coins, HighestScore)

func addCoin():
	coins += 1
	addPoint()
	
func setHighestScore():
	HighestScore = score
