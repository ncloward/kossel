include <configuration.scad>;

$fn = 24;
roundness = 6;

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

module screw_socket_cone() {
  union() {
    screw_socket();
    scale([1, 1, -1]) cylinder(r1=4, r2=7, h=4);
//    scale([1, 6, -1]) # cylinder(r=7, h=4);
  }
}

module vertex(height, idler_offset, idler_space, ears=true, screw_spacing=30, screw_spacing_vertex=30) {
  union() {
    if(ears) {
      // Pads to improve print bed adhesion for slim ends.
      translate([-(37.5 + idler_offset/2), 52.2 + idler_offset, height/2-0.5]) cylinder(r=8, h=0.5);
      translate([(37.5 + idler_offset/2), 52.2 + idler_offset, height/2-0.5]) cylinder(r=8, h=0.5);
    }

    difference() {
      union() {
        intersection() {
          translate([0, 22, 0])
            cylinder(r=36, h=height, center=true, $fn=60);
          translate([0, -37, 0]) rotate([0, 0, 30])
            cylinder(r=50, h=height+1, center=true, $fn=6);
        }
        translate([0, 38, 0]) intersection() {
          translate([0, idler_offset, 0]) rotate([0, 0, -90])
            cylinder(r=55 + idler_offset, h=height, center=true, $fn=3);
          translate([0, 10, 0])
            cube([100 + idler_offset, 100 + idler_offset, 2*height], center=true);
          translate([0, -10, 0]) rotate([0, 0, 30])
            cylinder(r=55 + idler_offset, h=height+1, center=true, $fn=6);
        }
      }
      difference() {
        translate([0, 58, 0]) minkowski() {
          intersection() {
            rotate([0, 0, -90])
              cylinder(r=55, h=height, center=true, $fn=3);
            translate([0, -32 + idler_offset / 2, 0])
              cube([100, 16 + idler_offset, 2*height], center=true);
          }
          cylinder(r=roundness, h=1, center=true);
        }
        // Idler support cones.
        translate([0, 26+idler_offset-30, 0]) rotate([-90, 0, 0])
          cylinder(r1=30, r2=2, h=30-idler_space/2);
        translate([0, 26+idler_offset+30, 0]) rotate([90, 0, 0])
          cylinder(r1=30, r2=2, h=30-idler_space/2);
      }
      translate([0, 58, 0]) minkowski() {
        intersection() {
          rotate([0, 0, -90])
            cylinder(r=55, h=height, center=true, $fn=3);
          translate([0, 7 + idler_offset, 0])
            cube([100, 30, 2*height], center=true);
        }
        cylinder(r=roundness, h=1, center=true);
      }
      extrusion_cutout(height+10, 2*extra_radius);

      for (z = [0:screw_spacing_vertex:height]) {
        translate([0, -7.5-extra_radius, z+7.5-height/2]) rotate([90, 0, 0])
          screw_socket_cone();
      }

      for (z = [0:screw_spacing:height]) {
        for (a = [-1, 1]) {
          rotate([0, 0, 30*a]) translate([-16*a, 111, z+7.5-height/2]) {
            // % rotate([90, 0, 0]) extrusion_cutout(200, 0);
            // Screw sockets.
            for (y = [-90 + (idler_offset / 4) * 3, -44 + (idler_offset / 4) * 3]) {
              translate([a*7.5, y, 0]) rotate([0, a*90, 0]) screw_socket();
            }
            // Nut tunnels.
            for (z = [-1, 1]) {
              scale([1, 1, z]) translate([0, -100, 3]) minkowski() {
                rotate([0, 0, -a*30]) cylinder(r=4, h=height/2+1, $fn=6);
                cube([0.1, 5, 0.1], center=true);
              }
            }
          }
        }
      }
    }
  }
}

translate([0, 0, 7.5]) vertex(15, idler_offset=15, idler_space=10);
