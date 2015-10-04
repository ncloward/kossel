include <configuration.scad>;
use <frame_motor.scad>;
use <board_mount.scad>;

module extrusion_cutout(h, extra) {
  difference() {
    cube([extrusion+extra, extrusion+extra, h], center=true);
    for (a = [0:90:359]) rotate([0, 0, a]) {
      translate([extrusion/2, 0, 0])
        cube([6, 2.5, h+1], center=true);
    }
  }
}

extrusion = 15;
extra = 60;
length = 418;
r = 276;
h = 413.9601;
m = 585.428;

rotate([0, 0, 30]) translate([0, -m/2 + 38, extrusion*3/2]) frame_motor();
rotate([0, 0, 150]) translate([0, -m/2 + 38, extrusion*3/2]) frame_motor();
rotate([0, 0, 270]) translate([0, -m/2 + 38, extrusion*3/2]) frame_motor();

rotate([90, 0,  30 - 30]) translate([r/2, extrusion/2, 0]) % extrusion_cutout(length, 0);
rotate([90, 0, 150 - 30]) translate([r/2, extrusion/2, 0]) % extrusion_cutout(length, 0);
rotate([90, 0, 270 - 30]) translate([r/2, extrusion/2, 0]) % extrusion_cutout(length, 0);

rotate([90, 0,  30 - 30]) translate([r/2, extrusion/2 + 30, 0]) % extrusion_cutout(length, 0);
rotate([90, 0, 150 - 30]) translate([r/2, extrusion/2 + 30, 0]) % extrusion_cutout(length, 0);
rotate([90, 0, 270 - 30]) translate([r/2, extrusion/2 + 30, 0]) % extrusion_cutout(length, 0);

//rotate([0, 0, 180]) cylinder(r=r ,center=true, $fn=3);
//translate([0, 0, extrusion*3 + 1.5]) cylinder(d=300, h=3 ,center=true);
translate([0, 0, extrusion*3 + 2]) rotate([0, 0, 45]) cube([304.8, 304.8, 4], center=true);

translate([-73, 0, 0]) rotate([0, 0, 0]) frame_board(extrusion * 3);
