function yuv_color_diff(col1, col2)
{
  var r1 = color_get_red(col1);
  var g1 = color_get_green(col1);
  var b1 = color_get_blue(col1);

  var r2 = color_get_red(col2);
  var g2 = color_get_green(col2)
  var b2 = color_get_blue(col2);
  var yuv1 = rgb_to_yuv(r1,g1,b1);
  var yuv2 = rgb_to_yuv(r2,g2,b2);
    var delta_y = yuv1[0] - yuv2[0];
    var delta_u = yuv1[1] - yuv2[1];
    var delta_v = yuv1[2] - yuv2[2];

    var yuv_diff = sqrt(delta_y * delta_y + delta_u * delta_u + delta_v * delta_v);

    return yuv_diff;
}