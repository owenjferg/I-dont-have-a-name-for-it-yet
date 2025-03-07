// oEnemy - Step Event
// Apply gravity
vsp += grav;

// Find the player (oMain)
var player = instance_nearest(x, y, oMain);

if (player != noone) {
    // Calculate direction to the player
    var dir_to_player = sign(player.x - x);

    // Move toward the player
    hsp = dir_to_player * move_speed;
}

// Check for horizontal collision with oWall
if (place_meeting(x + hsp, y, oWall)) {
    // Stop horizontal movement if a wall is hit
    hsp = 0;
}

// Apply horizontal movement
x += hsp;

// Check for vertical collision with oWall
if (place_meeting(x, y + vsp, oWall)) {
    // Move up to the surface of the ground
    while (!place_meeting(x, y + sign(vsp), oWall)) {
        y += sign(vsp);
    }
    vsp = 0; // Stop falling
}

// Apply vertical movement
y += vsp;
// oEnemy - Step Event
// Jump logic (optional)
if (place_meeting(x, y + 1, oWall) && player != noone && abs(player.x - x) < 64) {
    vsp = -jumpspeed; // Jump toward the player
}