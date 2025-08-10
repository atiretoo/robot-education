//include <metric_screw_sizes.scad>
include <BOSL-1.0.3/metric_screws.scad>
$fn = 60;
m3_clearance = 4;
m3_cap_depth = get_metric_socket_cap_height(3.0)*1.1;
m3_cap_clear = get_metric_socket_cap_diam(3.0)*1.1;
m3_nut_clear = get_metric_nut_size(3.0)*1.1;
m3_nut_depth = get_metric_nut_thickness(3.0)*1.1;

board_width = 46;
hole_dia = 4.1;
hole_offset = 3.2;

offset_hole_from_center = board_width/2 - hole_offset - hole_dia/2;
mount_width = 50;
mount_depth = 60;
mount_height = 20;
mount_center_x = mount_width/2;
mount_center_y = mount_depth/2-5;
offset_depth = mount_height;


module mount_holes(z, dia = m3_clearance, caps = 0, nuts = 0){
    if(nuts>0 && caps>0){
        echo("WARNING: both nuts and caps enabled in mount_holes(); results may be undefined.");
    }
    cylinder(h = z, r = dia/2);
    if(caps > 0){
        if(caps == 1 || caps == 3) 
            cylinder(h=m3_cap_depth, r = m3_cap_clear/2);
        if(caps == 2 || caps == 3)
            translate([0, 0, z-m3_cap_depth])
                cylinder(h=m3_cap_depth, r = m3_cap_clear/2);
    }         
    if(nuts > 0){
        r = m3_nut_clear / sqrt(3);  // inscribed circle radius
        if(nuts == 1 || nuts == 3) 
            cylinder(h=m3_nut_depth, r = r, $fn = 6);
        if(nuts == 2 || nuts == 3)
            translate([0, 0, z-m3_nut_depth])
                cylinder(h=m3_nut_depth, r = r, $fn = 6);
    }         

} 


// main body of mount
difference(){
    cube([mount_width, mount_depth, mount_height]);
    for(row=[0:1:2]){
        for(col=[0:1:2]){
            translate([mount_center_x-20+col*20, mount_center_y-20+row*20, 0])
                #mount_holes(mount_height, caps = 1, nuts = 0);
        }
    }
    // holes for caster
    y_offset = 10;
    translate([mount_center_x - offset_hole_from_center, mount_center_y+y_offset, 0])
        mount_holes(z = mount_height, dia = m3_clearance*1.1, caps = 0, nuts = 0);;
    translate([mount_center_x + offset_hole_from_center, mount_center_y+y_offset, 0])
        mount_holes(z = mount_height, dia = m3_clearance*1.1, caps = 0, nuts = 0);;
    translate([mount_center_x, mount_center_y+y_offset + offset_hole_from_center, 0])
        mount_holes(z = mount_height, dia = m3_clearance*1.1, caps = 0, nuts = 0);;
    translate([mount_center_x, mount_center_y+y_offset - offset_hole_from_center, 0])
        mount_holes(z = mount_height, dia = m3_clearance*1.1, caps = 0, nuts = 0);;
}
