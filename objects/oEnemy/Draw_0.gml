// oEnemy - Draw Event
draw_self(); // Draw the enemy sprite

// Optional: Draw health bar above the enemy
draw_set_color(c_red);
draw_rectangle(x - 20, y - 30, x + 20, y - 25, false); // Health bar background
draw_set_color(c_green);
draw_rectangle(x - 20, y - 30, x - 20 + (40 * (hp / 10)), y - 25, false); // Health bar (scaled to hp)