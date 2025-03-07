function SwimmingPlayer() {
    if (water.can_swim) {
        // Player can swim
        water.fish_player = true;          // Enable fish form
        movement.movespeed = movement.No_effect_movespeed * 2; // 
        movement.grav = 0.2;               // Reduce gravity in water
        movement.vsp = 0;
        water.canDash = true;
        alarm[0] = 1;                      // Reset swimming frames
        
        // Check if the player can dash and the dash key is pressed
        if (water.canDash && water.keyDash) {
            water.canDash = false;
            water.dashDirection = point_direction(0, 0, input.right - input.left, input.down - input.up);
			// Add this to ensure dash direction is locked when E is pressed:
			water.dashDirection = point_direction(0, 0, input.right - input.left, input.down - input.up);
            water.dashSp = water.dashDistance / water.dashTime;
            DashingPlayer();  // Call the DashingPlayer function
        }
    }
	if (!water.in_water) {
	    player.state = PLAYERSTATE.Free; // Exit water state immediately
	    movement.vsp = 0; // Cancel any residual vertical speed
	}
}