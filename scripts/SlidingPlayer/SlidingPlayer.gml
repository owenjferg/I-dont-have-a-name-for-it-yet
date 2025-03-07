function SlidingPlayer() {


    // If the player releases the climb A ADADWASDASADADADDDDDDDDDDD, exit sliding state
    if (!climb.key_climb) {
        player.state = PLAYERSTATE.Free;
        return;
    }

    // Slide down the wall
    movement.vsp = climb.slide_speed;

    // Check if player has touched the ground
	var _grounded = place_meeting(x, y + 1, oWall);
	if (_grounded) {
    // Snap the player to the ground to avoid floating
    while (!place_meeting(x, y + 1, oWall)) {
        y += 1;
    }
}

    // Allow the player to jump off the wall while sliding
    if (jump.key_jump) {
        movement.hsp = -climb.dir * climb.jump_force;
        movement.vsp = -movement.jumpspeed;
        player.state = PLAYERSTATE.Free;
        jump.jumps = 0; // Force jumps to 0 after sliding jump
        climb.cooldown = 15; // Set cooldown timer
        return;
    }

    // Allow the player to re-grab the wall if they press the climb key and have cooldown
    if (climb.key_climb && climb.cooldown <= 0 && climb.stamina > 0) {
        player.state = PLAYERSTATE.Climbing;
        climb.climbing = true;
        return;
    }

    // Horizontal stick to wall
    if (!place_meeting(x + climb.dir, y, oWall)) {
        x += climb.dir;
        if (!place_meeting(x + climb.dir, y, oWall)) {
            player.state = PLAYERSTATE.Free;
            climb.cooldown = 15; // Set cooldown timer
            return;
        }
    }

    // Vertical collision
    if (place_meeting(x, y + movement.vsp, oWall)) {
        while (!place_meeting(x, y + sign(movement.vsp), oWall)) {
            y += sign(movement.vsp);
        }
        movement.vsp = 0;
    }
    y += movement.vsp;
}