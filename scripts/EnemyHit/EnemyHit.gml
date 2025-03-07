function EnemyHit(_damage) {
    enemy.hp -= _damage; // Apply damage to the enemy's health

    // Visual feedback (e.g., flash red)
    with (instance_create_layer(x, y, "Effects", oDamageEffect)) {
        image_blend = c_red; // Flash red
        alarm[0] = 10; // Flash duration
    }

    // Destroy enemy if HP reaches 0
    if (enemy.hp <= 0) {
        instance_destroy();
    }
}