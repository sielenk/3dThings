// (c) 2022 Marvin Sielenkemper

// Deichsel Außendurchmesser
dia_drawbar = 70.7;

// Deichsel Wandstärke
wall_drawbar = 3;

// Deichsel Loch Durchmesser
dia_hole = 18.5;

// Kabel Durchmesser
dia_wire = 11.5;

// Überlappung außen
overlapp = 2;

// Überstand außen
ext_out = 1;

// Überstand innen
ext_in = 4;

// Rampenhöhe
ramp_height = 2;


module drawbar(wall = wall_drawbar) {
    $fn=128;

    translate([-dia_drawbar / 2 + wall_drawbar, 0, 0]) difference() {
        translate([0, 0, -dia_hole])
            cylinder(h = 2*dia_hole, d = dia_drawbar);

        union() {
            translate([0, 0, -dia_hole-1])
                cylinder(h = 2*dia_hole+2, d = dia_drawbar - 2*wall);
            rotate([0, 90, 0]) {
                cylinder(h = dia_drawbar, d = dia_hole, $fn = 64);
            }
        }
    }
}

module plug() {
    difference() {
        union() {
            difference() {
                rotate([0, 90, 0]) difference() {
                    $fn=64;
                    union () {
                        translate([0, 0, -ext_in])  {
                            cylinder(h = ext_in + wall_drawbar + ext_out, d = dia_hole + 2*overlapp);
                        }
                        translate([0, 0, wall_drawbar + ext_out]) rotate_extrude() {
                                translate([dia_wire/4 + dia_hole/4 + overlapp/2, 0, 0])
                                circle(d=dia_hole/2 + overlapp - dia_wire/2, $fn=32);
                        }
                        translate([0, 0, -ext_in]) rotate_extrude() {
                                translate([dia_wire/4 + dia_hole/4, 0, 0])
                                circle(d=dia_hole/2 - dia_wire/2, $fn=32);
                        }
                    }
                    translate([0, 0, -ext_in-1]) {
                        cylinder(h = ext_in + wall_drawbar + ext_out + 2, d = dia_wire);
                    }
                }
                drawbar(wall_drawbar + ext_in);
            }
            rotate([0, 90, 0]) {
                translate([0, 0, -ext_in]) {
                    $fn=64;
                    intersection() {
                        translate([-(dia_hole + overlapp)/2, -dia_hole/6, -0.5])
                            cube([dia_hole + ramp_height + 0.5, dia_hole/3, ext_in+1]);
                        difference() {
                            cylinder(h=ext_in, d1=dia_hole, d2=dia_hole+ramp_height);
                            translate([0, 0, -0.5])
                                cylinder(h=ext_in+1, d1=dia_hole-0.5, d2=dia_hole-0.5);
                        }
                    }
                }
            }
        }
        drawbar();
    }
}


intersection() {
    translate([-25, -20, 0]) cube([40, 40, 20]);

    rotate([90, 0, 0]) {
        //%drawbar();
        plug();
    }
}