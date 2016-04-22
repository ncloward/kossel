include <configuration.scad>;

$fn = 24;
roundness = 6;

extra = 1;

socket_thickness = 21;
socket_width = 27;
socket_length = 46.5;

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
  translate([0, 0, 3.8]) cylinder(r=3.5, h=18);
}

module screw_socket_cone() {
  union() {
    screw_socket();
    translate([0, 0, 2.6])
      scale([1, 1, -1]) cylinder(r1=4, r2=7, h=4);
  }
}

module brace_mount(multiplier=1) {
  height = 45 * multiplier;

  difference() {
    union() {
      intersection() {
        translate([0, 0, -17]) rotate([0, 90, 0])
          cylinder(r=36, h=height, center=true, $fn=60);
        translate([0, 0, 20])
          cube([61, 70, 40], center=true);
      }
    }
    union() {
      translate([-19, 0, extrusion/2]) rotate([0, 90, 0])
        extrusion_cutout(100, 2*extra_radius);
      translate([0, 0, -3])
        cube([height+2, extrusion, extrusion], center=true);

      rotate([90, 0, 0]) {
        for(a = [-1, 1]) {
          translate([a*extrusion*multiplier, -extrusion/2, 0]) {
            //            % extrusion_cutout(100, 2*extra_radius);

            for(y = [-1, 1]) {
              translate([0, 5, y*20]) rotate([-90, 0, 0])
                screw_socket();
            }

            translate([0, 20, 0]) rotate([-90, 0, 0])
              screw_socket_cone();
          }
        }
      }
    }
  }
};

translate([-5, 0, 45/2]) rotate([0, 90, 180])
  brace_mount();

translate([5, 0, 60/2]) rotate([0, 90, 0])
  brace_mount(1.5);
