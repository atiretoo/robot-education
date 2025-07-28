// robot wheel for gear motors
$fn = 60;

include <metric_screw_sizes.scad>


module wheel(diameter = 65, rim_thickness = 16*0.32, rim_diameter = 4.8, disc_thickness = 8*0.32, wheel_screw_radius=9.75){
    x = [-1, 1, 0, 0];
    y = [0, 0, -1, 1];
    //parameter checks
 
    difference(){
        //main body
        cylinder(h = rim_thickness, r = diameter/2);
        translate([0,0,disc_thickness])
            cylinder(h = disc_thickness, r = (diameter-rim_diameter)/2);
        //wheel screws
        for (i = [0:3]){
            translate([x[i]*wheel_screw_radius, y[i]*wheel_screw_radius, 0])
                #cylinder(h = disc_thickness, r = m2_insert/2);
        
        }
    }
}

wheel();