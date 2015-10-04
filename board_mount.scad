include <configuration.scad>;
use <frame_motor.scad>;

$fn = 24;
roundness = 6;

board_length = 160.274;
board_width = 76.2;
board_height = 2;
board_mount_length = 151.638;
board_mount_width = 67.564;

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

module board_mount(h) {
  thickness = 3;
  length = board_length;
  width = board_width;
  mount = -width/2 - thickness/2;
  height = extrusion;
  extra = 3;

  difference() {
    union() {
      intersection() {
        union() {
          translate([board_width + extrusion, 0, thickness/2]) {
            rotate([0, 0, 180])
              cylinder(r=276, h=thickness, center=true, $fn=3);
          }

          for (a = [1, -1]) {
            rotate([0, 0, 30*a]) translate([width, (100 - extrusion/2)*a, height/2])
              cube([width * 2, thickness, height], center=true);
          }
        }

        rotate([0, 0, 270]) translate([0, 0, height/2])
          cube([length * 2, width + extra, height], center=true);
      }

      for (x = [-board_mount_width / 2, board_mount_width / 2]) {
        for (y = [-board_mount_length / 2, board_mount_length / 2]) {
          translate([x, y, thickness])
            cylinder(r1=m3_nut_radius + 2, r2=m3_nut_radius + 1, h=m3_nut_thickness + 3, center=true);
        }
      }
    }

    union() {
      translate([0, 0, thickness - 1])
        for (x = [-board_mount_width / 2, board_mount_width / 2]) {
          for (y = [-board_mount_length / 2, board_mount_length / 2]) {
            translate([x, y, 0]) screw_socket();
            translate([x, y, -1.2]) rotate([0, 0, 90])
              cylinder(r=m3_nut_radius, h=m3_nut_thickness, center=true, $fn=6);
          }
        }

      for (a = [1, -1]) {
        translate([0, (length/2 + 35 - extrusion/2) * a, extrusion/2]) rotate([90*a, 0, 30*a])
          for (x = [-board_mount_width / 2, board_mount_width / 2]) {
            translate([x, 0, 0]) screw_socket();
          }
      }

      translate([9, 0, thickness/2]) rotate([0, 0, 180])
        cylinder(r=width/2, h=thickness+1, center=true, $fn=3);
      translate([-9, width/2 + 2.5, thickness/2]) rotate([0, 0, 0])
        cylinder(r=width/2, h=thickness+1, center=true, $fn=3);
      translate([-9, -width/2 - 2.5, thickness/2]) rotate([0, 0, 0])
        cylinder(r=width/2, h=thickness+1, center=true, $fn=3);
      translate([9, -width - 5, thickness/2]) rotate([0, 0, 180])
        cylinder(r=width/2, h=thickness+1, center=true, $fn=3);
      translate([9, width + 5, thickness/2]) rotate([0, 0, 180])
        cylinder(r=width/2, h=thickness+1, center=true, $fn=3);
    }
  }
}

translate([0, 0, 0]) rotate([0, 0, 0]) board_mount(extrusion * 3);
