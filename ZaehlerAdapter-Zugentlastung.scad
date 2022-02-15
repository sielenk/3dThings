use <ZaehlerAdapter.scad>;

translate([3.04, 0, 0]) PCB(-1.8);

difference() {
  translate([-2, -2*2.54, 0]) {
    intersection() {
      cube([4, 4*2.54, 1]);

      scale([1, 1, 1/(2*sqrt(2))])
      rotate([0, 45, 0])
      cube([4/sqrt(2), 4*2.54, 4/sqrt(2)]);
    }
  }

  translate([0, 0, -3]) {
    translate([0, +2*2.54, 0]) ScrewSpace(0);
    translate([0, -2*2.54, 0]) ScrewSpace(0);
  }
}
