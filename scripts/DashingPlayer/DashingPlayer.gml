function DashingPlayer() {
    // Move via dash
	movement.hsp = lengthdir_x(water.dashSp, water.dashDirection);
	movement.vsp = lengthdir_y(water.dashSp, water.dashDirection);   
	
    // End the dash
    water.dashEnergy -= 1; // Decrease by 1 per frame for longer dash
    if (water.dashEnergy <= 0) {
        movement.vsp = 0;
        movement.hsp = 0;
        water.canDash = true;  // Reset dash ability
        water.dashEnergy = 10; // Reset dash energy
    }
}