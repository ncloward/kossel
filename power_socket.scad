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

module power_socket() {
  thickness = 1.4;

  difference() {
    union() {
      intersection() {
        translate([0, 0, thickness/2])
          cube([60, 60, thickness], center=true);
        scale([1.1, 0.8, 1]) cylinder(r=38, h=10, center=true);
      }
    }
    union() {
      translate([0, 0, -socket_thickness/2 + 4])
        cube([socket_width + extra, socket_length + extra, socket_thickness], center=true);

      rotate([90, 0, 0]) {
        for(a = [-1, 1]) {
          translate([a*extrusion*1.5, -extrusion/2, 0]) {
            % extrusion_cutout(100+10, 2*extra_radius);

          for(x = [-1, 1]) {
            translate([0, 8, x*20]) rotate([90, 0, 0])
              cylinder(r=m3_radius+.3, h=5, center=true);
            }
          }
        }
      }

    }
  }
};



power_socket();
