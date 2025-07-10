// robot wheel for gear motors
$fn = 60;
diameter = 15;
rim_thickness = 4;
rim_diameter = 5; // subtracted from total diameter
disc_thickness = 4; 

// 4mm with cutout at 2 works but is sloppy
difference(){
    union(){
difference(){
cylinder(h = rim_thickness, r = diameter/2);
translate([0,0,disc_thickness])
    cylinder(h = disc_thickness, r = (diameter-rim_diameter)/2);
    
cylinder(h = disc_thickness, r = 3.9); //this size fits perfectly, sliding on with nearly no slop
}
translate([(3.9/2), -3.9, 0])
    cube([3.9, 7.8, disc_thickness]);
}
translate([0, 0, 2])
rotate([0, 90, 0])
    cylinder(h = diameter+2, r = 1);
}