// Handle player state logic
switch (player.state) {
    case PLAYERSTATE.Free: FreePlayer(); break;
    case PLAYERSTATE.Climbing: ClimbingPlayer(); break;
    case PLAYERSTATE.Sliding: SlidingPlayer(); break;
    case PLAYERSTATE.Attack_Slash: SlashAttackPlayer(); break;
    case PLAYERSTATE.Attack_Combo: ComboAttackPlayer(); break;
	case PLAYERSTATE.Swimming: SwimmingPlayer(); break;
}



// Horizontal Movement Input
input.right = keyboard_check(ord("D"));
input.left = -keyboard_check(ord("A"));
movement.move = input.left + input.right;
movement.hsp = movement.move * movement.movespeed;

// Vertical Movement Input
input.down = keyboard_check(ord("S"));
input.up = keyboard_check(ord("W"));

// Apply Knockback Forces
movement.hsp += knockback.hsp_knockback;
movement.vsp += knockback.vsp_knockback;

// Decay Knockback
knockback.hsp_knockback *= knockback.decay;
knockback.vsp_knockback *= knockback.decay;

// Speed Clamping
movement.hsp = clamp(movement.hsp, -movement.max_hsp, movement.max_hsp);
movement.vsp = clamp(movement.vsp, -movement.max_vsp, movement.max_vsp);

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

// Jumping System
jump.key_jump = keyboard_check_pressed(vk_space);
if (jump.key_jump && place_meeting(x, y + 1, oWall)) {
    movement.vsp = -movement.jumpspeed;
    jump.jumps = jump.jumpsmax - 1;  // Reset jumps counter
}

// Interaction System
var key_interact = keyboard_check_pressed(vk_enter);
if (key_interact) {
    var frog = instance_place(x, y, oFrog);
    if (frog != noone) {
        frog.Interact(); // Call the Interact method
        water.can_swim = true;  // Assuming frog interaction grants swim ability
    }
}

// Leaving water
if (water.in_water && !place_meeting(x, y, oWater)) {
    water.in_water = false;
    movement.grav = 0.4;
    movement.movespeed = movement.No_effect_movespeed;
    movement.vsp = clamp(movement.vsp, -movement.max_vsp, movement.max_vsp); // Limit upward speed
    player.state = PLAYERSTATE.Free; // Force exit swimming state
}

// Climbing button
climb.key_climb = keyboard_check(vk_shift); // Use "held" instead of "pressed"

// Climbing Cooldown
if (climb.cooldown > 0) climb.cooldown--;

// Health and Death
if (player.hp <= 0) {
    DeathofPlayer();
}

// Animation and Drawing
if (player.draw_player) {
    draw_self();
}

// Double jumping
if (jump.has_doublejump_item == true) {
    jump.base_jumpsmax = 2; // Set base jumps to 2
    jump.jumpsmax = jump.base_jumpsmax; // Update current max jumps
}

// Attack Input
attack.keyAttack = keyboard_check_pressed(ord("F"));
if (attack.keyAttack && player.state == PLAYERSTATE.Free) {
    SlashAttackPlayer();
}

// Update dash key state
water.keyDash = keyboard_check_pressed(ord("E"));


// reset stamina when touching ground
if (player.state == PLAYERSTATE.Free && place_meeting(x, y + 1, oWall)) {
    climb.stamina = climb.stamina_max;
}