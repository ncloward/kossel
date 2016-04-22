include <configuration.scad>;

$fn = 60;
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
  cylinder(r=m3_wide_radius, h=8, center=true);
  translate([0, 0, 3]) cylinder(r=3.5, h=20);
}

module psu_mount() {
  thickness = 2;
  seperation = 10;

  difference() {
    union() {
      intersection() {
        hull() {
          translate([0, 0, thickness/2])
            cube([60, 15, thickness], center=true);
          translate([-0, 0, seperation - thickness/2])
            cube([60, 15, thickness], center=true);
        }
        scale([1.1, 0.8, 1]) cylinder(r=25, h=seperation*3, center=true);
      }
    }
    union() {
      rotate([90, 0, 0]) {
        for(a = [-1, 1]) {
          translate([a*extrusion*1.5, -extrusion/2, 0]) {
            % extrusion_cutout(100+10, 2*extra_radius);
            translate([0, 7, 0]) rotate([-90, 0, 0])
              screw_socket();
          }
        }
      }
      hull() {
        for(a = [-1, 1]) {
          translate([a*30/2, -1, -5]) {
            translate([0, thickness/2, 0]) rotate([0, 0, 0])
              cylinder(r=3.5, h=13);
          }
        }
      }
      hull() {
        for(a = [-1, 1]) {
          translate([a*30/2, -1, 8]) {
            translate([0, thickness/2, 0]) rotate([0, 0, 0])
              cylinder(r=m3_wide_radius, h=20, center=true);
          }
        }
      }
    }
  }
};

psu_mount();
