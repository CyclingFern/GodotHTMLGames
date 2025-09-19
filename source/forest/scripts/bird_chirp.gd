extends AudioStreamPlayer3D

# Play the assigned AudioStream at random intervals.
# Exported properties allow tuning from the editor.
@export_range(0.1, 60.0, 0.1)
var min_interval: float = 5.0

@export_range(0.1, 600.0, 0.1)
var max_interval: float = 20.0

var _rng: RandomNumberGenerator

func _ready() -> void:
	_rng = RandomNumberGenerator.new()
	_rng.randomize()
	# Start the background loop
	_play_random_loop()

func _play_random_loop() -> void:
	# Use an asynchronous loop that waits for a timer between plays.
	# This keeps the node responsive and avoids blocking the main thread.
	while is_inside_tree():
		var delay = _rng.randf_range(min_interval, max_interval)
		await get_tree().create_timer(delay).timeout

		# If already playing, skip this play to avoid overlap.
		if not playing:
			play()
			# Optionally wait until finished before continuing, or allow overlapping by removing this await.
			await self.finished
