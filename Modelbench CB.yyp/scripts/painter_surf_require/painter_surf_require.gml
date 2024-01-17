// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function painter_surf_require(){
texsurf = surface_require(texsurf, texturewidth, textureheight)
drawsurf = surface_require(drawsurf, texturewidth, textureheight)
alphasurf = surface_require(alphasurf, texturewidth, textureheight)
colorsurf = surface_require(colorsurf, texturewidth, textureheight)
selectionsurf = surface_require(selectionsurf, texturewidth, textureheight)
}