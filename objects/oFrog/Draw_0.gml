// Draw the frog sprite
draw_self();

// Check if the frog is interacting with the player
if (place_meeting(x, y, oMain)) {
    draw_set_font(font_normal);  // Set the frog's font to the normal font
    draw_set_color(c_white);  // Set the text color to white
    draw_text(x, y - 20, "Press Enter to interact"); // Show interaction prompt
}

// If the text box is active, display it
if (text_box_active) {
    // Draw the text box background
    draw_set_color(c_black);
    
    // Set the text box dimensions
    var box_width = 300;   // Width of the text box
    var box_height = 100;  // Height of the text box
    
    // Calculate the X position to center the box horizontally
    var box_x = (room_width - box_width) / 2;
    
    // Set the Y position to be at the bottom, with some padding
    var box_y = room_height - box_height - 20;  // 20px padding from the bottom
    
    // Draw the rectangle for the text box
    draw_rectangle(box_x, box_y, box_x + box_width, box_y + box_height, false);
    
    // Set the text color to white
    draw_set_color(c_white);
    
    // Set the font to the normal font
    draw_set_font(font_normal);
    
    // Calculate the position for the text inside the text box
    var text_x = box_x + 20;  // Padding from the left side
    var text_y = box_y + 20;  // Padding from the top side
    
    // Draw the text inside the text box
    draw_text(text_x, text_y, "You can now swim!");  // You can change the message as needed
    
    // Countdown for the text box to disappear
    text_box_timer--;
    if (text_box_timer <= 0) {
        text_box_active = false; // Hide the text box after the timer runs out
    }
}