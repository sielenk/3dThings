becher_durchmesser_aussen = 105.2;

klammer_breite = 18;
klammer_dicke = 2;
klammer_ring_durchmesser = 3.3;
klammer_abstand_rand = 92.8;


klammer_ring_radius = klammer_ring_durchmesser / 2;
klammer_abstand_mitte = sqrt(
    klammer_breite*klammer_breite+klammer_abstand_rand*klammer_abstand_rand);
klammer_loch_durchmesser = klammer_abstand_mitte + klammer_ring_durchmesser;
klammer_loch_radius = klammer_loch_durchmesser / 2;

$fn = 64;

module klammer() {
    translate([0, 0, -klammer_ring_radius/2]) {
        difference() {
            cube(
                [klammer_breite, becher_durchmesser_aussen+2+klammer_dicke, klammer_ring_radius],
                center=true);
            translate([0, 0, -(klammer_ring_radius+1)/2]) {
                cylinder(r=klammer_loch_radius, h=klammer_ring_radius+1);
            }
        }
    }

    rotate_extrude() {
        translate([klammer_loch_radius, 0, 0]) {
            circle(d=klammer_ring_durchmesser);
        }
    };
}

klammer();

%translate([0, 0, 1.5]) {
    rotate_extrude() {
        translate([105.2/2-3.3/2, 0, 0]) circle(d=3.3);
    }
}