$fn = 60;
inner_diameter = 65;
rim_thickness = 5;
tire_diameter = 5; // added to total diameter


difference(){
    cylinder(h = rim_thickness+2, r = (inner_diameter+tire_diameter)/2);
    cylinder(h = rim_thickness, r = (inner_diameter-tire_diameter/2)/2);
   
    translate([0, 0, 2]){
            cylinder(h = rim_thickness, r = (inner_diameter)/2);
     }
}
