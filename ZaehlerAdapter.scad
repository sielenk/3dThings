difference() {
  union() {  
    cylinder(h=15, d=17.3, $fn=100);
    translate([0, +8, 0]) cylinder(h=2.2, r=0.9, $fn=100);
    translate([0, -8, 0]) cylinder(h=2.2, r=0.9, $fn=100);
    intersection()
    {
      cylinder(h=1.2, d=20, $fn=100);
      translate ([-1.75, -12.5, 0]) cube([3.5, 25, 5]);
    }
  }
  union() {
    hull() {
      translate([0, 0, -0.5]) cylinder(h=5.5, d=15, $fn=100);
      rotate([0, 0, 45]) translate([3.35, 0, 15.0]) cylinder(h=0.1, d= 6, $fn=100);
    }

    rotate ([0, 0, 45]) translate([-4*2.54 - 0.5, -4*2.54, 17]) {
      translate([2.54*3, 2.54*2-5, -3]) {
        minkowski() {
          cube([0.1, 5, 0.1]);
          union() {
            cylinder(h=4, d=3, $fn=50);
            translate([0, 0, -2.2]) cylinder(h=2.2, d1=5.7, d2=3, $fn=50);
          }
        }
      }
      translate([2.54*3, 2.54*6, -3]) {
        minkowski() {
          cube([0.1, 5, 0.1]);
          union() {
            cylinder(h=4, d=3, $fn=50);
            translate([0, 0, -2.2]) cylinder(h=2.2, d1=5.7, d2=3, $fn=50);
          }
        }
      }
    }
  }
}

%rotate ([0, 0, 45]) translate([-4*2.54 - 0.5, -4*2.54, 15]) {
  difference() {
    cube([8*2.54, 8*2.54, 1.8]);
    
    union() {
      for(x = [0:8]) {
        for(y = [0:8]) {
          dd = (x==3 && (y==2 || y == 6)) ? 3 : 1.2;
          translate([2.54*x, 2.54*y, -0.1])
            cylinder(h=2, d=dd, $fn=100);
        }
      }
    }
  }
}
