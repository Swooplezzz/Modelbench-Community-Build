// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function tab_color_editor(){
		// Mix color
		tab_control_color()
		draw_button_color("coloreditorprimarycolor", dx, dy, floor(dw/2), paint_primary_color, c_black, false, action_color_primary)
		tab_next()
		tab_control_color()
		draw_button_color("coloreditorsecondarycolor", dx, dy, floor(dw/2), paint_secondary_color, c_black, false, action_color_secondary)
		tab_next()
		dy += 8;
		draw_label("Recent Colors", dx, dy,fa_left, fa_middle, c_accent, a_accent, font_heading)
		dy += 8;
		draw_recentcolors()
		dy += 8;
		draw_image(spr_icons, icons.PALETTE, dx + 4,dy,1,1,c_accent,a_accent)
		draw_label("COLOR PALLETTES", dx+16, dy,fa_left, fa_middle, c_accent, a_accent, font_subheading)
		draw_button_icon("addpallette", dx+8 + content_width - 48, dy - 12, 24,24,false, icons.ASSET_ADD, action_painter_pallette_add)
		draw_button_icon("importpallette", dx + content_width - 48 - 24,  dy - 12, 24,24,false, icons.DOWNLOAD)
		
		dy += 24
		
		draw_colorpallettes()

}