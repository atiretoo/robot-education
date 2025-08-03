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
tire_clearance = 40;
hes_board = 23.84;
hes_board_thickness = 2.4;
hes_screw_d = 3.5;
hes_scr_offset = 1.65;

module hall_effect_sensor(board_size = hes_board, hole_diameter = hes_screw_d, hole_offset = hes_scr_offset){
	hole_x = [hole_offset+hole_diameter/2, hes_board - hole_offset -hole_diameter/2, hes_board - hole_offset -hole_diameter/2,hole_offset+hole_diameter/2];
	hole_z = [hes_board - hole_offset -hole_diameter/2, hes_board - hole_offset -hole_diameter/2,hole_offset+hole_diameter/2, hole_offset+hole_diameter/2];
	hole_y = 0;
	difference(){
		union(){
			cube([board_size, hes_board_thickness, board_size]);
			translate([6, hes_board_thickness, hes_board-7])
				cube([10, 1, 4]); //cutout for resistors
		}

		// for (i = [0:3]){
		// 	translate([hole_x[i],hole_y, hole_z[i]])
		// 	rotate([90, 0, 0])
		// 		cylinder(h=3, r = hole_diameter/2, center=true);
		// }
	}

}

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
                cylinder(h=36, r = 9/2, center=true);
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
    mount_screw_x = [gearbox_length/2-12.5, gearbox_length/2+7.5,  gearbox_length/2+7.5,  gearbox_length/2-12.5];
    mount_screw_y = [-2.5, -2.5,  -22.5,  -22.5];
    mount_z = gearbox_height+mount_thickness*2;
    //mount_z_total = mount_z + (tire_clearance-mount_z/2);
    difference(){
        union(){
            translate([-mount_thickness,-(32-mount_thickness), gearbox_height])
                cube([gearbox_length+mount_thickness, 32-mount_thickness, mount_thickness]);
            translate([-mount_thickness, -mount_thickness, -mount_thickness])
                cube([gearbox_length+mount_thickness, gearbox_depth+mount_thickness, mount_z]);
			translate([-mount_thickness, -16, gearbox_height-7])
				cube([12+hes_board, 6, 7]);
        }
        #motor(); // carve out the mount
        for(i = [0:3]){
            translate([mount_screw_x[i], mount_screw_y[i], gearbox_height+mount_thickness])
                #screw(screwsize = 4, headlen = 3);
        }
		//hall effect sensor carveout
		translate([axle_x-hes_board/2, -14.6, gearbox_height-hes_board])
			#hall_effect_sensor();
		translate([axle_x-hes_board/2+hes_scr_offset+hes_screw_d/2, -16, gearbox_height-hes_scr_offset-hes_screw_d/2])
		rotate([-90, 0, 0])
			cylinder(h=8, d=hes_screw_d);
		translate([axle_x+hes_board/2-hes_scr_offset-hes_screw_d/2, -16, gearbox_height-hes_scr_offset-hes_screw_d/2])
		rotate([-90, 0, 0])
			cylinder(h=8, d=hes_screw_d);
    }
 
}

intersection(){
	difference(){
		union(){
			color("blue")
				mount();
			//motor();

		}
		screw_holes();
	}
	translate([gearbox_length, -(80-gearbox_depth),0])
		cylinder(h=3*gearbox_height, r=80, center = true);
}
