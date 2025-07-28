include <metric_screw_sizes.scad>
// Parameters
base_width = 100;         // mm
base_height = 65;         // mm
base_thickness = 12;       // mm

slot_spacing = 10;        // mm (center-to-center)
slot_width = m3_clearance;         // mm (room for M3 screw)
slot_length = base_height - 20; // mm (10 mm clearance top and bottom)
nut_diameter = m3_nut_clear;       // mm (M3 hex nut across flats)
nut_height = m3_cap_depth;         // mm

// Slot module: oblong cut with nut flare at top and bottom
module make_slot(length, width, depth) {
    // make a 2D shape for the nut flares
    translate([0, length/2, 0]) {
    linear_extrude(depth)
       hull() {
            translate([0, -length/2, 0])
                circle(d=width, $fn=20);
            translate([0, length/2, 0])
                circle(d=width, $fn=20);
        }
    }
 
}

// Generate base with slots
difference() {
    cube([base_width, base_height, base_thickness]);

    // Center slots horizontally, no more than slot_spacing from the end
    num_slots = 9;//floor((base_width - slot_spacing*2) / slot_spacing);
    echo(num_slots);
    slot_offset = slot_spacing; //(base_width - (num_slots * slot_spacing)) / 2;
    echo(slot_offset);

    for (i = [0 : num_slots - 1]) {
        x = slot_offset + i * slot_spacing;
        translate([x, 10, -0.1]) {// small Z offset for clean subtraction
            make_slot(slot_length, nut_diameter, nut_height);
            make_slot(slot_length, slot_width, base_thickness);
            translate([0, 0, base_thickness-nut_height])
                make_slot(slot_length, nut_diameter, nut_height+0.2);
        } 
    }
}