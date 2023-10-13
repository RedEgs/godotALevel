extends TileMap


# adjust values 
# change vars and styles
var moisture = FastNoiseLite.new()
var temperature = FastNoiseLite.new()
var altitude = FastNoiseLite.new()

@export var chunkSize: int = 128

@export var player : CharacterBody2D


func _ready():
	moisture.seed = randi()
	temperature.seed = randi()
	altitude.seed = randi()


func _process(delta):
	generateChunk(player.position)

func generateChunk(position):
	var tilePos = local_to_map(position)
	
	for x in range(chunkSize):
		for y in range(chunkSize):
			var moist = moisture.get_noise_2d(tilePos.x-chunkSize/2 + x, tilePos.y-chunkSize/2 + y )*10
			var temp = temperature.get_noise_2d(tilePos.x-chunkSize/2 + x, tilePos.y-chunkSize/2  + y )*10
			var alt = altitude.get_noise_2d(tilePos.x-chunkSize/2 + x, tilePos.y-chunkSize/2  + y )*10
			
			set_cell(0, Vector2i(tilePos.x-chunkSize/2 + x, tilePos.y-chunkSize/2  + y), 1, Vector2(round((moist+10)/5), round((temp+10)/5)))
			#set_cell(0, Vector2i(tilePos.x-scale/2 + x, tilePos.y-scale/2  + y), 1, Vector2i(1,1))
