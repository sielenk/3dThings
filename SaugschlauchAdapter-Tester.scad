use <SaugschlauchAdapter.scad>

outer_width = 49.4;
ridge_width = 40;
inner_width = 32;
ridge_height = 2;
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
        [0, length + 10],
        [0, length + 5],
        [inner_width/2 - 5, length + 5],
        [inner_width/2 - 5, length - ridge_height - 5],
        [outer_width/2 - 5, length - ridge_height - 5],
        [outer_width/2 - 5, 5],
        [0, 5],
    ]);
}

linear_extrude(2) {
    probe();
    mirror([1, 0, 0]) probe();
}

translate([0, -20, 4]) intersection() {
    translate([0, 0, 0]) cube([40, 40, 8], center = true);
    rotate([180, 0, 0]) diffuser();
}
