extends Camera2D

# Explain


func _unhandled_input(event):
	var tween = create_tween()
	
	if event.is_action_pressed("resetZoom"):
		tween.tween_property(self, "zoom", Vector2(.8,.8), .1)
		
		
	elif event.is_action_pressed("zoomIn"):
		tween.tween_property(self, "zoom", self.zoom - Vector2(0.15, 0.15), .1)
		
	
	elif event.is_action_pressed("zoomOut"):
		tween.tween_property(self, "zoom", self.zoom + Vector2(0.15, 0.15), .1)
		
