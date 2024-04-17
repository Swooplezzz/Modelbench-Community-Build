/// rgb_to_yuv(red, green, blue)
/// @arg red
/// @arg green
/// @arg blue

function rgb_to_yuv(r, g, b)
{
    var _Y = 0.299 * r + 0.587 * g + 0.114 * b;
    var U = -0.14713 * r - 0.28886 * g + 0.436 * b;
    var V = 0.615 * r - 0.51499 * g - 0.10001 * b;

    return [_Y, U, V];
}