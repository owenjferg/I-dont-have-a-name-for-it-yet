// If the player is dead (global.playerhp == 0)
if (global.playerhp == 0)
{
     // Set the font for the "You Died" text
    draw_set_font(font_death);  // Replace 'font_death' with the actual font name you created
    
    // Set text color (optional)
    draw_set_color(c_red);

    // Set alpha for the fade effect
    draw_set_alpha(global.death_alpha);  // Apply fade effect

    // Calculate the width of the text
    var text_width = string_width("You Died");
    
    // Calculate the X position to center the text
    var center_x = (room_width / 2) - (text_width / 2);
    
    // Calculate the Y position to center the text
    var center_y = room_height / 2;
    
    // Draw the "You Died" message in the center of the screen
    draw_text(center_x, center_y, "You Died");
    // Wait for the player to press a key to continue
    if (keyboard_check_pressed(vk_space))  // You can change vk_space to any key you like
    {
        // Optionally, reset variables or take action
        global.playerhp = 5;  // Reset the player's health (or any other action)
        room_goto(Room1);  // Transition to another room or reset the current room
		oMain.x = 100
		oMain.y = 100
    }
}
else
{
    // If the player is alive, draw the player sprite (or other things)
    draw_self();  // Draw the regular player sprite
}
