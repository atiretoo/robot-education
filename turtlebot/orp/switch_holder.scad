//holder for  switch
$fn = 60;

include <metric_screw_sizes.scad>
include <orp_bits.scad>

switch_height = 25;
switch_depth = 17; //wired end ~34mm
switch_width = 40;
mount_wall_thickness = m3_clearance + 4;
echo("the walls will be: ", mount_wall_thickness, " mm");
mount_top_thickness = 5;
mount_x_center = (switch_width)/2;
mount_y_center = (2*mount_wall_thickness + switch_depth)/2;
mount_height = switch_height + mount_top_thickness;
mount_depth = switch_depth + 2*mount_wall_thickness;


difference(){
    cube([switch_width, mount_depth, mount_height]);
    translate([0, mount_wall_thickness, mount_top_thickness])
        cube([switch_width, switch_depth, switch_height]);
    translate([mount_x_center, mount_y_center,0])
        cylinder(mount_top_thickness, r = 6.5);
    //mounting holes
    translate([mount_x_center - 10, mount_wall_thickness/2, mount_height -10])
        mount_holes(z = 10, dia = m3_tight);
    translate([mount_x_center + 10, mount_wall_thickness/2, mount_height - 10])
        mount_holes(z = 10, dia = m3_tight);
    translate([mount_x_center - 10, mount_depth - mount_wall_thickness/2, mount_height -10])
        mount_holes(z = 10, dia = m3_tight);
    translate([mount_x_center + 10, mount_depth - mount_wall_thickness/2, mount_height - 10])
        mount_holes(z = 10, dia = m3_tight);
}