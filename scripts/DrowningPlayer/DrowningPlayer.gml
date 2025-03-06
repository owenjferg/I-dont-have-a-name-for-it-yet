function DrowningPlayer(_damage, _invulnerable){
	if (!global.can_swim) 
	{
		//player cant swim sink
		vsp += grav; // apply gravity to make player sink
		grav = 1
		hsp = 0;
		movespeed = 0.1;
		global.playerhp -= _damage;
		invincible = true;
		alarm[1] = _invulnerable;
	}
}