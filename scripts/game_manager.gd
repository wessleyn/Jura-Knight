extends CanvasLayer

@onready var score_label: Label = $ScoreLabel
@onready var coin_label: Label = $"Coin/Coin Label"
@onready var health_bar: TextureProgressBar = $ProgressBars/Health
@onready var thirst_bar: TextureProgressBar = $ProgressBars/Thirst

var score = 0
var coins = 0
var health = 100
var thirst = 0

func _ready():
	updateScore()
	updateStats()
	
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
	if(health >= 0): pass # TODO: hange health bar from green to purple
	updateStats()
