$fn = 100;

fan_size = 80;
fan_corner_radius = 3;
fan_hole_offset = 4;
fan_hole_diameter = 4.2;
fan_diameter = 77;

filter_diameter = 160;
filter_clearance = 12;
filter_frame_size = filter_diameter + 2 * filter_clearance;

shroud_height = 67.5;
split_height = 8.64;

magnet_diameter = 6.5;
magnet_height = 1.8;

module rounded_square(size, radius) {
    hull() {
        for (x = [-1,1], y = [-1,1])
            translate([x*(size/2 - radius), y*(size/2 - radius)])
                circle(r=radius);
    }
}

module magnet_pockets(h, r, z) {
    for (x = [-1,1], y = [-1,1])
        translate([x*((filter_diameter/2)-8.2 - fan_hole_offset), y*((filter_diameter/2)-8.2 - fan_hole_offset),z])
            #cylinder(h = h, r = r);
}

module mounting_holes(height = 15) {
    for (x = [-1,1], y = [-1,1])
        translate([x*(fan_size/2 - fan_hole_offset), y*(fan_size/2 - fan_hole_offset)])
            cylinder(h = height, r = fan_hole_diameter/2);
}

module fairing() {
    linear_extrude(height=shroud_height, scale=filter_frame_size/fan_size)
        rounded_square(size=fan_size, radius=fan_corner_radius);

}

// Lower part (up to split height)
module part_bottom() {
    translate([0,0,-shroud_height])
    intersection() {
        difference() {
            fairing();
            linear_extrude(height = shroud_height, scale = filter_diameter/fan_diameter)
                circle(d=fan_diameter);
            magnet_pockets(magnet_height, magnet_diameter/2+0.1, shroud_height-split_height);
        }
        translate([-150,-150,shroud_height - split_height])
            #cube([300, 300, split_height-0.1], center=false);
    }
}

// Upper part (from split height to filter end)
module part_top() {
    translate([0,0,-shroud_height])
    intersection() {
        difference() {
            union(){
            fairing();
            translate([fan_size/2, -fan_size/2, -39])
                #cube([fan_size, fan_size, shroud_height-split_height+39],
            center = false);    
            }        
             linear_extrude(height = shroud_height, scale = filter_diameter/fan_diameter)
                circle(d=fan_diameter);
            mounting_holes(height = 15);
            magnet_pockets(magnet_height, magnet_diameter/2+0.1, shroud_height-split_height-magnet_height);

            // Filter pocket
            translate([0,0,shroud_height - split_height - 5.12])
                cylinder(h = 5.12, r = filter_diameter/2);
        }
        translate([-150,-150,-39])
        #cube([300, 300, shroud_height - split_height+39], center=false);
    }
}

// Render either one for printing:
part_bottom();
//part_top();