// dragger 
$fn=60;
diameter = 25;
holesize = 3.6;
cap_clearance = 5.6;
cap_depth = 3.1;

difference(){
    sphere(d = diameter);
    translate([0,0,-diameter/2])
        cube([diameter, diameter, diameter], center = true);
    cylinder(h = diameter, r = holesize/2, center = true);
    translate([0,0, (diameter/2)- cap_depth])
        cylinder(h = diameter, r = cap_clearance/2);
}