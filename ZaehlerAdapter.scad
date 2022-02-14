module Body() {
  hull() {
    translate([-3*2.54 - 0.5, -4*2.54, 14.5])
      cube([7*2.54, 8*2.54, 0.5]);
    translate([0, 0, 3]) cylinder(h=1, d=17.3, $fn=64);
  }

  cylinder(h=3, d=17.3, $fn=64);
  rotate([0, 0, -45]) union() {
    translate([0, +8, 0]) cylinder(h=2.2, r=0.9, $fn=64);
    translate([0, -8, 0]) cylinder(h=2.2, r=0.9, $fn=64);
    intersection()
    {
      cylinder(h=1.2, d=20, $fn=64);
      translate ([-1.75, -12.5, 0]) cube([3.5, 25, 5]);
    }
  }
}

module LightSpace() {
  translate([3.35, 0, 10]) cylinder(h=5, d= 6, $fn=64);
  hull() {
    cylinder(h=2.5, d=15, $fn=64);
    translate([3.35, 0, 9]) cylinder(h=1, d=6, $fn=64);
  }
}

module ScrewSpace(stretch) {
  translate([0, 0, 1.5]) minkowski() {
    hull() {
      sphere(d=0.4, $fn=16);
      translate([0, stretch, 0]) sphere(d=0.4, $fn=16);
    }
    union() {
      cylinder(h=14, d=3, $fn=64);
      translate([0, 0, -1.5]) cylinder(h=1.5, d1=5.5, d2=3, $fn=64);
    }
  }
}

difference() {
  Body();
  union() {
    LightSpace();
    translate([-3.04, 0, 10]) union() {
      translate([0, +2*2.54, 0]) ScrewSpace(+7);
      translate([0, -2*2.54, 0]) ScrewSpace(-7);
    }
  }
}

%translate([-3*2.54 - 0.5, -4*2.54, 15]) {
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
