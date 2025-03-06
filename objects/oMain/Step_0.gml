
state()

// Decrement cooldown timer
if (climb_cooldown > 0) {
    climb_cooldown--;
}


var key_interact = keyboard_check_pressed(vk_enter); //check if enter is pressed

if (key_interact) 
{
	var frog = instance_place(x, y, oFrog); // check if the player is near oFrog
	if (frog != noone) 	
	{
		oFrog.Interact();
	}
}




//end script for swimming/drowning Player when leaving water
if (in_water == true && !place_meeting(x, y, oWater))
{
	in_water = false;
	// reset movespeed & grav
	grav = 0.2; 
	movespeed = 4;
	
}


// Check if the player's health is 0
if (global.playerhp == 0)
{
    // Start the fade-in effect when the player dies
	DeathofPlayer()
}
else
{
    // Game is still active, so you can have other logic here
}
