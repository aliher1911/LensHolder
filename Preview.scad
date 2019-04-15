use <Top.scad>
use <Bottom.scad>

translate([0, 0, 7]) rotate([0, 0, 0])
	top(color="red");

bottom();
