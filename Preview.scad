use <Top.scad>
use <Bottom.scad>
//use <Dimensions.scad>


translate([0, 0, 7]) rotate([0, 0, 0])
	top(color="red");

bottom();


/*
difference() {
	cube([10, 10, 5]);
	rotate([180, 0, 0]) translate([5, -5, 0]) nut_side_hole();
}

translate([20, 0, 0]) difference() {
	cube([10, 10, 5]);
	rotate([180, 0, 0]) translate([5, -5, 0]) bolt_side_hole();
}
*/