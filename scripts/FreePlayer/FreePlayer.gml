function FreePlayer() {
    // Horizontal Movement Input

    movement.hsp = movement.move * movement.movespeed;

    // Apply gravity if not on the ground
    if (!place_meeting(x, y + 1, oWall)) {
        movement.vsp += movement.grav;
    } else {
        movement.vsp = 0; // Stop falling if on the ground
    }

// Jumping (Ground)
   
    if (jump.key_jump && place_meeting(x, y + 1, oWall)) {
        movement.vsp = -movement.jumpspeed;
        jump.jumps = jump.jumpsmax - 1;
    }

    // Double Jump (Mid-Air) - Add check for climbing state
    if (
        jump.key_jump && 
        !place_meeting(x, y + 1, oWall) && 
        jump.jumps > 0 && 
        player.state != PLAYERSTATE.Climbing // Block double jump while climbing
    ) {
        movement.vsp = -movement.jumpspeed;
        jump.jumps--;
    }

    // Wall Grab Check
    if (climb.cooldown <= 0 && climb.key_climb && !place_meeting(x, y + 1, oWall)) {
        var left_wall = place_meeting(x - 1, y, oWall);
        var right_wall = place_meeting(x + 1, y, oWall);

        if (left_wall || right_wall) {
            climb.dir = left_wall ? -1 : 1;
            player.state = PLAYERSTATE.Climbing;
            climb.climbing = true;
            jump.jumps = 1; // Optional: Reset jumps to 1 if needed
            movement.vsp = 0;
        }
    }


    // Horizontal Collision
    if (place_meeting(x + movement.hsp, y, oWall)) {
        while (!place_meeting(x + sign(movement.hsp), y, oWall)) {
            x += sign(movement.hsp);
        }
        movement.hsp = 0;
    }
    x += movement.hsp;

    // Vertical Collision
    if (place_meeting(x, y + movement.vsp, oWall)) {
        while (!place_meeting(x, y + sign(movement.vsp), oWall)) {
            y += sign(movement.vsp);
        }
        movement.vsp = 0;
    }
    y += movement.vsp;

    // Ensure keyAttack exists before using it
    if (attack.keyAttack) {
        player.state = PLAYERSTATE.Attack_Slash;
    }
	
	// Ensure player can transition to swimming state
	if (water.in_water) {
    player.state = PLAYERSTATE.Swimming;
}
}