if (player.draw_player) {
	draw_self();
}
	
	if knockback.invincible == true {
	sprite_index = sMain_Drowning;
	}
	else if water.fish_player == true {
	sprite_index = sMain_Swimming;
	}
	else if attack.playerattacking == true{
		sprite_index = sMain_Slash;
	}
	else
	sprite_index = sMain