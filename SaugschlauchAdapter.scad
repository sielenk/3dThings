// tube inner diameter (mm)
tube_inner = 15;

// tube outer diameter (mm)
tube_outer = 20;

// diffusor/tube overlap (mm)
tube_overlap = 30;

// diffusor/tube wing length (mm)
tube_wing_length = 20;

// hose inner diameter (mm)
hose_inner = 32;

// hose outer diameter (mm)
hose_outer = 49.8; // 39;


// diffuser angle (°)
alpha = 10;

/* [Hidden] */
$fn = 60;

length = (hose_inner - tube_inner) / tan(alpha);
echo(length);

module hose() {
    difference() {
        union() {
            cylinder(d=34, h=30);
            for (i = [0:5]) {
                translate([0, 0, 5*i]) {
                    cylinder(d=39, h=1.6);
                    translate([0, 0, 2.5]) cylinder(d=35, h=1.6);
                }
            }
        }
        cylinder(d=32, h=30);
    }
}

module tube() {
    translate([0, 0, -60]) difference() {
        cylinder(d=20, h=60);
        cylinder(d=15, h=60);
    }
}

module diffuser() {
    difference() {
        union() {
            translate([0, 0, -tube_overlap]) {
                cylinder(
                    d1 = tube_outer + 2*0.8,
                    d2 = hose_outer,
                    h = length + tube_overlap
                );
                translate([0, 0, -tube_wing_length]) {
                    for (phi = [0:120:240]) {
                        rotate([0, 0, phi])
                        rotate_extrude(angle = 60) {
                            translate([tube_outer/2, 0, 0])
                            square([0.8, tube_wing_length]);
                        }
                    }
                }
            }
        }
        union() {
            cylinder(d1=tube_inner, d2=hose_inner, h=length);
            translate([0, 0, -tube_overlap]) {
                cylinder(d=tube_outer, h=tube_overlap);
            }
        }
    }
    translate([0, 0, length]) difference() {
        cylinder(d=hose_outer, h=37);
        cylinder(d=hose_inner, h=37);
    }
}


%hose();
%translate([0, 0, -length]) tube();
translate([0, 0, -length]) diffuser();



