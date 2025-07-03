//robot workstand
$fn = 60;
include <metric_screw_sizes.scad>

plate_diameter = 170;

stand_width = plate_diameter;
stand_depth = 70;
stand_height = 40;
stand_center_x = stand_width/2;
stand_center_y = stand_depth/2;

module plate_cutter(plate_diameter = 170, plate_thickness = 3){
    cylinder(h = plate_thickness, r = plate_diameter/2);
}
 
intersection(){
    translate([stand_center_x, stand_center_y, 0])
        plate_cutter(plate_thickness = stand_height);
    difference(){
        cube([stand_width, stand_depth, stand_height]);
        translate([stand_center_x, stand_center_y, stand_height - 2*m3_cap_depth+0.1]){
            for (row = [-1:1:1]){
                for(col = [-3:1:3]){
                    translate([col*20, row*20, 0])
                        cylinder(h = 2*m3_cap_depth, r = m3_cap_clear/2);
                }
            }
        }
        translate([stand_center_x - 60, stand_center_y, stand_height])
            sphere(d = 26);
        translate([stand_center_x + 60, stand_center_y, stand_height])
            sphere(d = 26);
    }
}