// (c) 2022 Marvin Sielenkemper

// Deichsel Außendurchmesser
dia_drawbar = 70.7;

// Deichsel Wandstärke
wall_drawbar = 3.1;

// Deichsel Loch Durchmesser
dia_hole = 12;

// Schraube Durchmesser
dia_screw = 10;

// Schraube Länge in Deichsel
depth_screw = -2.5;

// Überlappung außen
overlapp = 4;

// Überstand außen
ext_out = 0;

// Überstand innen
ext_in = 5;

// Rampenhöhe
ramp_height = 2;

// Klammer Durchmesser
clamp_diameter = 9;


module drawbar(wall = wall_drawbar) {
  translate([-dia_drawbar / 2 + wall_drawbar, 0, 0]) {
    $fn=128;

    difference() {
      union() {
        translate([0, 0, -dia_hole]) {
          cylinder(h = 2*dia_hole, d = dia_drawbar);
        }
      }

      union() {
        translate([0, 0, -dia_hole-1])
          cylinder(h = 2*dia_hole+2, d = dia_drawbar - 2*wall);
        rotate([0, 90, 0]) {
          cylinder(h = dia_drawbar, d = dia_hole, $fn = 64);
        }
      }
    }

    rotate_extrude($fn=64) {
      translate([dia_drawbar/2 + clamp_diameter/2, 0]) {
        circle(d = clamp_diameter, $fn=32);
      }
    }
  }
}

module plug() {
  difference() {
    union() {
      difference() {
        rotate([0, 90, 0]) {
          $fn=64;
          translate([0, 0, -ext_in])  {
            cylinder(h = ext_in + wall_drawbar + ext_out, d = dia_hole + 2*overlapp);
          }
          translate([0, 0, wall_drawbar + ext_out]) rotate_extrude() {
            dia1 = dia_screw/4 + dia_hole/4 + overlapp/2;
            dia2 = dia_hole/2 + overlapp - dia_screw/2;
            translate([-(dia1), 0, 0]) {
              circle(d=dia2, $fn=32);
              square([dia1, dia2/2]);
            }
          }
          translate([0, 0, -ext_in]) rotate_extrude() {
            dia1 = dia_screw/4 + dia_hole/4;
            dia2 = dia_hole/2 - dia_screw/2;
            translate([dia1, 0, 0]) {
              circle(d=dia2, $fn=32);
            }
            translate([0, -dia2/2]) {
              square([dia1, ext_in + ext_out + wall_drawbar]);
            }
          }
        }
        drawbar(wall_drawbar + ext_in);
      }
      rotate([0, 90, 0]) {
        translate([0, 0, -ext_in]) {
          $fn=64;
          difference() {
              cylinder(h=ext_in, d1=dia_hole, d2=dia_hole+ramp_height);
              translate([0, 0, -0.5])
                  cylinder(h=ext_in+1, d1=dia_hole-0.5, d2=dia_hole-0.5);
          }
        }
      }
    }
    drawbar();
  }
}

rotate([90, 90, 0]) {
    %drawbar();
    plug();
}
