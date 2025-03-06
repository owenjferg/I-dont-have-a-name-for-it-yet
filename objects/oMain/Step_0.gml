
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


//If interacting with water
if (place_meeting(x, y, oWater)) 
{
	if (!global.can_swim) 
	{
		//player cant swim sink
		vsp += grav; // apply gravity to make player sink
		hsp = 0;
		movespeed = 0;
		// change sprite
		sprite_index = sMain_1
	

	}
	else 
	{
		// player can swim
		movespeed = 2;
		grav = 0.1;
	}
}
else 
{
	// movement on land
	movespeed = 4;
	grav = 0.2;
}

// Check if the player's health is 0
if (global.playerhp == 0)
{
    // Start the fade-in effect when the player dies
	sprite_index = -1
    if (!global.death_started)
    {
        global.death_started = true;  // Mark that the death sequence has started
        global.death_alpha = 0;  // Reset alpha (invisible)
        global.death_time = room_speed * 2;  // Fade duration
    }

    // Gradually increase alpha for fade-in effect
    if (global.death_alpha < 1)
    {
        global.death_alpha += 1 / global.death_time;  // Fade in over time
    }
}
else
{
    // Game is still active, so you can have other logic here
}
if (global.playerhp <= 0)
{
    // Make sure the player doesn’t keep flashing after death
    
    alarm[0] = -1;  // Stop the alarm from triggering if health reaches 0
}