// oEnemy - Collision Event with oMain
if (!oMain.knockback.invincible) {
    // Apply damage to the player
    oMain.player.hp -= 0.25;

    // Calculate knockback direction
    var knockback_dir = sign(oMain.x - x);

    // Apply knockback
    oMain.knockback.hsp_knockback = knockback_dir * 5;
    oMain.knockback.vsp_knockback = -3;

    // Reduce movement speed temporarily
    oMain.movement.movespeed = 2;
    oMain.alarm[2] = oMain.knockback.slow_duration; // 

    // Set invincibility frames
    oMain.knockback.invincible = true;
    oMain.alarm[1] = 60;
}