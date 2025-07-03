// Parameters
plate_diameter = 330; 
hole_diameter = 3.5; // ORP rules
hole_spacing = 20; // ORP rules
plate_resolution = 360; 
hole_resolution = 36; 

num_holes_x = floor(plate_diameter / hole_spacing);
num_holes_y = floor(plate_diameter / hole_spacing);

module hole(x, y) {
    translate([x, y])
        circle(hole_diameter/2, $fn=hole_resolution);
}

module plate() {
    circle(plate_diameter/2, $fn=plate_resolution); // 
}

module hole_grid() {
    for (i = [-floor(plate_diameter / hole_spacing / 2):floor(plate_diameter / hole_spacing / 2)]) {
        for (j = [-floor(plate_diameter / hole_spacing / 2):floor(plate_diameter / hole_spacing / 2)]) {
            x = i * hole_spacing;
            y = j * hole_spacing;
            if (sqrt(x*x + y*y) + hole_diameter/2 <= plate_diameter/2) {
                hole(x, y);
            }
        }
    }
}

difference() {
    plate();
    hole_grid();
}
