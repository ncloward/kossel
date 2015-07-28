include <configuration.scad>;

// Belt parameters
belt_width_clamp = 6;              // width of the belt, typically 6 (mm)
belt_thickness = 1.0 - 0.05;       // slightly less than actual belt thickness for compression fit (mm)
belt_pitch = 2.0;                  // tooth pitch on the belt, 2 for GT2 (mm)
tooth_radius = 0.8;                // belt tooth radius, 0.8 for GT2 (mm)

separation = 40;
thickness = 3;

horn_thickness = 9;
horn_x = 15;

belt_width = 5;
belt_x = 5.6;
belt_z = 4;
corner_radius = 3.5;

module carriage() {
  // Timing belt (up and down).
  translate([-belt_x, 0, belt_z + belt_width/2]) %
    cube([1.7, 100, belt_width], center=true);
  translate([belt_x, 0, belt_z + belt_width/2]) %
    cube([1.7, 100, belt_width], center=true);

  difference() {
    union() {
      // Main body.
      translate([0, 5, thickness/2])
        cube([34, 45, thickness], center=true);

      // Ball joint mount horns.
      for (x = [-1, 1]) {
        scale([x, 1, 1]) intersection() {
          translate([0, 17, horn_thickness/2])
            cube([separation, 21, horn_thickness], center=true);
          translate([horn_x, 21, horn_thickness/2]) rotate([0, 90, 0])
            cylinder(r1=14, r2=2.5, h=separation/2-horn_x);
        }
      }

      // Avoid touching diagonal push rods (carbon tube).
      difference() {
        translate([11.5, 5, horn_thickness/2+1])
          cube([11, 45, horn_thickness-2], center=true);
        translate([25, -9, 11.5]) rotate([28, 30, 34])
          cube([50, 50, 20], center=true);
      }
      difference() {
        translate([-12.5, 5, horn_thickness/2+1])
          cube([9, 45, horn_thickness-2], center=true);
        translate([-25, -9, 11.5]) rotate([28, -30, -34])
          cube([50, 50, 20], center=true);
      }

      // Belt clamps.
      for (y = [[10, -1], [0, 1]]) {
        translate([0.5, y[0], horn_thickness/2+1])
          color("green") hull() {
            translate([ corner_radius,  -y[1] * corner_radius + y[1], 0])
              cube([1.0, 5, horn_thickness-2], center=true);
            cylinder(h=horn_thickness-2, r=corner_radius, $fn=12, center=true);
          }
      }
      for (y = [[20, -1], [-10, 1]]) {
        translate([0.30, y[0], horn_thickness/2+1])
          rotate([0, 0, 180]) color("blue") hull() {
            translate([corner_radius-0.5, -y[1] * corner_radius + y[1], 0])
              cube([1.0, 5, horn_thickness-2], center=true);
            cylinder(h=horn_thickness-2, r=corner_radius, $fn=12, center=true);
            translate([0,  y[1]*4, 0])
              cube([2*corner_radius, 0.5*corner_radius + 5.25, horn_thickness-2], center=true);
          }
      }
    }

    // Screws for linear slider.
    for (x = [-13, 13]) {
      for (y = [-13, 13]) {
        translate([x, y, thickness]) #
          cylinder(r=m4_wide_radius, h=30, center=true, $fn=12);
        translate([x, y, horn_thickness - (3.5 / 2) + .5])
          cylinder(r=m4_wide_radius+1.5, h=3.5 + 1, center=true, $fn=12);
      }
    }

    hull() {
      translate([13, 13, horn_thickness - (3.5 / 2) + .5])
        cylinder(r=m4_wide_radius+1.5, h=3.5 + 1, center=true, $fn=12);
      translate([16, 12.2, horn_thickness - (3.5 / 2) + .5]) rotate([0, 0, 75])
        cube([m4_wide_radius * 2, m4_wide_radius * 2,  4.5], center=true);
    }

    hull() {
      translate([-13, 13, horn_thickness - (3.5 / 2) + .5])
        cylinder(r=m4_wide_radius+1.5, h=3.5 + 1, center=true, $fn=12);
      translate([-16, 12.2, horn_thickness - (3.5 / 2) + .5]) rotate([0, 0, -75])
        cube([m4_wide_radius * 2, m4_wide_radius * 2,  4.5], center=true);
    }

    // Screws for ball joints.
    translate([-30, 21, horn_thickness/2]) rotate([0, 90, 0]) #
      cylinder(r=m3_wide_radius, h=30, center=true, $fn=12);
    translate([30, 21, horn_thickness/2]) rotate([0, 90, 0]) #
      cylinder(r=m3_wide_radius, h=30, center=true, $fn=12);

    // Lock nuts for ball joints.
    for (x = [-1, 1]) {
      scale([x, 1, 1]) # hull() {
        translate([horn_x - 3.7 + 2.5, 21, horn_thickness/2]) rotate([90, 0, -90])
          cylinder(r1=m3_nut_radius, r2=m3_nut_radius, h=m3_nut_thickness, center=true, $fn=6);
        translate([horn_x - 3.7 + 2.5, 25, horn_thickness/2])
          cube([m3_nut_thickness, 10, m3_nut_radius * 2 -.9], center=true);
      }
    }
  }
}

carriage();
