// robot wheel for gear motors
$fn = 60;
diameter = 15;
rim_thickness = 2.5;
rim_diameter = 5; // subtracted from total diameter
disc_thickness = 2.5; 

include <metric_screw_sizes.scad>



// 4mm with cutout at 2 works but is sloppy
//union(){
//difference(){
//cylinder(h = rim_thickness, r = diameter/2);
//translate([0,0,disc_thickness])
//    cylinder(h = disc_thickness, r = (diameter-rim_diameter)/2);
//    
//cylinder(h = disc_thickness, r = 3.9); //this size fits perfectly, sliding on with nearly no slop
//}
//translate([(3.9/2), -3.9, 0])
//    cube([3.9, 7.8, disc_thickness]);
//}

module hub(height = 0.32*15, diameter = 14, flange_height = 0.32*10, flange_diameter = 25, axle_radius = 3.9){
    x = [-1, 1, 0, 0];
    y = [0, 0, -1, 1];
    //parameter checks
    hub_thickness = diameter/2 - axle_radius;
    echo("hub thickness: ", hub_thickness);
    echo("total height: ", height+flange_height);
    wheel_screw_radius = diameter/2+(flange_diameter/2 - diameter/2)/2;//flange_diameter/2-m2_insert;
    echo("wheel screw radius: ", wheel_screw_radius);
    difference(){
        //main body
        union(){
            linear_extrude(height = height)
                circle(d = diameter);
            translate([0, 0, height])
            linear_extrude(height = flange_height)
                circle(d = flange_diameter);
        }
        //make axle profile
        linear_extrude(height = height+flange_height)
            difference(){
                circle(r = axle_radius);
                translate([axle_radius/2, -axle_radius, 0])
                square([axle_radius, 2*axle_radius]);
            }
        //set screw
        translate([-diameter/2, 0, 0.5*height])
        rotate([0,90,0])
            #cylinder(h = hub_thickness*1.1, r = m2_insert/2);
        //wheel screws
        for (i = [0:3]){
            translate([x[i]*wheel_screw_radius, y[i]*wheel_screw_radius, height])
                #cylinder(h = flange_height, r = m2_insert/2);
        
    }
}

        
    
}
hub();