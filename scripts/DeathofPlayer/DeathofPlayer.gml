function DeathofPlayer() {
    // Stop drawing the player's sprite by not calling draw_self() when dead
    sprite_index = -1;

    if (!death_started) {
        death_started = true;
        death_alpha = 0;
        death_time = game_get_speed(gamespeed_fps) * 2;
    }

    if (death_alpha < 1) {
        death_alpha += 1 / death_time;
    }
}