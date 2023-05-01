becher_durchmesser_aussen = 105.2;
becher_ring_durchmesser = 3.3;
becher_hoehe = 16;

klammer_breite = 18;
klammer_dicke = 2;
klammer_ring_durchmesser = 3.3;
klammer_loch_durchmesser = 97;
klammer_ueberstand = 13;


klammer_ring_radius = klammer_ring_durchmesser / 2;
klammer_loch_radius = klammer_loch_durchmesser / 2;

module klammer(up = 0) {
    $fn = 64;
    klammer = [klammer_breite, becher_durchmesser_aussen+2+klammer_dicke];

    translate([0, 0, becher_hoehe + klammer_dicke/2]) {
        difference() {
            union() {
                minkowski() {
                    cube([klammer.x-0.2, klammer.y-klammer_dicke+0.2, 0.2], center = true);
                    translate([-0.1, 0, 0]) rotate([0, 90, 0]) cylinder(d=klammer_dicke-0.2, h=0.2);
                }
                translate([0, 0, klammer_dicke]) {
                    cube([klammer.x, 2*klammer.x, klammer_dicke], center=true);
                    for (f = [-1, 1]) {
                        translate([-klammer.x/2, f*klammer.x, -klammer_dicke/2]) {
                            rotate([0, 90, 0]) cylinder(h=klammer.x, r=klammer_dicke);
                        }
                    }
                }
            }

            translate([0, 0, up*(klammer_dicke+0.1)]) {
                cube([klammer.x+0.2, klammer.x+0.2, klammer_dicke+0.2], center=true);
            }
        }
    }

    translate([0, 0, -klammer_ring_radius/2]) {
        for (f = [0, 180]) {
            rotate([0, 0, f]) {
                translate([-klammer.x/2, -klammer.y/2, 0]) {
                    translate([0, 0, (klammer_ring_radius-klammer_dicke)/2-klammer_ueberstand]) {
                        cube([klammer.x, klammer_dicke, becher_hoehe+klammer_dicke+klammer_ueberstand]);
                        rotate([0, 90, 0]) {
                            cylinder(r=klammer_dicke, h=klammer.x);
                        }
                        translate([0, 2*klammer_dicke, becher_hoehe+klammer_dicke+klammer_ueberstand-1.5*klammer_dicke]) {
                            rotate([0, 90, 0]) {
                                difference() {
                                    translate([-klammer_dicke, -klammer_dicke, 0])
                                        cube([klammer_dicke, klammer_dicke, klammer.x]);
                                    translate([0, 0, -0.5])                                cylinder(r=klammer_dicke, h=klammer.x+1);
                                }
                            }
                        }
                    }
                }
            }
        }

        difference() {
            cube([klammer.x, klammer.y, klammer_ring_radius], center=true);
            translate([0, 0, -(klammer_ring_radius+1)/2]) {
                cylinder(r=klammer_loch_radius, h=klammer_ring_radius+1);
            }
        }
    }

    intersection() {
        cube([klammer.x, klammer.y, klammer_ring_durchmesser], center = true);

        rotate_extrude($fn = 256) {
            translate([klammer_loch_radius, 0, 0]) {
                circle(d=klammer_ring_durchmesser);
            }
        }
    }
}


rotate([0, 90, 0]) {
    klammer(1);

    %translate([0, 0, 1.5]) {
        rotate_extrude($fn = 256) {
            translate([105.2/2-3.3/2, 0, 0]) circle(d=3.3);
        }
    }
}
