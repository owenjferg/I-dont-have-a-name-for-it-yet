function ClimbingPlayer() {
    var key_climb = keyboard_check(vk_shift);
    var key_up = keyboard_check(ord("W")); // W moves up
    var key_down = keyboard_check(ord("S")); // S moves down
    var key_jump = keyboard_check_pressed(vk_space);

    // Check if we should release from wall (manual release or jump)
    if (!key_climb || key_jump) {
        player.state = PLAYERSTATE.Free;
        climb.climbing = false;
        climb.cooldown = 15; // Set cooldown timer
        climb.stamina = max(climb.stamina, 0); // Ensure stamina doesn't go below 0

        if (key_jump) {
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
    movement.vsp = (key_down - key_up) * climb.speed;

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
    movement.hsp = 0; // Prevent horizontal movement
}