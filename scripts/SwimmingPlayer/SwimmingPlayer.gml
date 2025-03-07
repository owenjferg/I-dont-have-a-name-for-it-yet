function SwimmingPlayer() {
    if (water.can_swim) {
        // Player can swim
        water.fish_player = true;          // Enable fish form
        movement.movespeed = 10;           // Increase movement speed in water
        movement.grav = 0.1;               // Reduce gravity in water
        alarm[0] = 1;                      // Reset swimming frames
    }
}