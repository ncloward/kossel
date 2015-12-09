m3_dia=3;
m3_bolt_dia=5.5;
hole_length=13.5;
bolt_head_length=5;
bolt_head_offset=3;
bolt_head_flange=1;

outer_bolt_dia=7.6;
outer_dia=4.3;

module spacer() {
  difference(){
    union(){
      cylinder(d=outer_dia*0.95, h=hole_length, $fn=50);
      cylinder(d=outer_bolt_dia*0.95, h=bolt_head_length, $fn=50);
    }
    cylinder(d=m3_dia*1.15, h=hole_length, $fn=50);
    cylinder(d=m3_bolt_dia*1.05, h=(bolt_head_length-bolt_head_offset), $fn=50);
    translate([0,0,bolt_head_length-bolt_head_offset])
      cylinder(d1=m3_bolt_dia, d2=m3_dia, h=bolt_head_flange, $fn=50);
  }
}

columns = 10;
rows = 3;

for(column = [0:columns-1]) {
  for(row = [0:rows-1]) {
    translate([outer_dia*2*column, outer_dia*2*row, 0]) spacer();
  }
}
