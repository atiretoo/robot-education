//MPU-6050 holder, horizontal
$fn = 60;
include <metric_screw_sizes.scad>
module_width = 20;
module_depth = 15;
mount_hole_dia = 3.2;
mount_hole_sep = 15;
mount_hole_depth = (module_width - mount_hole_sep)/2;
mount_height = 4; //thickness of the base
mount_width = 20;
mount_depth = 20 + 3 + 2.4; //center-to-center hole pattern, plus a hole, plus 2 walls
top_of_module = mount_depth - (mount_depth - module_depth)/2;

difference(){
    //main body + module
    union(){
        cube([mount_width, mount_depth, mount_height]);
//        translate([0, (mount_depth - module_depth)/2, mount_height])
//            cube([module_width, module_depth, 1.5]);
    }
    //module mount holes
    translate([mount_width/2-mount_hole_sep/2, top_of_module-mount_hole_depth, 0])
        cylinder(h = mount_depth, r = m3_clearance/2);
    translate([mount_width/2+mount_hole_sep/2, top_of_module-mount_hole_depth, 0])
        cylinder(h = mount_depth, r = m3_clearance/2);
    //header backside clearance
    translate([0, (mount_depth - module_depth)/2, mount_height-1.5])
        cube([mount_width, 2, 1.5]);
    //mount to plate holes
    translate([mount_width/2, mount_depth/2-10, 0])
        cylinder(h = mount_depth, r = m3_clearance/2);
    translate([mount_width/2, mount_depth/2+10, 0])
        cylinder(h = mount_depth, r = m3_clearance/2);
}