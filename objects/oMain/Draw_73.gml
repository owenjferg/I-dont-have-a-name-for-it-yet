// oMain - Draw Event (Draw_73.gml)
if (player.hp <= 0) {
    DeathofPlayer(); // Update fade logic

    // Save current draw settings
    var prev_font = draw_get_font();
    var prev_color = draw_get_color();
    var prev_alpha = draw_get_alpha();

    // Configure settings for "You Died" text
    draw_set_font(font_death);
    draw_set_color(c_red);
    draw_set_alpha(death.alpha);

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
   // oMain - Draw Event (Draw_73.gml)
	if (keyboard_check_pressed(vk_space)) {
	    player.hp = player.hp_max; // Reset health
	    room_goto(Room1); // Restart the room (replace Room1 with your starting room)
	    oMain.x = position.start_x; // Reset player position
	    oMain.y = position.start_y; // Reset player position
	    // Reset death variables
	    death.started = false;
	    death.alpha = 0;
	}
    }
else {
    // Draw player normally when alive
    draw_self();
}