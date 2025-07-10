AA_width = 14.1;
AA_height = 51;
contact_height = 12;
contact1x_width = 12;
contact2x_width = 26.5;
contact_clearance = 5;
spring_height = 8.5;
block_width = 70;
block_height = 60;

cutout_height = AA_height + contact_clearance;
difference(){
    //main block
    cube([block_width, block_height, AA_width]);
    //battery cutouts
    translate([+2, block_height - (block_height-cutout_height)/2, AA_width])
    rotate([90, 0, 0]){
        for(i=[0:3]){
            translate([i*AA_width+AA_width/2+2, 0, 0]){
                cylinder(h = cutout_height, r = AA_width/2, center = false);
            }
        }
    }
    //contact cutouts
    translate([+4, block_height - (block_height - cutout_height)/2, AA_width/2+1])
        cube([4*AA_width, 1.5, AA_width/2]);
    translate([+4, (block_height - cutout_height)/2, AA_width/2+1])
        cube([4*AA_width, 1.5, AA_width/2]);
}