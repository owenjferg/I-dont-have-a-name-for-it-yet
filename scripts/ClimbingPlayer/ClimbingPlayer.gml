function ClimbingPlayer() {


    // Check if we should release from wall (manual release or jump)
    if (!climb.key_climb || jump.key_jump) {
        player.state = PLAYERSTATE.Free;
        climb.climbing = false;
        climb.cooldown = 15; // Set cooldown timer
        climb.stamina = max(climb.stamina, 0); // Ensure stamina doesn't go below 0

        if (jump.key_jump) {
            movement.hsp = -climb.dir * climb.jump_force; // Apply horizontal jump force
            movement.vsp = -movement.jumpspeed; // Apply vertical jump force
            jump.jumps = 0; // Reset jumps after wall jump
        }
        return;
    }

    // Check if stamina has run out
    if (climb.stamina <= 0) {
        player.state = PLAYERSTATE.Sliding; // Transition to sliding state
        climb.climbing = false;
        return;
    }

    // Vertical movement
    movement.vsp = (input.down - input.up) * climb.speed;

    // Vertical collision
    if (place_meeting(x, y + movement.vsp, oWall)) {
        while (!place_meeting(x, y + sign(movement.vsp), oWall)) {
            y += sign(movement.vsp);
        }
        movement.vsp = 0;
    }
    y += movement.vsp;

    // Horizontal stick to wall
    if (!place_meeting(x + climb.dir, y, oWall)) {
        x += climb.dir;
        if (!place_meeting(x + climb.dir, y, oWall)) {
            player.state = PLAYERSTATE.Free;
            climb.climbing = false;
            climb.cooldown = 15; // Set cooldown timer
            return;
        }
    }

    // Update stamina
    climb.stamina--;
	if (player.state == PLAYERSTATE.Free) {
		climb.stamina = climb.stamina_max;
	}
    movement.hsp = 0; // Prevent horizontal movement
}