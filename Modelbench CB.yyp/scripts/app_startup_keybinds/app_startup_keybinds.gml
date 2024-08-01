/// app_startup_keybinds()

function app_startup_keybinds()
{
	globalvar keybinds, keybind_edit;
	keybinds = array_create(e_keybind.amount)
	keybind_edit = null
	
	enum e_keybind_key
	{
		CHAR,
		CTRL,
		SHIFT,
		ALT
	}
	
	enum e_keybind
	{
		// File
		MODEL_NEW,
		MODEL_NEW_TEMPLATE,
		MODEL_OPEN,
		MODEL_SAVE,
		MODEL_SAVE_AS,
		MODEL_IMPORT,
		
		// Editing
		UNDO,
		REDO,
		RENAME,
		ELEMENT_DELETE,
		ELEMENT_DUPLICATE,
		SELECT_ALL,
		UV_EDITOR,
		
		// Tools
		TOOL_SELECT,
		TOOL_MOVE,
		TOOL_PIVOT,
		TOOL_ROTATE,
		TOOL_RESIZE,
		TOOL_SCALE,
		TOOL_BEND,
		TOOL_TRANSFORM,
		SNAP,
		
		// Navigation
		CAM_WALK,
		CAM_FORWARD,
		CAM_BACK,
		CAM_LEFT,
		CAM_RIGHT,
		CAM_ASCEND,
		CAM_DESCEND,
		CAM_RESET,
		CAM_FAST,
		CAM_SLOW,
	
		TOGGLE_PROJ,
		
		CAM_SNAP_VIEW_X,
		CAM_SNAP_VIEW_Y,
		CAM_SNAP_VIEW_Z,
		
		CAM_VIEW_ELEMENT,
		
		ELEMENT_MIRROR_X,
		ELEMENT_MIRROR_Z,
		ELEMENT_MIRROR,
		ELEMENT_ADD,
		
		FREE_POS,
		FREE_ROT,
		FREE_SCA,
		
		BRUSH,
		ERASE,
		PICK,
		FILL,
		SHAPE,
		BOX_SELECT,
		TRANSFORM_SELECTION,
		
		BRUSH_WIDTH,
		PAINTER_GRID,
		PAINTER_GUIDES,
		
		COPY,
		PASTE,
		CUT,
		
		amount
	}
	
	// File
	keybind_register("modelnew", e_keybind.MODEL_NEW, keybind_new("N", true))
	keybind_register("modelnewtemplate", e_keybind.MODEL_NEW_TEMPLATE, keybind_new("N", true, true))
	keybind_register("modelopen", e_keybind.MODEL_OPEN, keybind_new("O", true))
	keybind_register("modelsave", e_keybind.MODEL_SAVE, keybind_new("S", true))
	keybind_register("modelsaveas", e_keybind.MODEL_SAVE_AS, keybind_new("S", true, true))
	keybind_register("modelimport", e_keybind.MODEL_IMPORT, keybind_new("I", true))
	
	// Editing
	keybind_register("undo", e_keybind.UNDO, keybind_new("Z", true))
	keybind_register("redo", e_keybind.REDO, keybind_new("Y", true))
	keybind_register("rename", e_keybind.RENAME, keybind_new(vk_f2))
	keybind_register("add", e_keybind.ELEMENT_ADD, keybind_new("A", false, true), false, true)
	keybind_register("delete", e_keybind.ELEMENT_DELETE, keybind_new(vk_delete))
	keybind_register("duplicate", e_keybind.ELEMENT_DUPLICATE, keybind_new("D", true))
	keybind_register("select", e_keybind.SELECT_ALL, keybind_new("A", true))
	keybind_register("uveditor", e_keybind.UV_EDITOR, keybind_new("E", true))
	
	keybind_register("elmirror", e_keybind.ELEMENT_MIRROR, keybind_new("M", false, true), false, true)
	keybind_register("elmirrorx", e_keybind.ELEMENT_MIRROR_X, keybind_new("K", true), false, true)
	keybind_register("elmirrorz", e_keybind.ELEMENT_MIRROR_Z, keybind_new("M", true), false, true)
	
	// Tools
	keybind_register("toolselect", e_keybind.TOOL_SELECT, keybind_new("W"))
	keybind_register("toolmove", e_keybind.TOOL_MOVE, keybind_new("G"))
	keybind_register("toolpivot", e_keybind.TOOL_PIVOT, keybind_new("Q"))
	keybind_register("toolrotate", e_keybind.TOOL_ROTATE, keybind_new("R"))
	keybind_register("toolresize", e_keybind.TOOL_RESIZE, keybind_new("Z"))
	keybind_register("toolscale", e_keybind.TOOL_SCALE, keybind_new("S"))
	keybind_register("toolbend", e_keybind.TOOL_BEND, keybind_new("B"))
	keybind_register("tooltransform", e_keybind.TOOL_TRANSFORM, keybind_new("T"))
	keybind_register("snap", e_keybind.SNAP, keybind_new("F"))
	
	// Navigation
	keybind_register("camwalk", e_keybind.CAM_WALK, keybind_new("F", true))
	keybind_register("camforward", e_keybind.CAM_FORWARD, keybind_new("W"), true, false)
	keybind_register("camleft", e_keybind.CAM_LEFT, keybind_new("A"), true, false)
	keybind_register("camback", e_keybind.CAM_BACK, keybind_new("S"), true, false)
	keybind_register("camright", e_keybind.CAM_RIGHT, keybind_new("D"), true, false)
	keybind_register("camascend", e_keybind.CAM_ASCEND, keybind_new("E"), true, false)
	keybind_register("camdescend", e_keybind.CAM_DESCEND, keybind_new("Q"), true, false)
	keybind_register("camreset", e_keybind.CAM_RESET, keybind_new("R"), true, false)
	keybind_register("camfast", e_keybind.CAM_FAST, keybind_new(vk_space), true, false)
	keybind_register("camslow", e_keybind.CAM_SLOW, keybind_new(null, false, true), true, false)
	keybind_register("camviewelement", e_keybind.CAM_VIEW_ELEMENT, keybind_new("V"), false)
	
	keybind_register("toggleprojection", e_keybind.TOGGLE_PROJ, keybind_new("L"), false, true)
	
	keybind_register("camsnapviewx", e_keybind.CAM_SNAP_VIEW_X, keybind_new("I"), false, true)
	keybind_register("camsnapviewy", e_keybind.CAM_SNAP_VIEW_Y, keybind_new("O"), false, true)
	keybind_register("camsnapviewz", e_keybind.CAM_SNAP_VIEW_Z, keybind_new("P"), false, true)
	
	keybind_register("freepos", e_keybind.FREE_POS, keybind_new("J"), false, true)
	keybind_register("freerot", e_keybind.FREE_ROT, keybind_new("K"), false, true)
	keybind_register("freesca", e_keybind.FREE_SCA, keybind_new("N"), false, true)
	
	keybind_register("copy", e_keybind.COPY, keybind_new("C", true), false, true)
	keybind_register("paste", e_keybind.PASTE, keybind_new("V", true), false, true)
	keybind_register("cut", e_keybind.CUT, keybind_new("X", true), false, true)
	
	keybind_register("painterbrush", e_keybind.BRUSH, keybind_new("B"), false, true)
	keybind_register("paintererase", e_keybind.ERASE, keybind_new("E"), false, true)
	keybind_register("painterpick", e_keybind.PICK, keybind_new("R"), false, true)
	keybind_register("painterfill", e_keybind.FILL, keybind_new("F", true), false, true)
	keybind_register("paintershape", e_keybind.SHAPE, keybind_new("O"), false, true)
	keybind_register("painterboxselect", e_keybind.BOX_SELECT, keybind_new("S"), false, true)
	keybind_register("paintertransformselection", e_keybind.TRANSFORM_SELECTION, keybind_new("T"), false, true)
	
	keybind_register("painterbrushwidth", e_keybind.BRUSH_WIDTH, keybind_new("F"), false, true)
	keybind_register("paintergrid", e_keybind.PAINTER_GRID, keybind_new("G"), false, true)
	keybind_register("painterguides", e_keybind.PAINTER_GUIDES, keybind_new("G", true), false, true)
	
	keybinds_update_match()
}
