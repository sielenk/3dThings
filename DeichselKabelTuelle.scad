// (c) 2022 Marvin Sielenkemper

// Deichsel Außendurchmesser
dia_drawbar = 70;

// Deichsel Wandstärke
wall_drawbar = 3.1;

// Deichsel Loch Durchmesser
dia_hole = 19;

// Kabel Durchmesser
dia_wire = 12;

// Überlappung außen
overlapp = 2;


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
                        translate([0, 0, -wall_drawbar])  {
                            cylinder(h = 3*wall_drawbar, d = dia_hole + 2*overlapp);
                        }
                        translate([0, 0, 2*wall_drawbar]) rotate_extrude() {
                                translate([dia_wire/4 + dia_hole/4 + overlapp/2, 0, 0])
                                circle(d=dia_hole/2 + overlapp - dia_wire/2, $fn=32);
                        }
                        translate([0, 0, -wall_drawbar]) rotate_extrude() {
                                translate([dia_wire/4 + dia_hole/4, 0, 0])
                                circle(d=dia_hole/2 - dia_wire/2, $fn=32);
                        }
                    }
                    translate([0, 0, -2*wall_drawbar]) {
                        cylinder(h = 5*wall_drawbar, d = dia_wire);
                    }
                }
                drawbar(wall_drawbar * 2);
            }
            rotate([0, 90, 0]) {
                translate([0, 0, -wall_drawbar]) {
                    $fn=64;
                    intersection() {
                        translate([-(dia_hole + overlapp)/2, -dia_hole/6, 0])
                            cube([dia_hole + overlapp, dia_hole/3, wall_drawbar]);
                        difference() {
                            cylinder(h=wall_drawbar, d1=dia_hole, d2=dia_hole+1);
                            translate([0, 0, -0.5])
                                cylinder(h=wall_drawbar+1, d1=dia_hole-0.5, d2=dia_hole-0.5);
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

    //rotate([90, 0, 0])
    plug();
}