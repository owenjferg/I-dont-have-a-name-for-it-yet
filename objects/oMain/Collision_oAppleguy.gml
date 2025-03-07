// Collision Event with oAppleguy
if (!jump.has_doublejump_item) {
    jump.has_doublejump_item = true; // Grant double jump
    instance_destroy(other); // Destroy the collided oAppleguy instance
}