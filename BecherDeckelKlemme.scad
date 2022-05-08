becher_durchmesser_aussen = 105.2;
becher_ring_durchmesser = 3.3;
becher_hoehe = 16;

klammer_breite = 18;
klammer_dicke = 2;
klammer_ring_durchmesser = 3.3;
klammer_abstand_rand = 92.8;


klammer_ring_radius = klammer_ring_durchmesser / 2;
klammer_abstand_mitte = sqrt(
    klammer_breite*klammer_breite+klammer_abstand_rand*klammer_abstand_rand);
klammer_loch_durchmesser = klammer_abstand_mitte + klammer_ring_durchmesser;
klammer_loch_radius = klammer_loch_durchmesser / 2;

module klammer() {
    $fn = 64;
    klammer = [klammer_breite, becher_durchmesser_aussen+2+klammer_dicke];

    translate([0, 0, -klammer_ring_radius/2]) {
        translate([0, 0, becher_hoehe+klammer_dicke/2+klammer_ring_radius/2]) {
            cube([klammer.x, klammer.y, klammer_dicke], center = true);
        }

        for (f = [0, 180]) {
            rotate([0, 0, f]) {
                translate([-klammer.x/2, -klammer.y/2, (klammer_ring_radius-klammer_dicke)/2]) {
                    cube([klammer.x, klammer_dicke, becher_hoehe+klammer_dicke]);
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
    klammer();

    %translate([0, 0, 1.5]) {
        rotate_extrude($fn = 256) {
            translate([105.2/2-3.3/2, 0, 0]) circle(d=3.3);
        }
    }
}
