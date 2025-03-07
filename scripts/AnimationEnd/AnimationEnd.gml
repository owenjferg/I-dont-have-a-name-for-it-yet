function AnimationEnd(_sprite, _image) {
    var _type = sprite_get_speed_type(_sprite);
    var _spd = sprite_get_speed(_sprite) * image_speed;
    
    if (_type == spritespeed_framespersecond) {
        _spd = _spd / game_get_speed(gamespeed_fps);
    }

    // Debugging
    show_debug_message("Animation check:");
    show_debug_message("Sprite: " + string(_sprite));
    show_debug_message("Current frame: " + string(_image));
    show_debug_message("Total frames: " + string(sprite_get_number(_sprite)));
    show_debug_message("End condition: " + string(_image + _spd >= sprite_get_number(_sprite)));

    return _image + _spd >= sprite_get_number(_sprite);
}