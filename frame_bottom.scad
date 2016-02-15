include <configuration.scad>;

use <vertex.scad>;

$fn = 24;

idler_offset = 14;

module frame_top() {
  difference() {
    union() {
      scale([1, 1, -1])
        vertex(extrusion, idler_offset=idler_offset, idler_space=12.5, ears=false);

      translate([0, 0, extrusion*4/2 - 7.5])
        vertex(extrusion*4, idler_offset=idler_offset, idler_space=100, ears=false, screw_spacing=45, screw_spacing_vertex=100);

      translate([-(37.5 + idler_offset/2), 52.2 + idler_offset, -extrusion/2]) cylinder(r=8, h=0.5);
      translate([(37.5 + idler_offset/2), 52.2 + idler_offset, -extrusion/2]) cylinder(r=8, h=0.5);
    }

    // KOSSEL logotype.
    translate([-20.5, -10, 20]) rotate([90, 90, -30])
      scale([0.11, 0.11, -1]) import("logotype.stl");

    translate([0, 60, 30 - 7.5]) {
      rotate([90, 0, 0]) cylinder(r=12, h=20, center=true, $fn=60);
    }

    // Motor cable paths.
    for (mirror = [-1, 1]) scale([mirror, 1, 1]) {
      translate([-35 - idler_offset / 2, 45 + idler_offset, 30 - 7.5]) rotate([0, 0, -30])
         cube([4, 15, 30], center=true);
      translate([-10 - idler_offset / 2, idler_offset, 30 - 7.5]) rotate([0, 0, -40])
         cube([4, 15, 30], center=true);
      translate([-6, 0, -8.5]) cylinder(r=2.5, h=40);
      translate([-11, 0, 30 - 7.5]) cube([15, 4, 30], center=true);
    }

    // M3 bolt to support idler bearings.
    translate([0, 65, 0]) rotate([90, 0, 0]) #
      cylinder(r=m3_radius, h=55);

    // Vertical belt tensioner.
    translate([0, 10, 0]) rotate([18, 0, 0]) union() {
      cylinder(r=m3_wide_radius, h=30, center=true);
      translate([0, -3, 8]) cube([2*m3_wide_radius, 6, 12], center=true);
      translate([0, 0, -2]) scale([1, 1, -1]) rotate([0, 0, 30]) #
        cylinder(r1=m3_nut_radius, r2=m3_nut_radius+1, h=10, $fn=6);
    }

    translate([0, 10, extrusion*4/2+0.5])
      cube([extrusion + 2*extra_radius, extrusion*2, extrusion*3+1], center=true);
  }
}

translate([0, 0, 7.5]) frame_top();
