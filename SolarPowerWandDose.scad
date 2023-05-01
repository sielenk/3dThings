// (C) 05.2022 Marvin Sielenkemper

$fn = 64;

cable_diameter = 10;
wire_diameter = 4;
hole_diameter = 6;
hole_distance = 9;

tube_length = 4;

base_height = 3;
base_depth  = 14;
base_width  = 20;

cover_thickness = 2;

tolerance = 0.5;


module wedge(d=0) {
    difference() {
        translate([-10, 0, 0]) rotate([90, 0, 90]) linear_extrude(20)
            polygon([[-10, 0], [-10, 1+d], [10, 2+d], [10, 0]]);

        translate([+4.5, -2, 1+d/2]) cube([4.8, 20, 4+d], center=true);
        translate([-4.5, -2, 1+d/2]) cube([4.8, 20, 4+d], center=true);
    }
}

module base() {
    translate([0, base_depth/2, 0]) rotate([90, 0, 0]) {
        linear_extrude(base_depth) polygon([
            [-base_width/2, base_height],
            [-base_width/2-base_height, 0],
            [+base_width/2+base_height, 0],
            [+base_width/2, base_height]]
        );
    }
}

module link() {
    difference() {
        union() {
            translate([+hole_distance/2, 0, -base_height/10])
                cylinder(d=hole_diameter, h=tube_length+base_height/10);
            translate([-hole_distance/2, 0, -base_height/10])
                cylinder(d=hole_diameter, h=tube_length+base_height/10);

            translate([0, 0, -base_height])
                base();
        }

        translate([+hole_distance/2, 0, -base_height-0.5])
            cylinder(d=wire_diameter, h=tube_length+base_height+1);

        translate([-hole_distance/2, 0, -base_height-0.5])
            cylinder(d=wire_diameter, h=tube_length+base_height+1);
    }
}

module link_parts() {
    translate([0, -base_height-1, 0]) intersection() {
        translate([-25, -25, 0]) cube([50, 50, 50]);
        rotate([90, 0, 0]) link();
    }

    translate([0, +base_height+1, 0]) intersection() {
        translate([-25, -25, 0]) cube([50, 50, 50]);
        rotate([-90, 0, 0]) link();
    }
}


module cover_inside(is_inside = false) {
    cover_width    = base_width + (is_inside ? 0 : 2*base_height);
    cover_overhang = 5;
    cover_wire     = 5;
    cover_back     = -base_depth/2;
    cover_front1   = base_depth/2+(is_inside ? 0 : cover_overhang);
    cover_front2   = base_depth/2-(is_inside ? 0 : cover_thickness);
    cover_bottom   = base_height+cover_thickness+tolerance;
    cover_top      = cover_bottom+cable_diameter;
    cover_base     = is_inside ? base_height : 0;

    translate([-cover_width/2, 0, 0]) {
        rotate([90, 0, 90]) linear_extrude(cover_width) polygon([
            [cover_back, cover_base],
            [cover_back, base_height],
            [cover_front2, cover_bottom],
            [cover_front2, cover_base]
        ]);
    }

    translate([0, cover_front1-0.25, (cover_bottom+cover_top)/2]) {
        rotate([-90, 0, 0]) {
            cylinder(
                d=cable_diameter,
                h=cover_wire + (is_inside ? cover_overhang+cover_thickness+0.5 : 0));
        }
    }

    if (is_inside) {
        translate([0, 0, base_height]) rotate([0, 180, 0]) minkowski() {
            base();
            sphere(r=tolerance);
        }
    }

    hull() {
        translate([0, cover_front1, (cover_bottom+cover_top)/2])
        rotate([90, 0, 0])
        linear_extrude(cover_front1-cover_front2+0.1)
        circle(d=cable_diameter);

        translate([-cover_width/2, 0, 0])
        rotate([90, 0, 90])
        linear_extrude(cover_width)
        polygon([
            [cover_back, base_height],
            [cover_back, base_height+0.1],
            [cover_front2, cover_bottom],
        ]);
    }

}

module cover_outside() {
    intersection() {
        translate([-50, -50, 0]) cube([100, 100, 100]);
        minkowski() {
            cover_inside();
            sphere(r=cover_thickness);
        }
    }
}

module cover() {
    difference() {
        cover_outside();
        cover_inside(true);
    }

    %rotate([0, 180, 0]) link();
}

//base();
//cover_inside();
//%cover_outside();
//translate([50, 0, 0]) cover_inside(true);

cover();

translate([0, -20, 0]) link_parts();
