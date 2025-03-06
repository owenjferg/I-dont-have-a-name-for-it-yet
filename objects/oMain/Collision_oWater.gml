if (!in_water)
{
	in_water = true;
}


if (invincible == false)
{
	if (!global.can_swim) 
	{
		DrowningPlayer(0.5, game_get_speed(gamespeed_fps));
	}
	else
	{
		SwimmingPlayer()
	}
}