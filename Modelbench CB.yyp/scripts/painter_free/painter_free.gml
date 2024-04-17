/// painter_free()

function painter_free()
{
	surface_free(alphasurf)
	surface_free(texsurf)
	surface_free(colorsurf)
	surface_free(drawsurf)
	surface_free(selectionsurf)
}