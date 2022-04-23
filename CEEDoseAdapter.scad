module adapter() {
    difference() {
        cube([131, 131, 12]);

        // Lochabstand X: 92mm  Y: 94mm
        // Oberkante - Mitte Loch Y: 22mm
        // Seite - Mitte Loch X: 18,5mm

        union() {
            $fn = 64;

            translate([131/2, 131/2, -1]) cylinder(d=100, h=14);
            translate([131/2, 94/2 + 11, -1]) {
                ld  = 4.5;
                lx = 92 / 2;
                ly = 94 / 2;

                translate([ lx, -ly, 0]) cylinder(d=ld, h=14);
                translate([-lx,  ly, 0]) cylinder(d=ld, h=14);
                translate([-lx, -ly, 0]) cylinder(d=ld, h=14);
                translate([ lx,  ly, 0]) cylinder(d=ld, h=14);
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
translate([(131-92)/2, 11]) %CEE_Shape();