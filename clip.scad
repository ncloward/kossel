// Cable clip for 1515 (and other) extrusion on Kossel Mini
// Licence: CC BY-SA 3.0, http://creativecommons.org/licenses/by-sa/3.0/
// Author: Dominik Scholz <schlotzz@schlotzz.com> and contributors
// visit: http://www.schlotzz.com

// avoid OpenScad artefacts
epsilon = 0.1;


// size settings
extra_width = 0.25;
thickness = 1.5;
width = 15 + extra_width;
depth = 15 + extra_width;
height = 15 + thickness * 2;
outer_radius = 2;
inner_radius = 1;
slot_width = 3.25;
slot_depth = 0.75;


// rounded rectangle
module rounded_rectangle(size = [1, 1, 1], r = 0)
{
  union()
  {
    cube([size[0], size[1] - r * 2, size[2]], true);
    cube([size[0] - r * 2, size[1], size[2]], true);
    for (x = [-size[0] / 2 + r, size[0] / 2 - r])
      for (y = [-size[1] / 2 + r, size[1] / 2 - r])
        translate([x, y, 0])
          cylinder(size[2], r, r, true);
  }
}


// base of glas bed holder
module cable_clip()
{

  difference()
  {

    union() {

      // base
      translate([0, thickness / 2, 0])
        rounded_rectangle([width + thickness * 2, depth + thickness, height], r = outer_radius, $fn = 32);

      translate([0, thickness / 2 + 2.5, 0])
        rounded_rectangle([width + thickness * 2, depth + thickness, height], r = outer_radius, $fn = 32);
    }

    // inner cutout
    translate([0, - inner_radius - epsilon / 2.5, 0])
      rounded_rectangle([width, depth + inner_radius * 2 + epsilon, height + 2 * epsilon], r = inner_radius, $fn = 32);

    translate([0, - inner_radius - epsilon / 2 + 2, 0])
/      rounded_rectangle([width - 6, depth + inner_radius * 2 + epsilon, height + 2 * epsilon], r = inner_radius, $fn = 32);
  }

  // slot inserts
  //	translate([0, -slot_depth / 2 + depth / 2, 0])
  //		cube([slot_width, slot_depth, height], center = true);
  for (i = [-1, 1])
    translate([i * (slot_depth - depth) / 2, 0])
      cube([slot_depth, slot_width, height], center = true);

}

cable_clip();
