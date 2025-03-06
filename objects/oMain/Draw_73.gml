if (global.playerhp == 0) {
    DeathofPlayer(); // Update fade logic

    // Save current draw settings
    var prev_font = draw_get_font();
    var prev_color = draw_get_color();
    var prev_alpha = draw_get_alpha();

    // Configure settings for "You Died" text
    draw_set_font(font_death);
    draw_set_color(c_red);
    draw_set_alpha(death_alpha);

    // Calculate centered position
    var text_width = string_width("You Died");
    var center_x = (room_width / 2) - (text_width / 2);
    var center_y = room_height / 2;

    // Draw the text
    draw_text(center_x, center_y, "You Died");

    // Restore previous draw settings to avoid affecting other objects
    draw_set_font(prev_font);
    draw_set_color(prev_color);
    draw_set_alpha(prev_alpha);

    // Restart on space press
    if (keyboard_check_pressed(vk_space)) {
        global.playerhp = 5;
        room_goto(Room1);
        oMain.x = 100;
        oMain.y = 100;
        // Reset death variables
        death_started = false;
        death_alpha = 0;
    }
} else {
    // Draw player normally when alive
    draw_self();
}