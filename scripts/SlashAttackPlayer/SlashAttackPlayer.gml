function SlashAttackPlayer() {
    // Set the attack sprite and reset animation
    if (sprite_index != sMain_Slash) {
        attack.playerattacking = true; // Ensure this matches your sprite name
        image_index = 0;
        image_speed = 1; // Force animation to play
        ds_list_clear(attack.hitByAttack);
    }

    // Use attack hitbox and check for hits
    mask_index = sMain_SlashHB; // Ensure this matches your hitbox sprite
    var hitByAttackNow = ds_list_create();
    var hits = instance_place_list(x, y, oEnemy, hitByAttackNow, false);

    // Debugging
    show_debug_message("Attack sprite: " + string(sprite_get_name(sprite_index))); // Show sprite name instead of ID
    show_debug_message("Animation frame: " + string(image_index));
    show_debug_message("Hits detected: " + string(hits));

    if (hits > 0) {
        for (var i = 0; i < hits; i++) {
            var hitID = hitByAttackNow[| i]; // Get the ID of the hit enemy
            if (ds_list_find_index(attack.hitByAttack, hitID) == -1) { // Check if the enemy hasn't been hit yet
                ds_list_add(attack.hitByAttack, hitID); // Add the enemy to the hit list
                with (hitID) {
                    hp -= 0.5; // Apply damage to the enemy
                    if (hp <= 0) {
                        instance_destroy(); // Destroy the enemy if HP reaches 0
                    }
                }
            }
        }
    }

    ds_list_destroy(hitByAttackNow); // Clean up the temporary list
    mask_index = sMain; // Reset the mask to the default sprite

    // Check if the attack animation has ended
    if (AnimationEnd(sMain_Slash, image_index)) {
        attack.playerattacking = false; // Reset to the default sprite
        player.state = PLAYERSTATE.Free; // Return to the free state
    }

}