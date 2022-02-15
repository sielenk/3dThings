use <ZaehlerAdapter.scad>;

PCB(8);

difference() {
  union() {
    difference() {
      translate([-3*2.54 - 0.5, -4*2.54, 0]) minkowski() {
        cube([7*2.54, 8*2.54, 9]);
        cylinder(h=1, r=1.5, $fn=64);
      }
      union() {
        translate([-3*2.54 - 0.5, -4*2.54, 1]) minkowski() {
          cube([7*2.54, 8*2.54, 9]);
          cylinder(h=1, r=0.5, $fn=64);
        }
      }
    }
    translate([-3.04 - 2, -2*2.54, 1]) {
      difference() {
        cube([4, 4*2.54, 1]);

        translate([0, 0, 1])
        scale([1, 1, 1/(2*sqrt(2))])
        rotate([0, 45, 0])
        cube([4/sqrt(2), 4*2.54, 4/sqrt(2)]);
      }
    }
  }

  union() {
    translate([-8.1, 0, 6]) rotate([0, -90, 0]) minkowski() {
      cylinder(h=1, d=8, $fn=32);
      cube([5, 1, 1]);
    }
    translate([-3.04, 0, -3]) {
      translate([0, +2*2.54, 0]) ScrewSpace(0);
      translate([0, -2*2.54, 0]) ScrewSpace(0);
    }
  }
}
