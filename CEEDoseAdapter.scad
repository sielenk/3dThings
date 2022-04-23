dicke = 5;

$fn = 64;

module adapter() {
    difference() {
        translate([-19/2, -19/2, 0]) union() {
            intersection() {
                minkowski() {
                    sphere(r=dicke-1);
                    cube([150, 150, 1]);
                }
                translate([-dicke, -dicke]) {
                    cube([150+2*dicke, 150+2*dicke, dicke]);
                }
            }
        }

        // Lochabstand X: 92mm  Y: 94mm
        // Oberkante - Mitte Loch Y: 22mm
        // Seite - Mitte Loch X: 18,5mm

        union() {
            ld  = 4.5;

            translate([131/2, 131/2, -1]) {
                cylinder(d=100, h=14);

                lx = 115 / 2;
                ly = 115 / 2;

                for (p = [[lx, ly], [lx, -ly], [-lx, -ly], [-lx, ly]]) {
                    translate([p.x, p.y, 0]) {
                        cylinder(d=ld, h=dicke-1.95);

                        translate([0, 0, dicke-2.5]) {
                            cylinder(d1=ld, d2=8, h=2);
                        }
                        translate([0, 0, dicke-0.55]) {
                            cylinder(d=8, h=3);
                        }
                    }
                }
            }
            translate([131/2, 94/2 + 11, -1]) {
                lx = 92 / 2;
                ly = 94 / 2;

                for (p = [[lx, ly], [lx, -ly], [-lx, -ly], [-lx, ly]]) {
                    translate([p.x, p.y, 0]) cylinder(d=ld, h=dicke+2);
                }
            }
        }
    }
}


module CEE_Shape() {
    translate([92/2, -(42+4-4.25-94)]) {
        intersection() {
            union() {
                circle(r=44.5);
                translate([0, 4]) circle(r=45);
            }
            translate([-85.5/2, -44.5]) square([85.5, 42+4+44.5]);
        }

        translate([ 92/2, 42+4-4.25]) circle(d=4);
        translate([-92/2, 42+4-4.25]) circle(d=4);
        translate([ 92/2, 42+4-4.25-94]) circle(d=4);
        translate([-92/2, 42+4-4.25-94]) circle(d=4);
    }
}

adapter();

%translate([(131-92)/2, 11]) CEE_Shape();
%translate([-19/2, -19/2]) difference() {
    square(150);
    translate([19/2, 19/2]) square(131);
}
