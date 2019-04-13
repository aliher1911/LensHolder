include <Dimensions.scad>

module bottom(color=undef) {
	color(color) difference() {
		union() {
			difference() {
				cylinder(bottom_height, r=outer_radius, $fn=180);
				// inner tube that holds the lens
				cylinder(bottom_height, r=inner_radius, center = true, $fn=180);
				// inner diameter to fit lens
				translate([0, 0, lens_overhang_thickness])
				    cylinder(bottom_height+1, r=lens_radius, $fn=180);
				// outer space to hold LED wires/resisors
				translate([0, 0, 5])
					ring(led_height, lens_radius + ring_width + 1, lens_radius + ring_wall, center=false, $fn=180);
				// LED holes
				for(angle = [0:led_angle:359]) {
					rotate([0, 0, angle + led_offset_angle])
						translate([-lens_radius - ring_wall, 0, 0])
							rotate([0, -45, 0])
								union() {
									cylinder(100, d=led_diameter, center = true, $fn=50);
									translate([0, 0, 25 + led_height]) cylinder(50, d=led_flange_diameter, center = true, $fn=50);
								}
				}
			}
			// part to hold an axle
			translate([lens_radius + ring_wall + axle_holder_length/2, 0, axle_z_offset/2])
				cube([axle_holder_length, axle_diameter * 4, axle_z_offset], center=true);

		}
		// hole for axle
		translate([lens_radius + ring_wall, 0, axle_z_offset]) rotate([0, 90, 0])
			bolt($fn=20);
		// hole for nut
		translate([lens_radius + ring_wall + axle_holder_length/2, axle_holder_length/2.5, 0]) rotate([180, 0, 0])
			nut_side_hole();
		translate([lens_radius + ring_wall + axle_holder_length/2, -axle_holder_length/2.5, 0]) rotate([180, 0, 0])
			nut_side_hole();
		translate([-(lens_radius + ring_wall + nut_diameter/1.5), 0, 0]) rotate([180, 0, 0])
			nut_side_hole();
	}
}

bottom();