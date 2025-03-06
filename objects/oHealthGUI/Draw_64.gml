// Draw Health



var _oMainHealth = global.playerhp;
var _oMainHealthmax = global.hp_max;
var _oMainHealthFrac = frac(_oMainHealth);
_oMainHealth -= _oMainHealthFrac;


for (var i = 1; i <= _oMainHealthmax; i++)
{
	var _imageIndex = (i > _oMainHealth);
	if (i == _oMainHealth+1)
	{
		_imageIndex += (_oMainHealthFrac > 0)
		_imageIndex += (_oMainHealthFrac > 0.25)
		_imageIndex += (_oMainHealthFrac > 0.5)
	}
	draw_sprite(sPurpHeart, _imageIndex,
		global.UI_MARGIN + ((i-1) * global.UI_HEALTHSEPARATION),
	global.UI_MARGIN)
}