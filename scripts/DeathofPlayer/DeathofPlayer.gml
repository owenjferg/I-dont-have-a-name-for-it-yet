function DeathofPlayer() {
    // Stop drawing the player's sprite
    player.draw_player = false;

    // Initialize death sequence if not already started
    if (!death.started) {
        death.started = true;
        death.alpha = 0;
        death.time = game_get_speed(gamespeed_fps) * 2; // Fade duration (2 seconds)
    }

    // Gradually increase the fade effect
    if (death.alpha < 1) {
        death.alpha += 1 / death.time;
    }
}