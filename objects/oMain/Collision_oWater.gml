if (!water.in_water)
{
	water.in_water = true;
}


if (knockback.invincible == false)
{
	if (!water.can_swim) 
	{
		DrowningPlayer(0.5, game_get_speed(gamespeed_fps));
	}
	else
	{
		SwimmingPlayer();
	}
}