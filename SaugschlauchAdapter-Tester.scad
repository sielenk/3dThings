use <SaugschlauchAdapter.scad>

outer_width = 49.8;
ridge_width = 36;
inner_width = 32;
ridge_height = 1;
length = 37;


module probe() {
    polygon([
        [0, 0],
        [outer_width/2, 0],
        [outer_width/2, length],
        [ridge_width/2, length],
        [ridge_width/2, length - ridge_height],
        [inner_width/2, length - ridge_height],
        [inner_width/2, length + 10],
        [0, length + 10]
    ]);
}

linear_extrude(0.8) {
    probe();
    mirror([1, 0, 0]) probe();
}

translate([0, -20, 4]) intersection() {
    translate([0, 0, 0]) cube([40, 40, 8], center = true);
    rotate([180, 0, 0]) diffuser();
}
