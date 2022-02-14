use <ZaehlerAdapter.scad>;

translate([0, 0 ,0]) {
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
      translate([-3.04, 0, -2]) {
        translate([0, +2*2.54, 0]) ScrewSpace(0);
        translate([0, -2*2.54, 0]) ScrewSpace(0);
      }
    }
  }
}

%translate([-3*2.54 - 0.5, -4*2.54, 8]) {
  difference() {
    cube([7*2.54, 8*2.54, 1.8]);

    union() {
      for(x = [0:8]) {
        for(y = [0:8]) {
          dd = (x==2 && (y==2 || y == 6)) ? 3 : 1.2;
          translate([2.54*x, 2.54*y, -0.1])
            cylinder(h=2, d=dd, $fn=100);
        }
      }
    }
  }
}
