include <configuration.scad>;

$fn = 24;
roundness = 6;

board_length = 50;
board_width = 50;
board_height = 2;

board_mount_length = 151.638;
board_mount_width = 67.564;

idler_offset=15;

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
  cylinder(r=m3_wide_radius, h=20, center=true);
  translate([0, 0, 3.8]) cylinder(r=3.5, h=5);
}

module breakout_board() {
  difference() {
    cube([board_length, board_width, board_height], center=true);

    for (x = [-40 / 2, 40 / 2]) {
      for (y = [-40 / 2, 40 / 2]) {
        translate([x, y, thickness])
          cylinder(r=m2_wide_radius, h=10, center=true);
      }
    }
  }
}

module breakout_mount(screw_seperation_length, screw_seperation_width) {
  thickness = 2;

  difference() {
    union() {
      hull() {
        translate([0, 0, thickness/2]) {
          minkowski() {
            cube([screw_seperation_length, screw_seperation_length, thickness/2], center=true);
            cylinder(r=3, h=thickness/2, center=true);
          }
        }

        translate([0, 0, thickness/2]) {
          minkowski() {
            cube([12.5, 62, thickness/2], center=true);
            cylinder(r=3, h=thickness/2, center=true);
          }

          // translate([0, 0, -extrusion/2 - thickness/2]) rotate([90, 0, 0])
          //  % extrusion_cutout(100, 0);
        }
      }

      for (x = [-40 / 2, 40 / 2]) {
        for (y = [-40 / 2, 40 / 2]) {
          translate([x, y, thickness + thickness/2])
            cylinder(r1=3, r2=2, h=thickness, center=true);
        }
      }
    }
    union() {
      translate([0, 0, thickness/2]) {
        for (a = [1, -1]) {
          translate([0, 29.5 * a, 0]) screw_socket();
        }
      }


      for (x = [-40 / 2, 40 / 2]) {
        for (y = [-40 / 2, 40 / 2]) {
          translate([x, y, thickness])
            cylinder(r=m2_wide_radius, h=10, center=true);
        }
      }
    }
  }
}

// # color([.8, .5, .5, 0.8]) translate([0, 0, thickness+1]) breakout_board();
translate([0, 0, 0]) rotate([0, 0, 0]) breakout_mount(40, 40);
