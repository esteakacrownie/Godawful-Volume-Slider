extends Node2D

const filling_rate := 0.2
const loss := 0.1
var level := 0.0
const opened := 90.0


func _process(delta: float) -> void:
	
	$Bucket/inner.material.set_shader_parameter("fill_threshold", level)
	$Bucket/drops.emitting = level > 0
	
	var pressed = $pipe/valve/button.is_pressed()
	
	$pipe/stream.visible = pressed
	
	if pressed:
		level = min(level + filling_rate * delta, 1.0)
		$pipe/valve.rotation_degrees = lerp($pipe/valve.rotation_degrees, opened, 2.5 * delta)
	else:
		$pipe/valve.rotation_degrees = lerp($pipe/valve.rotation_degrees, 0.0, 2.5 * delta)
	
	level = max(level - loss * delta, 0.0)
	
	$pipe/percent.text = str(int(round(level * 100))) + "%"
	
	$water_sink.volume_linear = level
