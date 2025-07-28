
$fn = 180;
mount_outer_radius = 80;
mount_inner_radius = mount_outer_radius -25;
mount_thickness = 5;
lip_depth = 20;
lip_thickness = 1.5;

include <orp_circular_plate_3d.scad>;

module cut_wedge(h, start_angle = 40, end_angle = 320){
        linear_extrude(h+1){
        points = [
            [0, 0], // Center of the cylinder
    
            // Points along the arc for the 90-degree segment
            for (angle = start_angle; angle <= end_angle; angle = angle + 1) // Increment by 1 degree for smoothness
                [(mount_outer_radius+1) * sin(angle), (mount_outer_radius+1) * cos(angle)]
        ];
        //echo(points);
        polygon(points = points);
        
    }}
 
    
module cut_switch_hole(radius, angle, switch_hole_size = 14, cut_depth = 1.5){
    //radius is the distance from the orgin for the cut to start
    //angle is the angle relative to the y axis
    rotate([-90, 0, angle])
    translate([0, -(lip_depth/2), radius-cut_depth]){
        linear_extrude(height = cut_depth*2, center = true) { 
            square(size = switch_hole_size, center = true);
        }
    }
}

//orp_plate(mount_outer_radius*2);
translate([0, 0, -mount_thickness])
difference(){
    orp_plate(mount_outer_radius*2, plate_thickness = mount_thickness, plate_resolution = 180);
    cylinder(h = mount_thickness, r = mount_inner_radius);
    cut_wedge(h = mount_thickness);
}
// add the outer lip
translate([0, 0, -(mount_thickness+lip_depth)])
difference(){
    cylinder(h = lip_depth, r = mount_outer_radius);
    cylinder(h = lip_depth, r = (mount_outer_radius - lip_thickness));
    cut_wedge(h = lip_depth);
    #cut_switch_hole(radius = mount_outer_radius, angle = 0); 
    #cut_switch_hole(radius = mount_outer_radius, angle = -30); 
    #cut_switch_hole(radius = mount_outer_radius, angle = 30); 
}