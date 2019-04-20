lens_diameter = 75;
lens_radius = lens_diameter / 2.0;
lens_thickness = 4.25;
lens_overhang = 2;
axle_diameter = 3.9;
axle_nut_height = 2.8;
axle_nut_diameter = 7;
axle_holder_length = 12;
ring_wall = 3;
lens_overhang_thickness = 2;
led_diameter = 5;
led_count = 10;
led_angle = 360 / led_count;
led_offset_angle = led_angle / 2;
led_height = 5;
led_flange = 1.5; // thickness
led_flange_diameter = 7;
led_retain_offset = 3.5;
bottom_height = 9;
top_height = 2;
outer_wall = 2;
slot_count = 30;
ring_width = ring_wall + led_diameter + 4;

bolt_diameter = 2; // 1.83;
bolt_head_diameter = 3.5; // 3.34;
bolt_head_thickness = 1.35; // 1.3;
nut_diameter = 4.55; // 4.46;
nut_thickness = 1.8; // 1.63;

// tolerances to fit parts
cylinder_fit = 0.1;

// common derived
outer_radius = lens_radius + ring_width;
inner_radius = lens_radius - lens_overhang;
insert_depth = bottom_height - lens_overhang_thickness - lens_thickness;
axle_z_offset = led_height; // + axle_diameter/2;
full_height = bottom_height + top_height;

module ring(h, r1, r2, $fn, center=false) {
	difference() {
		cylinder(h, r = r1, $fn=$fn, center=center);
		translate([0, 0, -1])
			cylinder(h+2, r = r2, $fn=$fn, center=center);
	}
}

module bolt($fn=$fn) {
	union() {
		cylinder(100, d=axle_diameter, $fn=$fn);
		cylinder(axle_nut_height, d=axle_nut_diameter, $fn=$fn);
	}
}

module bolt_side_hole() {
	translate([0, 0, -bolt_head_thickness]) union() {
		cylinder(100, d=bolt_head_diameter, $fn=50);
		translate([0, 0, -1]) cylinder(1, r2=bolt_head_diameter/2, r1=bolt_diameter/2, $fn=50);
		rotate([180, 0, 0]) translate([0, 0, -1]) cylinder(101, d=bolt_diameter, $fn=50);
	}
}

module nut_side_hole() {
	translate([0, 0, -nut_thickness]) union() {
		cylinder(100, d=nut_diameter, $fn=6);
		translate([0, 0, -1]) cylinder(1, r2=nut_diameter/2 * 0.865, r1=bolt_diameter/2, $fn=50);
		rotate([180, 0, 0]) translate([0, 0, -1]) cylinder(101, d=bolt_diameter, $fn=50);
	}
}
