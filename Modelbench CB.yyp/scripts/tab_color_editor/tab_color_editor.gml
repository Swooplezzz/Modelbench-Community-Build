// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function tab_color_editor(){
		// Mix color

	    draw_painter_color_editor("paintercoloreditor", action_color_set, (painter_main_color ? paint_secondary_color : paint_primary_color))

        var stack = (content_width > 230 + 176)
	    if(!stack) dx = content_x + 12 + content_width /2 - 230/2;
	    else dx = content_x + 12
	
		dx += 12;
		draw_button_icon("switchmaincolor", dx, dy, 24, 24, 0, icons.SWITCH, action_switch_main_color)
		dx += 32;
		if(painter_main_color = 0){
		draw_color_selector_button("secselector", dx+12,dy+12, 1, action_painter_select_color);

		draw_color_selector_button("primaryselector", dx,dy, 0, action_painter_select_color);
		}
		else{
		draw_color_selector_button("primaryselector", dx,dy, 0, action_painter_select_color);
		
		draw_color_selector_button("secselector", dx+12,dy+12, 1, action_painter_select_color);
		}
		dx = content_x + 12;
		dy += 52;
		draw_recentcolors()
		dy += 8;
		draw_image(spr_icons, icons.PALETTE, dx + 4,dy,1,1,c_accent,a_accent)
		draw_label("COLOR PALLETTES", dx+16, dy,fa_left, fa_middle, c_accent, a_accent, font_subheading)
		draw_button_icon("addpallette", dx+8 + content_width - 48, dy - 12, 24,24,false, icons.ASSET_ADD, action_painter_pallette_add)
		draw_button_icon("importpallette", dx + content_width - 48 - 24,  dy - 12, 24,24,false, icons.DOWNLOAD, action_painter_pallette_import)
		
		dy += 24
		
		draw_colorpallettes()

}