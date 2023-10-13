extends Camera2D

# Explain


func _unhandled_input(event):	
	if event.is_action_pressed("resetZoom"):
		self.zoom = Vector2(1,1)
		
		
	elif event.is_action_pressed("zoomIn"):
		self.zoom += Vector2(0.1, 0.1)
	
	elif event.is_action_pressed("zoomOut"):
		self.zoom -= Vector2(0.1, 0.1)
		
