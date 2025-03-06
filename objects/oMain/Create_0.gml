//Initialise Variables
grav = 0.2; //gravity
// Horizontal and Vertical Speed
hsp = 0; //set to 0 as it is the current speed 
vsp = 0; 

jumpspeed = 7; 

movespeed = 4; 

jumps = 0;

jumpsmax = 1;

has_doublejump_item = false;

climb_cooldown = 0; // Cooldown timer after climbing ends

slide_speed = 2; // Speed at which the player slides down the wall


StateFree = function() {
    var key_right = keyboard_check(ord("D"));
    var key_left = -keyboard_check(ord("A"));
    var key_jump = keyboard_check_pressed(vk_space);

    // React to inputs
    var move = key_left + key_right;
    hsp = move * movespeed;
    if (vsp < 10) vsp += grav;

    // If player is on the ground, reset jumps and climb stamina
    if (place_meeting(x, y+1, oWall)) {
        jumps = jumpsmax; // Reset jumps to jumpsmax (1 or 2)
        climb_stamina = climb_stamina_max; // Reset stamina when grounded
    }

    // Make player jump with key
    if (key_jump && jumps > 0) {
        jumps -= 1;
        vsp = -jumpspeed;
    }

    // Grant double jump
    if (place_meeting(x+1, y+1, oAppleguy)) {
        has_doublejump_item = true;
        instance_destroy(oAppleguy);
        jumpsmax = 2; // Set jumpsmax to 2 if the player picks up the double jump item
    }

    // Wall grab check (only if climb cooldown is 0)
    if (climb_cooldown <= 0 && keyboard_check(vk_shift) && !place_meeting(x, y+1, oWall)) {
        var left_wall = place_meeting(x-1, y, oWall);
        var right_wall = place_meeting(x+1, y, oWall);

        if (left_wall || right_wall) {
            climb_dir = left_wall ? -1 : 1;
            state = StateClimbing;
            climbing = true;
            jumps = 1; // Reset jumps to 1 when grabbing a wall
            vsp = 0; // Cancel vertical momentum
        }
    }

    // Collision Horizontal
    if (place_meeting(x+hsp, y, oWall)) {
        while (!place_meeting(x+sign(hsp), y, oWall)) {
            x += sign(hsp);
        }
        hsp = 0;
    }
    x += hsp;

    // Collision Vertical
    if (place_meeting(x, y+vsp, oWall)) {
        while (!place_meeting(x, y+sign(vsp), oWall)) {
            y += sign(vsp);
        }
        vsp = 0;
    }
    y += vsp;
}

state = StateFree;

// Climbing variables
climb_speed = 3;
climb_jump_force = 5;
climbing = false;
climb_dir = 0; // -1 for left wall, 1 for right wall
climb_stamina_max = 90;
climb_stamina = climb_stamina_max;
can_grab = true; // cooldown to prevent immediate regrab

StateClimbing = function() {
    var key_climb = keyboard_check(vk_shift);
    var key_up = keyboard_check(ord("S")); // S moves up
    var key_down = keyboard_check(ord("W")); // W moves down
    var key_jump = keyboard_check_pressed(vk_space);

    // Check if we should release from wall (manual release or jump)
    if (!key_climb || key_jump) {
        state = StateFree;
        climbing = false;
        climb_cooldown = 15; // Set cooldown timer
        if (key_jump) {
            hsp = -climb_dir * climb_jump_force;
            vsp = -jumpspeed;
            jumps = 1; // Reset jumps to 1 after wall jump
        }
        return;
    }

    // Check if stamina has run out
    if (climb_stamina <= 0) {
        state = StateSliding; // Transition to sliding state
        climbing = false;
        return;
    }

    // Vertical movement (swapped W and S)
    vsp = (key_down - key_up) * climb_speed; // Now S moves up, W moves down

    // Vertical collision
    if (place_meeting(x, y+vsp, oWall)) {
        while (!place_meeting(x, y+sign(vsp), oWall)) {
            y += sign(vsp);
        }
        vsp = 0;
    }
    y += vsp;

    // Horizontal stick to wall
    if (!place_meeting(x + climb_dir, y, oWall)) {
        x += climb_dir;
        if (!place_meeting(x + climb_dir, y, oWall)) {
            state = StateFree;
            climbing = false;
            climb_cooldown = 15; // Set cooldown timer
            return;
        }
    }

    // Update stamina
    climb_stamina--;
    hsp = 0; // Prevent horizontal movement
}

StateSliding = function() {
    var key_climb = keyboard_check(vk_shift);
    var key_jump = keyboard_check_pressed(vk_space);

    // If the player releases the climb key, exit sliding state
    if (!key_climb) {
        state = StateFree;
        return;
    }

    // Slide down the wall
    vsp = slide_speed;

    // Check if player has touched the ground
    if (place_meeting(x, y+1, oWall)) {
        state = StateFree;
        climb_stamina = climb_stamina_max; // Reset stamina when grounded
        return;
    }

    // Allow the player to jump off the wall while sliding
    if (key_jump) {
        hsp = -climb_dir * climb_jump_force;
        vsp = -jumpspeed;
        state = StateFree;
        jumps = jumpsmax;
        climb_cooldown = 15; // Set cooldown timer
        return;
    }

    // Allow the player to re-grab the wall if they press the climb key and have cooldown
    if (key_climb && climb_cooldown <= 0 && climb_stamina > 0) {
        state = StateClimbing;
        climbing = true;
        return;
    }

    // Horizontal stick to wall
    if (!place_meeting(x + climb_dir, y, oWall)) {
        x += climb_dir;
        if (!place_meeting(x + climb_dir, y, oWall)) {
            state = StateFree;
            climb_cooldown = 15; // Set cooldown timer
            return;
        }
    }

    // Vertical collision
    if (place_meeting(x, y+vsp, oWall)) {
        while (!place_meeting(x, y+sign(vsp), oWall)) {
            y += sign(vsp);
        }
        vsp = 0;
    }
    y += vsp;
}
	
	
	
	
	