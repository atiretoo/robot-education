include <metric_screw_sizes.scad>
WallThickness = 1.8;
$fn=30;
//BallSize = 13; te ruim
//BallSize = 12.7; bijna
//BallSize = 12.4;goed
BallSize = 11.;
Airgap = .5;

TotalHeight =  18+Airgap; 		//this includes the ball
Mount = 24;//-TotalHeight; //10 layers at 0.32
MountScrewRad = m3_clearance/2;  	//3mm screw
BallProtrude = .50; 	//percentage of ball radius sticking out 
ScrewSpacing = 20;		//spaceing of the mountholes center to center
MountMiddle = false; 	//mount int the center
MountBase = true;		//use mount base 2 holes


cylrad = (BallSize/2) + WallThickness + Airgap;
echo (cylrad);


difference()
{

    base();
    translate([ScrewSpacing/2,-MountScrewRad*3,Mount/2]) {
        #cube([5.5, MountScrewRad*3,Mount-8], center = true);
    }
//    translate([0-ScrewSpacing/2,0,4]) {
//        circle( MountScrewRad*3);
//    }
}


module base()
{
	difference (){
		linear_extrude(height=Mount)
		hull() {
			translate([ScrewSpacing/2,0,0]) {
				circle(  MountScrewRad*3);
			}
			translate([0-ScrewSpacing/2,0,0]) {
				circle( MountScrewRad*3);
			}
			circle( cylrad);
		}
	
		translate([ScrewSpacing/2,0,-1]) {
			#cylinder(r1 = MountScrewRad, r2 = MountScrewRad, h= Mount+2,$fn=30);
		}
		translate([0-ScrewSpacing/2,0,-1]) {
			#cylinder(r1 = MountScrewRad, r2 = MountScrewRad, h= Mount+2,$fn=30);
			
		}

	}
}
