function color_check_tolerance(col1, col2) {
  var r1 = color_get_red(col1);
  var g1 = color_get_green(col1);
  var b1 = color_get_blue(col1);

  var r2 = color_get_red(col2);
  var g2 = color_get_green(col2)
  var b2 = color_get_blue(col2);
  var rdash = 0.5 * (r1+r2)
  var dr, dg, db;
  dr = r1-r2;
  dg = g1-g2;
  db = b1-b2;
  var deltaC ;
  if(rdash < 128)
  deltaC = sqrt(2*(dr*dr) + 4*(dg*dg) +3*(db*db));
  else
  deltaC = sqrt(3*(dr*dr) + 4*(dg*dg) +2*(db*db));
  //var deltaC = sqrt(( 2 + rdash/256 ) * (dr * dr) + 4 * (dg * dg) + (2+ (255-rdash)/256) * (db * db))
  return deltaC;
}