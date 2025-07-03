include <metric_screw_sizes.scad>
$fn = 60;

board_width = 43.4;
hole_dia = 2.9;
hole_offset = 1.75;
offset_depth = 6.5;
offset_hole_from_center = board_width/2 - hole_offset - hole_dia/2;
mount_width = 50;
mount_depth = 60;
mount_height = 3+2*m3_cap_depth;
mount_center_x = mount_width/2;
mount_center_y = mount_depth/2-5;

module mount_holes(z, dia = m3_clearance, caps = 0){
    cylinder(h = z, r = dia/2);
    if(caps > 0){
        if(caps == 1 || caps == 3) 
            cylinder(h=m3_cap_depth, r = m3_cap_clear/2);
        if(caps == 2 || caps == 3)
            translate([0, 0, z-m3_cap_depth])
                cylinder(h=m3_cap_depth, r = m3_cap_clear/2);
    }         
} 


// main body of mount
difference(){
    cube([mount_width, mount_depth, mount_height]);
    for(row=[0:1:2]){
        for(col=[0:1:2]){
            translate([mount_center_x-20+col*20, mount_center_y-20+row*20, 0])
                mount_holes(mount_height, caps = 3);
        }
    }
    translate([mount_center_x - offset_hole_from_center, mount_center_y+10 - offset_hole_from_center, mount_height-offset_depth])
        cylinder(h = offset_depth, r = m3_tight/2);
    translate([mount_center_x + offset_hole_from_center, mount_center_y+10 - offset_hole_from_center, mount_height-offset_depth])
        cylinder(h = offset_depth, r = m3_tight/2);
    translate([mount_center_x - offset_hole_from_center, mount_center_y+10 + offset_hole_from_center, mount_height-offset_depth])
        cylinder(h = offset_depth, r = m3_tight/2);
    translate([mount_center_x + offset_hole_from_center, mount_center_y+10 + offset_hole_from_center, mount_height-offset_depth])
        cylinder(h = offset_depth, r = m3_tight/2);
}
