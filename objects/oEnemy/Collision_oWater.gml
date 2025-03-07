// oEnemy - Collision Event with oWater
if (can_take_water_damage) {
    hp -= water_damage;
    can_take_water_damage = false; // Prevent repeated damage
    alarm[0] = 60; // Reset cooldown after 1 second (60 steps)
    
    if (hp <= 0) {
        instance_destroy();
    }
}
