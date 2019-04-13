include <Dimensions.scad>

module top(color=undef) {
    top_full_height = top_height + insert_depth;
    top_holder_height = top_height + bottom_height - axle_z_offset;
    bolt_block_len = bolt_diameter * 3;
    led_support_height = bottom_height - led_height - led_flange;
    color(color) difference() {
        union() { 
            // main cylinder with flange
            difference() {
                cylinder(top_full_height, r=lens_radius + ring_width, $fn=180);
                translate([0, 0, -1])
                    cylinder(top_full_height + 2, r=inner_radius, $fn=180);
                translate([0, 0, -top_height])
                    ring(top_full_height, r1=outer_radius+1, r2=lens_radius - cylinder_fit, $fn=180);
            }
            // part to hold an axle
            translate([lens_radius + ring_wall + axle_holder_length/2, 0, -top_holder_height/2 + top_full_height])
                cube([axle_holder_length, axle_diameter * 4, top_holder_height], center=true);
            // part to hold bolt
            translate([-(lens_radius + ring_wall + bolt_block_len/2), 0, -top_holder_height/2 + top_full_height])
                cube([bolt_block_len, bolt_block_len, top_holder_height], center=true);
            // pegs to retain leds in place
            for(angle = [0:led_angle:359]) {
                rotate([0, 0, angle + led_offset_angle])
                    translate([-(lens_radius + ring_wall + led_retain_offset/2), 0, -led_support_height/2  + top_full_height - top_height])
                        cube([led_retain_offset, led_diameter, led_support_height], center=true);
            }

        }
        // hole for axle
        translate([lens_radius + ring_wall, 0, top_full_height - top_holder_height])
            rotate([0, 90, 0])
                bolt($fn=20);
        // hole for nut
        translate([lens_radius + ring_wall + axle_holder_length/2, axle_holder_length/2.5, top_holder_height-nut_thickness])
            bolt_side_hole();
        translate([lens_radius + ring_wall + axle_holder_length/2, -axle_holder_length/2.5, top_holder_height-nut_thickness])
            bolt_side_hole();
        translate([-(lens_radius + ring_wall + nut_diameter/1.5), 0, top_holder_height-nut_thickness])
            bolt_side_hole();
    }
}

rotate([180, 0, 0]) top();
