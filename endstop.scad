include <configuration.scad>;

use <microswitch.scad>;

thickness = 16;  // 1mm thicker than linear rail.
width = 15;  // Same as vertical extrusion.
height = 25;
bolts = 3;

endstop_height = 15/2;
offset = 8;
top_gap = 2;

module endstop() {
  working_length = height - 15/2 + offset;

  difference() {
    union() {
      cube([width, thickness, height], center=true);
      translate([0, 0, -height/2 + endstop_height/2])
        cube([width+2, thickness, endstop_height], center=true);
      translate([0, 2, 0])
        cube([2.5, thickness, height], center=true);
    }
    translate([0, 0, -height/2 + endstop_height])
      polyhedron(
          points = [
          [-(width+2)/2, -thickness/2, height-endstop_height], //x=0, y=0, z=0
          [(width+2)/2, -thickness/2, height-endstop_height],  //x=1, y=0, z=0
          [-(width+2)/2, -thickness/2, 0], //x=0, y=1, z=0
          [(width+2)/2, -thickness/2, 0], //x=1, y=1, z=0
          [-(width+2)/2, thickness/2 - 3.6, height-endstop_height], //x=0, y=1, z=1
          [(width+2)/2, thickness/2 - 3.6, height-endstop_height], //x=1, y=1, z=1
          ],
          faces = [
          [0,1,2],
          [1,3,2],
          [0,2,4],
          [3,1,5],
          [2,3,4],
          [4,3,5],
          [1,0,5],
          [0,4,5],
          ]
          );
    rotate([90, 0, 0]) {
      hole_rad = 3;
      //        translate([0, endstop_height, 3.6])
      //            cube([width+2, height, thickness], center=true);
      translate([0, working_length/2 - hole_rad - top_gap + endstop_height/2 - offset/2, 3.6-thickness/2])
        cylinder(r=hole_rad, h=20, $fn=24);
      translate([0, -(working_length/2 - hole_rad - top_gap) + endstop_height/2 - offset/2, 3.6-thickness/2])
        cylinder(r=hole_rad, h=20, $fn=24);
      translate([0, endstop_height/2 - offset/2, 3.6-thickness/2 + thickness])
        cube([6, working_length - hole_rad*2 - top_gap*2, thickness*2], center=true);
      for (i = [-1:3/bolts:1]){
        translate([0, i*(working_length/2 - hole_rad - top_gap) + endstop_height/2 - offset/2, -thickness/2]){
          cylinder(r=m3_wide_radius, h=20, center=true, $fn=12);
          scale([1, 1, -1])
            cylinder(r1=m3_wide_radius, r2=7, h=4, $fn=24);
        }
      }
    }
    translate([0, -3-thickness/2, -height/2 + 15/4 + 2]) rotate([0, 180, 0]) {
      % microswitch();
      for (x = [-9.5/2, 9.5/2]) {
        translate([x, 0, 0]) rotate([90, 0, 0])
          cylinder(r=2.5/2, h=thickness*3, center=true, $fn=12);
      }
    }
  }
}

translate([0, 0, height/2]) endstop();
