// Increase this if your slicer or printer make holes too tight.
extra_radius = 0.1;

// OD = outside diameter, corner to corner.
m2_nut_od = 5.1;
m2_nut_radius = m2_nut_od/2 + 0.2 + extra_radius;
m2_nut_thickness = 2.4 + extra_radius;
m2_washer_radius = 3.5 + extra_radius;

// Major diameter of metric 2mm thread.
m2_major = 1.85;
m2_radius = m2_major/2 + extra_radius;
m2_wide_radius = m2_major/2 + extra_radius + 0.2;

// OD = outside diameter, corner to corner.
m3_nut_od = 6.1;
m3_nut_radius = m3_nut_od/2 + 0.2 + extra_radius;
m3_nut_thickness = 2.4 + extra_radius;
m3_washer_radius = 3.5 + extra_radius;

// Major diameter of metric 3mm thread.
m3_major = 2.85;
m3_radius = m3_major/2 + extra_radius;
m3_wide_radius = m3_major/2 + extra_radius + 0.2;

// OD = outside diameter, corner to corner.
m4_nut_od = 7.1;
m4_nut_radius = m4_nut_od/2 + 0.2 + extra_radius;
m4_thickness = 3.82 + extra_radius;
m4_washer_radius = 4.5 + extra_radius;

// Major diameter of metric 3mm thread.
m4_major = 3.85;
m4_radius = m4_major/2 + extra_radius;
m4_wide_radius = m4_major/2 + extra_radius + 0.2;

// NEMA17 stepper motors.
motor_shaft_diameter = 5;
motor_shaft_radius = motor_shaft_diameter/2 + extra_radius;

// Frame brackets. M3x8mm screws work best with 3.6 mm brackets.
thickness = 3.6;

// OpenBeam or Misumi. Currently only 15x15 mm, but there is a plan
// to make models more parametric and allow 20x20 mm in the future.
extrusion = 15;

// Placement for the NEMA17 stepper motors.
motor_offset = 44;
motor_length = 47;
