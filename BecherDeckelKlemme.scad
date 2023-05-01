becher_durchmesser_aussen = 105.2;
becher_ring_durchmesser = 3.3;
becher_hoehe = 16;
becher_nut_tiefe = 3;
becher_nut_breite = 10;
becher_nut_durchmesser = 65;

klammer_breite = 18;
klammer_dicke = 2.4;
klammer_ring_durchmesser = 3.3;
klammer_loch_durchmesser = 97;
klammer_schloss_hoehe = 4;

duese_durchmesser = 0.6;

klammer_ring_radius = klammer_ring_durchmesser / 2;
klammer_loch_radius = klammer_loch_durchmesser / 2;


module klammer() {
    $fn = 64;
    klammer = [klammer_breite, becher_durchmesser_aussen+3+klammer_dicke];

    translate([0, 0, becher_hoehe + klammer_dicke/2]) {
        minkowski() {
            cube([klammer.x-0.2, klammer.y-klammer_dicke+0.2, 0.2], center = true);
            translate([-0.1, 0, 0]) rotate([0, 90, 0]) cylinder(d=klammer_dicke-0.2, h=0.2);
        }
    }

    translate([0, 0, becher_hoehe]) {
        difference() {
            durchmesser = klammer_breite * sqrt(2);
            ring_nut_radius = klammer_schloss_hoehe/2 - duese_durchmesser;

            cylinder(d = durchmesser, h = klammer_dicke + klammer_schloss_hoehe);

            rotate_extrude($fn = 256) {
                translate([durchmesser/2, klammer_dicke + ring_nut_radius, 0]) {
                    circle(r=ring_nut_radius);
                }
            }

        }
    }

    translate([0, 0, -klammer_ring_radius/2]) {
        for (f = [0, 180]) {
            rotate([0, 0, f]) {
                translate([-klammer.x/2, -klammer.y/2, 0]) {
                    translate([0, 0, (klammer_ring_radius-klammer_dicke)/2]) {
                        cube([klammer.x, klammer_dicke, becher_hoehe+klammer_dicke]);

                        translate([0, 2*klammer_dicke, becher_hoehe-0.5*klammer_dicke]) {
                            rotate([0, 90, 0]) {
                                difference() {
                                    translate([-klammer_dicke, -klammer_dicke, 0])
                                        cube([klammer_dicke, klammer_dicke, klammer.x]);
                                    translate([0, 0, -0.5])
                                        cylinder(r=klammer_dicke, h=klammer.x+1);
                                }
                            }
                        }
                    }
                }
            }
        }

        difference() {
            union() {
                cube([klammer.x, klammer.y, klammer_ring_radius], center=true);
                translate([-klammer.x/2, klammer.y/2-klammer_ring_radius, -klammer_ring_radius/2]) {
                    rotate([0, 90, 0]) {
                        cylinder(h = klammer.x, r=klammer_ring_radius);
                    }
                }
            }
            translate([0, 0, -(klammer_ring_radius+1)/2]) {
                cylinder(r=klammer_loch_radius, h=klammer_ring_radius+1);
            }
        }
    }

    intersection() {
        cube([klammer.x, klammer.y, klammer_ring_durchmesser + 2*becher_hoehe], center = true);

        union() {
            rotate_extrude($fn = 256)
            {
                translate([klammer_loch_radius, 0, 0]) {
                    circle(d=klammer_ring_durchmesser);
                }

                translate([(becher_nut_durchmesser + becher_nut_breite)/2, becher_hoehe  - becher_nut_tiefe / 2, 0]) {
                    square([becher_nut_breite, becher_nut_tiefe], center = true);
                }
            }
        }
    }
}

rotate([0, 90, 0]) {
    intersection() {
        klammer();
        rotate([0, 0, 45]) translate([0, 0, -50]) cube([100, 100, 100]);
    }

    %translate([0, 0, 1.5]) {
        rotate_extrude($fn = 256) {
            translate([105.2/2-3.3/2, 0, 0]) circle(d=3.3);
        }
    }
}