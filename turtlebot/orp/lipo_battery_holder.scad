//holder for blomiky lipo 1000 mah 7.4v battery
$fn = 60;
battery_height = 15;
battery_depth = 31; //wired end ~34mm
battery_width = 56;
mount_thickness = 5;
mount_x_center = (mount_thickness + battery_width)/2;
mount_y_center = (2*mount_thickness + battery_height)/2;

include <metric_screw_sizes.scad>

difference(){
    cube([battery_width + mount_thickness, battery_height + 2*mount_thickness, battery_width/2 + mount_thickness]);
    translate([mount_thickness, mount_thickness, mount_thickness])
        cube([battery_width, battery_height, battery_width/2]);
    //mounting holes
    translate([mount_x_center - 20, mount_y_center, 0]){
        cylinder(h = mount_thickness, r = m3_clearance/2);
        translate([0, 0, mount_thickness - m3_cap_depth])
            cylinder(h = m3_cap_depth, r = m3_cap_clear/2);
    }
        translate([mount_x_center + 20, mount_y_center, 0]){
        cylinder(h = mount_thickness, r = m3_clearance/2);
        translate([0, 0, mount_thickness - m3_cap_depth])
            cylinder(h = m3_cap_depth, r = m3_cap_clear/2);
    }
        translate([mount_x_center, mount_y_center, 0]){
        cylinder(h = mount_thickness, r = m3_clearance/2);
        translate([0, 0, mount_thickness - m3_cap_depth])
            cylinder(h = m3_cap_depth, r = m3_cap_clear/2);
    }
}