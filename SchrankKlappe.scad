$fn = 64;

module Hohlwanddose(h) {
    linear_extrude(h) hull() {
        translate([-35,0, 0]) circle(d=65);
        translate([ 35,0, 0]) circle(d=65);
    }
    %translate([(135-65-152)/2-35, -81/2, h]) {
        cube([152, 81, 1]);
    }
}

module Loch() {
    translate([0, 0]) circle(d=4);
    translate([127, 0]) circle(d=4);
    translate([0, 216]) circle(d=5);
    translate([127, 216]) circle(d=5);
    translate([104, 67.5]) circle(d=4);
    translate([23, 67.5]) circle(d=4);

    translate([2.5, 20]) square([122, 37]);
    translate([2.5, 77]) square([122, 132]);

    translate([-15, -40, 0]) square([160, 10]);
    translate([-25, -40, 0]) square([10, 300]);
    translate([145, -40, 0]) square([10, 300]);
}

dicke = 5;
rand = 14;
rand_oben = 8;

module Platte() {
    difference() {
        intersection() {
            translate([-rand, -rand, 0]) {
                cube([127+2*rand, 216+2*rand+rand_oben, dicke]);
            }

            translate([-rand+(dicke-1), -rand+(dicke-1)]) {
                minkowski() {
                    cube([127+2*(rand-(dicke-1)), 216+2*(rand-(dicke-1))+rand_oben, 1]);
                    sphere(dicke-1);
                }
            }
        }

        union() {
            translate([2.5+122/2, 77+132/2, -1]) {
                rotate([0, 0, -115]) Hohlwanddose(dicke + 2);
            }

            loecher = [
                [0, 0],
                [127, 0],
                [0, 216],
                [127, 216],
                [104, 67.5],
                [23, 67.5]
            ];

            for (loch = loecher) {
                translate([loch.x, loch.y, -1]) {
                    cylinder(d=4.5, h=dicke + 2);

                    translate([0, 0, dicke-0.995]) {
                        cylinder(d1=4.5, d2=8, h=2);
                    }
                }
            }
        }
    }
}

module BoundingBox() {
    translate([-25, -40, -1]) cube([180, 300, dicke + 2]);
}

module Zungen() {
    for (p = [[104, 67.5], [23, 67.5]]) {
        translate([p.x-15, p.y-10.5, -1]) cube([30, 21, dicke/2+1]);
    }
}

module MaskeOben() {
    difference() {
        translate([-25, 57, -1]) cube([180, 300, dicke + 2]);
        minkowski() {
            Zungen();
            sphere(d=0.1);
        }
    }
}

module MaskeUnten() {
    translate([-25, -40, -1]) cube([180, 97, dicke + 2]);
    Zungen();
}


%Loch();
Platte();
