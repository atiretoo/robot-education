// robot wheel for gear motors
$fn = 60;
diameter = 65;
rim_thickness = 5;
rim_diameter = 5; // subtracted from total diameter
disc_thickness = 2.5; 
axle_radius = 3.9;
keyway_offset = axle_radius / 2;

union(){
difference(){
cylinder(h = rim_thickness, r = diameter/2);
translate([0,0,disc_thickness])
    cylinder(h = disc_thickness, r = (diameter-rim_diameter)/2);
    
cylinder(h = disc_thickness, r = axle_radius);
}
translate([keyway_offset, -axle_radius, 0])
    cube([axle_radius, 2*axle_radius, disc_thickness]);
}