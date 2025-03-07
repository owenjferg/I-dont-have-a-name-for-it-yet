// Player State Enum
enum PLAYERSTATE {
    Free,
    Attack_Slash,
    Attack_Combo,
    Climbing,
    Sliding,
}

// Player Struct
player = {
    state: PLAYERSTATE.Free, // Initialize state to Free
    sprite_index: sMain, // Default sprite
    image_index: 0,
	image_speed: 1,
	draw_player: true, // Tracks if the player should be drawn
	hp: 5, // Player's current health
    hp_max: 5, // Player's max health
	
};

// Movement Struct
movement = {
    grav: 0.2, // Gravity
    hsp: 0, // Horizontal speed
    vsp: 0, // Vertical speed
    jumpspeed: 7, // Jump strength
    movespeed: 4, // Movement speed
    No_effect_movespeed: 4, // Original movespeed
    max_hsp: 6, // Maximum horizontal speed
    max_vsp: 10, // Maximum vertical speed
};

// Jump Struct
jump = {
    jumps: 0, // Current jumps
    base_jumpsmax: 1, // Default jumps (without double jump)
    jumpsmax: 1, // Current max jumps
    has_doublejump_item: false, // Tracks if the player has the double jump item
};

// Water and Swimming Struct
water = {
    can_swim: false, // Tracks if the player can swim
    in_water: false, // Tracks if the player is in water
    fish_player: false, // Tracks if the player is in fish form
};

// Death and Fade Effect Struct
death = {
    started: false, // Tracks if death sequence has started
    time: game_get_speed(gamespeed_fps) * 2, // Fade duration (2 seconds)
    alpha: 0, // Alpha value for death fade effect
};

// Invincibility and Knockback Struct
knockback = {
    invincible: false, // Tracks if the player is invincible
    hsp_knockback: 0, // Horizontal knockback speed
    vsp_knockback: 0, // Vertical knockback speed
    decay: 0.9, // How quickly knockback fades
    slow_duration: game_get_speed(gamespeed_fps) / 2, // Slow effect duration (1 frame)
};

// Climbing Struct
climb = {
    speed: 3, // Speed of climbing
    jump_force: 5, // Horizontal force when wall jumping
    climbing: false, // Tracks if the player is climbing
    dir: 0, // -1 for left wall, 1 for right wall
    stamina_max: 90, // Max stamina for climbing
    stamina: 90, // Current stamina
    can_grab: true, // Cooldown to prevent immediate regrab
    cooldown: 0, // Cooldown timer after climbing ends
    slide_speed: 2, // Speed at which the player slides down the wall
};

// Attack Struct
attack = {
    hitByAttack: ds_list_create(), // List to track hit enemies
    playerattacking: false, // Tracks if the player is attacking
    keyAttack: false, // Tracks if the attack key is pressed
};

// Starting Position Struct
position = {
    start_x: 100, // Starting X position (adjust as needed)
    start_y: 100, // Starting Y position (adjust as needed)
};
enemy = {
	hp: 10,
	hp_max: 10,
};

// Alarm Initialization
alarm[0] = game_get_speed(gamespeed_fps); // Alarm to trigger every second
