include <configuration.scad>;

reservoir_radius = 75.5 / 2;
reservoir_height = 75 * 2;
thickness = 2;

$fn = 128;

module screw_socket() {
  cylinder(r=m3_wide_radius, h=10, center=true);
  translate([0, 0, 3.8]) cylinder(r=3.5, h=8);
}

module reservoir_mount() {
  difference() {
    hull() {
      translate([0, 0, reservoir_height/8])
        cylinder(r=reservoir_radius + thickness, h=reservoir_height/4, center=true);

      translate([0, reservoir_radius + 10 - thickness, reservoir_height/8])
        cube([15 + thickness*2, 15 + thickness, reservoir_height/4], center=true);
    }
    union() {
      translate([0, 0, reservoir_height/2 + thickness])
        cylinder(r=reservoir_radius, h=reservoir_height, center=true);

      hull() {
        for (a = [1, -1]) {
          translate([reservoir_radius/2.5*a, 0, thickness/2])
            cylinder(r=reservoir_radius/3, h=thickness+2, center=true);
        }
      }

      translate([0, reservoir_radius + 10, reservoir_height/8])
        cube([15, 15, reservoir_height/4+2], center=true);

      for (a = [1, -1]) {
        for (z = [reservoir_height/16, -reservoir_height/16]) {
          translate([6*a, reservoir_radius+10, reservoir_height/8-z]) rotate([0, 90*a, 0])
            # screw_socket();
        }
      }

      translate([0, -reservoir_radius/1.5, -2.2]) scale([0.14, 0.14, 1]) rotate([0, 180, 0])
        import("logotype.stl");
    }
  }
}

reservoir_mount();
