include <BOSL-1.0.3/metric_screws.scad>;
$fn = 60;
gearbox_depth = 19;
gearbox_height = 22.5;
gearbox_length = 37;
motor_length = 27;
axle_x = 12.5;
axle_y = gearbox_depth/2;
axle_z = gearbox_height/2;
mount_thickness = 5;


module motor(){
    difference(){
        union(){
            cube([gearbox_length, gearbox_depth, gearbox_height]);
            translate([gearbox_length, gearbox_depth/2, gearbox_height/2])
            rotate([0, 90, 0])
                cylinder(h = motor_length, r = gearbox_height/2);
            translate([axle_x, axle_y, axle_z])
            rotate([90, 0, 0])
            color("white")
                cylinder(h=36, r = 6/2, center=true);
            translate([22.5, 0, gearbox_height/2])
            rotate([90, 0, 0])
                cylinder(h=6, r = 2.5, center=true);
            translate([-2.5, gearbox_depth/2, gearbox_height/2])
                cube([7, 4, 7], center=true);
        }

    }

}

module screw_holes(){
    translate([gearbox_length-5, gearbox_depth/2, gearbox_height-2.5])
    rotate([90, 0, 0])
        cylinder(h=gearbox_depth+0.01+2*mount_thickness, r = 1.7, center=true);
    translate([gearbox_length-5, gearbox_depth/2, 2.5])
    rotate([90, 0, 0])
        cylinder(h=gearbox_depth+0.01+2*mount_thickness, r = 1.7, center=true);
    translate([-2.5, gearbox_depth/2, gearbox_height/2])
    rotate([90, 0, 0])
        cylinder(h=gearbox_depth+0.01+2*mount_thickness, r = 1.7, center=true);
}

module mount(){
    difference(){
        translate([-mount_thickness, -mount_thickness, -mount_thickness])
            cube([gearbox_length+mount_thickness, gearbox_depth+mount_thickness, gearbox_height+mount_thickness*2]);
        motor();
    }
}

difference(){
    union(){
        color("blue")
            mount();
        motor();
    }
    screw_holes();
}
