module Hohlwanddose(h) {
    linear_extrude(h) hull() {
        circle(d=65);
        translate([70,0, 0]) circle(d=65);
    }
    %translate([(135-65-152)/2, -81/2, h]) {
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
}

%Loch();

dicke = 5;
rand = 20;

difference() {
    intersection() {
        translate([-rand, -rand, 0]) {
            cube([127+2*rand, 216+2*rand, dicke]);
        }

        translate([-rand+(dicke-1), -rand+(dicke-1)]) {
            minkowski() {
                cube([127+2*(rand-(dicke-1)), 216+2*(rand-(dicke-1)), 1]);
                sphere(dicke-1);
            }
        }
    }

    translate([124.5-65/2 - 4, 77+132-65/2, -1]) {
        //rotate([0, 0, -135]) Hohlwanddose();
        rotate([0, 0, -110]) Hohlwanddose(dicke + 2);
    }
}