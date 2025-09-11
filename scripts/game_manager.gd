extends CanvasLayer

@onready var score_label: Label = $ScoreLabel
@onready var game_stats: Label = $GameStats

var score = 0
var coins = 0
var health = 100
var thirst = 0

func _ready():
	 # initialize the current high score on game start
	updateScore()
	
func updateScore ():
	score_label.text = "Highest Score: %d\nScore: %d" % [
		int(Global.high_score), int(score)
	]

func updateStats():
		game_stats.text = "Coins: %d\nHealth: %d\nThirst: %d" % [
		coins, int(health),  int(thirst)
	]

func addPoint(point):
	score += point
	if score >= Global.high_score: Global.high_score = score
	updateScore()

func addCoin():
	coins += 1
	addPoint(5)
	updateStats()

func increaseThirst(point):
	# TODO: slow down movement when thirst reaches 100
	thirst += point
	updateStats()
	
func relieveThirst(point):
	# TODO: increase movement speed as thirst  lowers
	thirst -= point
	updateStats()
	
func takeDamage(point):
	health -= point
	updateStats()
	if(health <= 0): pass #die
	
func takeHealing(point):
	health += point
	if(health >= 0): pass #change health bar from green to purple
	updateStats()
