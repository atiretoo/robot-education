//holder for vl530lo sensor module
$fn = 60;
module_height = 10.75;
module_width = 25; //includes mounting holes
module_core = 15.64; //pcb width excluding mounting holes
module_hole_center = module_width/2 - 1.2 - 2.95/2; // from center to center of mounting hole
mount_hole_dia = 3.8;
screw_cap_dia = 5.3;
screw_cap_depth = 3.3;
mount_width = 65; //rear dimension, spans 3 holes in plate
mount_depth = 24; // from front edge to > 3 mm behind first row of holes
mount_height = module_height/2 + 6; // leaves 3 mm above and below holes minimum

difference(){
    //main body
    cube([mount_width, mount_depth, mount_height]);
    translate([mount_width/2, 19, 0]){
        cylinder(h = mount_depth, r = mount_hole_dia/2+0.2, center = false);
        //cylinder(h = 3.2, r = 5.5/2, center = false);
    }
    translate([mount_width/2-20, 19, 0]){
        cylinder(h = mount_depth, r = mount_hole_dia/2+0.2, center = false);
        //cylinder(h = 3.2, r = 5.5/2, center = false);
    }

    translate([mount_width/2+20, 19, 0]){
        cylinder(h = mount_depth, r = mount_hole_dia/2+0.2, center = false);
        //cylinder(h = 3.2, r = 5.5/2, center = false);
    }
    
    translate([0, screw_cap_depth + 1.2, 0])
        cube([mount_width, mount_depth, mount_height - screw_cap_depth - 1.2]);
    
    //mount holes for module
    translate([mount_width/2 - module_hole_center,0., module_height/2 - 2]){
    rotate([-90, 0, 0]){
       cylinder(h = mount_depth, r = mount_hole_dia/2, center = false);
        //cylinder(h = 3.2, r = 5.5/2, center = false);
    }} 
    translate([mount_width/2 + module_hole_center, 0., module_height/2-2]){
    rotate([-90, 0, 0]){
       cylinder(h = mount_depth, r = mount_hole_dia/2, center = false);
        //cylinder(h = 3.2, r = 5.5/2, center = false);
    }}
    //clearance for smd components on reverse of module
    translate([mount_width/2 - module_core/2+1, 0, 0])
        cube([module_core-2, 2, module_height/2+2]);
}