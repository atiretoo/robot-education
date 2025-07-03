// Parameters
plate_diameter = 180;
plate_thickness = 3;
hole_diameter = 3.5; // ORP rules
hole_spacing = 20; // ORP rules
plate_resolution = 50; 
hole_resolution = 20; 

num_holes_x = floor(plate_diameter / hole_spacing);
num_holes_y = floor(plate_diameter / hole_spacing);

//Holse for motors Parameters
squere_hole_width = 60;
squere_hole_height = 20;
space_between_squere_holse_user = 90; 

// Code not parametric down there

space_between_squere_holse = (space_between_squere_holse_user / 2)+squere_hole_height/2;

difference(){
    

difference() {
    cylinder(h = plate_thickness, d = plate_diameter, $fn=plate_resolution);

    for (i = [-floor(plate_diameter / hole_spacing / 2):floor(plate_diameter / hole_spacing / 2)]) {
        for (j = [-floor(plate_diameter / hole_spacing / 2):floor(plate_diameter / hole_spacing / 2)]) {
            x = i * hole_spacing;
            y = j * hole_spacing;
            if (sqrt(x*x + y*y) + hole_diameter/2 <= plate_diameter/2) {
                translate([x, y, -1])
                    cylinder(h = plate_thickness + 2, d = hole_diameter, $fn=hole_resolution);
            }
        }
    }  
  }
  translate([space_between_squere_holse-squere_hole_height/2,-squere_hole_width/2,0])
  cube([squere_hole_height,squere_hole_width,plate_thickness]);
  
  translate([-space_between_squere_holse-squere_hole_height/2,-squere_hole_width/2,0])
  cube([squere_hole_height,squere_hole_width,plate_thickness]);
  
}
