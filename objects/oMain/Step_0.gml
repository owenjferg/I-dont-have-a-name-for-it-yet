// Handle player state logic
switch (player.state) {
    case PLAYERSTATE.Free: FreePlayer(); break;
    case PLAYERSTATE.Climbing: ClimbingPlayer(); break;
    case PLAYERSTATE.Sliding: SlidingPlayer(); break;
    case PLAYERSTATE.Attack_Slash: SlashAttackPlayer(); break;
    case PLAYERSTATE.Attack_Combo: ComboAttackPlayer(); break;
}

// Physics and Movement
if (!place_meeting(x, y + 1, oWall)) {
    movement.vsp += movement.grav;  // Apply gravity
} else {
    movement.vsp = 0;              // Reset vertical speed when grounded
}

// Horizontal Movement Input
var key_right = keyboard_check(ord("D"));
var key_left = -keyboard_check(ord("A"));
var move = key_left + key_right;
movement.hsp = move * movement.movespeed;

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
var key_jump = keyboard_check_pressed(vk_space);
if (key_jump && place_meeting(x, y + 1, oWall)) {
    movement.vsp = -movement.jumpspeed;
    jump.jumps = jump.jumpsmax - 1;  // Reset jumps counter
}

// Interaction System
var key_interact = keyboard_check_pressed(vk_enter);
if (key_interact) {
    var frog = instance_place(x, y, oFrog);
    if (frog != noone) {
        frog.Interact();
        water.can_swim = true;  // Assuming frog interaction grants swim ability
    }
}

// Water State Management
if (water.in_water && !place_meeting(x, y, oWater)) {
    water.in_water = false;
    movement.grav = 0.2;
    movement.movespeed = movement.No_effect_movespeed;
}

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