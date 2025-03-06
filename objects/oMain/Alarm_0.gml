// Decrease player health by 0.5 every second

if (place_meeting(x, y, oWater)) 
{	
	if (!global.can_swim) 
	{
		global.playerhp -= 0.5;
		if (sprite_index == sMain)
	{
	    sprite_index = sMain_drowning;  // Change to the flashing red sprite
	}
	else
	{
	    sprite_index = sMain;  // Change back to the normal sprite
	}

	}
}
// Reset the alarm to trigger again after 1 second
alarm[0] = room_speed;
