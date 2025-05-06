extends GutTest

var player

func before_each():
	player = load("res://scritps/player.gd").new()  # Oder .instantiate() bei Szenen

func after_each():
	player.queue_free()

func test_take_damage_emits_health_changed():
	var received_args := []

	player.health = 5.0
	player.health_changed.connect(func(change_type, new_health):
		received_args.append_array([change_type, new_health])
	)

	player.take_damage(2.0)

	assert_gt(received_args.size(), 0, "Signal wurde nicht emittiert.")
	assert_eq(received_args[0], "damage")
	assert_eq(received_args[1], 3.0)

func test_heal_emits_health_changed():
	var received_args := []

	player.health = 3.0
	player.health_changed.connect(func(change_type, new_health):
		received_args.append_array([change_type, new_health])
	)

	player.heal(1.0)

	assert_gt(received_args.size(), 0, "Signal wurde nicht emittiert.")
	assert_eq(received_args[0], "heal")
	assert_eq(received_args[1], 4.0)

func test_health_does_not_exceed_max():
	player.health = 5.0
	player.heal(1.0)
	assert_eq(player.health, 5.0, "Health sollte nicht über 5 steigen.")

func test_health_does_not_go_below_zero():
	player.health = 1.0
	player.take_damage(5.0)
	assert_eq(player.health, 0.0, "Health sollte nicht unter 0 fallen.")
