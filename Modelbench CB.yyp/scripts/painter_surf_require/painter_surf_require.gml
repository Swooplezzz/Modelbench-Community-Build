/// painter_surf_require()

function painter_surf_require()
{
	texsurf = surface_require(texsurf, texturewidth, textureheight)
	drawsurf = surface_require(drawsurf, texturewidth, textureheight)
	alphasurf = surface_require(alphasurf, texturewidth, textureheight)
	colorsurf = surface_require(colorsurf, texturewidth, textureheight)
	selectionsurf = surface_require(selectionsurf, texturewidth, textureheight)
	transformsurf = surface_require(transformsurf, texturewidth, textureheight)
}