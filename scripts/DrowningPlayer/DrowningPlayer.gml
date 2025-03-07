function DrowningPlayer(_damage, _invulnerable) {
    if (!water.can_swim) {
        // Player can't swim, so they sink
        movement.vsp += movement.grav; // Apply gravity to make the player sink
        movement.grav = 0.5;           // Increase gravity for sinking effect
        movement.hsp = 0;              // Stop horizontal movement
        movement.movespeed = 0.1;      // Reduce movement speed

        // Apply damage to the player
        player.hp -= _damage;

        // Set invincibility frames
        knockback.invincible = true;
        alarm[1] = _invulnerable;      // Set invincibility duration
    }
}