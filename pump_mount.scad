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

module pump_mount() {
  thickness = 1.5;

  difference() {
    union() {
      intersection() {
        translate([0, 0, thickness/2])
          cube([60, 30, thickness], center=true);
        scale([1, 1, 1]) cylinder(r=30, h=10, center=true);
      }
    }
    union() {
      rotate([90, 0, 0]) {
        for(a = [-1, 1]) {
          translate([a*extrusion*1.5, -extrusion/2, 0]) {
            % extrusion_cutout(100+10, 2*extra_radius);
            translate([0, 8, 0]) rotate([90, 0, 0])
              cylinder(r=m3_radius+.3, h=5, center=true);
            }
        }
      }

    }
  }
};

pump_mount();
