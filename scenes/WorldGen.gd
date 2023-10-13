extends TileMap


# adjust values 
# change vars and styles
var moisture = FastNoiseLite.new()
var temperature = FastNoiseLite.new()
var altitude = FastNoiseLite.new()

@export var chunkSize: int = 128
@export var biomeScale: int = 5
@export	var monitorDistance: int = 1  # 1 chunk in each direction 

@export var player : CharacterBody2D
@export var label : Label
@export var label2 : Label

func _ready():
	moisture.seed = randi()
	temperature.seed = randi()
	altitude.seed = randi()
	
	generateChunk(player.position)


func _process(delta):
	checkChunkBounds(getChunkingPos(player.position))






func checkChunkBounds(currentChunk):	
	for dx in range(-monitorDistance, monitorDistance + 1):
		for dy in range(-monitorDistance, monitorDistance + 1):
			# Calculate the position of the chunk to monitor
			var targetChunk = currentChunk + Vector2i(dx, dy)
			
			# Define a perimeter size (adjust as needed)
			var perimeterSize = chunkSize  # 32 units from the chunk's boundaries
			
			if player.position.length() == targetChunk.length():
				# Player is within the chunk's perimeter
				generateChunk(targetChunk)
			else:
				# Player is outside the chunk's perimeter
				pass

	
	


func getChunkingPos(position):
	var tilePos = local_to_map(position)
	
	
	var chunkingPosX = (int(tilePos.x) / chunkSize)
	var chunkingPosY = (int(tilePos.y) / chunkSize)

	var chunkingPos = Vector2i(chunkingPosX, chunkingPosY)
	var prevchunkingPos = Vector2i(0,0)
	
	
	label2.text = str(position)
	label.text = str(chunkingPos)
	
	if player.position.x < 0:
		chunkingPosX -= 1
	if player.position.y
	
	
func generateChunk(position):
	var tilePos = local_to_map(position)
	
	for x in range(chunkSize):
		for y in range(chunkSize):
			var moist = moisture.get_noise_2d(tilePos.x-chunkSize/2 + x, tilePos.y-chunkSize/2 + y )*biomeScale
			var temp = temperature.get_noise_2d(tilePos.x-chunkSize/2 + x, tilePos.y-chunkSize/2  + y )*biomeScale
			var alt = altitude.get_noise_2d(tilePos.x-chunkSize/2 + x, tilePos.y-chunkSize/2  + y )*biomeScale
			
			set_cell(0, Vector2i(tilePos.x-chunkSize/2 + x, tilePos.y-chunkSize/2  + y), 1, Vector2(round((moist+10)/5), round((temp+10)/5)))
			#set_cell(0, Vector2i(tilePos.x-scale/2 + x, tilePos.y-scale/2  + y), 1, Vector2i(1,1))
