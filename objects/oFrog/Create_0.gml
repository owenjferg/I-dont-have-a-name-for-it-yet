text_box_active = false;
text_box_timer = 0;
text_box_duration = 120;

Interact = function() {
    if (!text_box_active) {
        text_box_active = true;
        text_box_timer = text_box_duration;
        global.can_swim = true;
       
    }
}