draw_self();

if (place_meeting(x, y, oMain)) {
    draw_text(x, y - 20, "Press Enter to interact"); // Show interaction prompt
}

if (text_box_active) {
    draw_set_color(c_black);
    draw_rectangle(50, 50, 300, 100, false); // Draw text box background
    draw_set_color(c_white);
	draw_set_font(font_normal)
    draw_text(60, 60, "You can now swim!"); // Draw text

    text_box_timer--;
    if (text_box_timer <= 0) {
        text_box_active = false; // Hide text box after timer runs out
    }
}