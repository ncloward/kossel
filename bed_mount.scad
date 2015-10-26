include <configuration.scad>;

$fn = 32;

extra = .1;

module extrusion_cutout(h, extra) {
  difference() {
    cube([extrusion+extra, extrusion+extra, h], center=true);
    for (a = [0:90:359]) rotate([0, 0, a]) {
      translate([extrusion/2, 0, 0])
        cube([6, 2.5, h+1], center=true);
    }
  }
}

module screw_socket() {
  cylinder(r=m3_wide_radius, h=8, center=true);
  translate([0, 0, 3]) cylinder(r=3.5, h=9);
}

module bed_mount() {
  height=10;
  width=15;
  length=30;

  difference() {
    union() {
      translate([0, 0, height/2])
        cube([length, width, height], center=true);
    }
    union() {
      for(a = [1, -1]) {
        translate([a*9, 0, -1])
          screw_socket();
      }

      translate([0, 0, height/2])
        cylinder(r=m3_wide_radius, h=height+1, center=true);

      translate([0, 0, m3_nut_thickness/2 + 6]) rotate([0, 0, 90])
        cylinder(r=m3_nut_radius + extra, h=2.5 + 3 * extra, center=true, $fn=6);
      translate([0, 5, m3_nut_thickness/2 + 6])
		    cube([5.5 + 4.8 * extra, 10, 2.5 + 3 * extra], center = true);
    }
  }
}


bed_mount();
//translate([0, 0, -15/2]) rotate([0, 90, 0])
//  % extrusion_cutout(100, 0);
