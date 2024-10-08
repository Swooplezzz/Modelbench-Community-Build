/// tab_get_title(tab)
/// @arg tab
/// @desc Returns the tab title.

function tab_get_title(tab)
{
	switch (tab)
	{
		case assets: return text_get("tabassets")
		case preview: return text_get("tabpreview")
		case export: return text_get("tabexportmodel")
		case settings: return text_get("tabsettings")
		case colors: return text_get("tabcolors")
		case toolproperties: return text_get("tabtoolproperties")
		case element_editor:
		{
			if (el_edit != null)
			{
				if (el_edit.name != "")
					return el_edit.name
				else
					return (el_edit.element_type = TYPE_PART ? text_get("assetsnewpart") : text_get("assetsnewshape"))
			}
			else
				return "???"
		}
		default: return ""
	}
}
