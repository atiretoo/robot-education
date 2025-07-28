include <metric_screw_sizes.scad>
WallThickness = 1.8;
$fn=30;
//BallSize = 13; te ruim
//BallSize = 12.7; bijna
//BallSize = 12.4;goed
BallSize = 11.;
Airgap = .5;
Mount = 3.2; //10 layers at 0.32
TotalHeight =  18+Airgap; 		//this includes the ball
MountScrewRad = m3_clearance/2;  	//3mm screw
BallProtrude = .50; 	//percentage of ball radius sticking out 
ScrewSpacing = 20;		//spaceing of the mountholes center to center
MountMiddle = false; 	//mount int the center
MountBase = true;		//use mount base 2 holes


cylrad = (BallSize/2) + WallThickness + Airgap;
echo (cylrad);


    difference()
    {
        union()
        {
            ball_mount ();
            if(MountBase)
            {		
                base();
            }  
  
        }
        if(MountMiddle)
        {
            cylinder(r1 = MountScrewRad, r2 = MountScrewRad, h= TotalHeight,center=true, $fn=30);
            translate([0,0,(TotalHeight-BallSize)/2]) 
            {
                cylinder(r1 = MountScrewRad*2, r2 = MountScrewRad*2, h= TotalHeight, $fn=30);
            }
        }
        //tunnels to clear screw caps
        translate([ScrewSpacing/2, 0, Mount])
            cylinder(h = TotalHeight, r = m3_cap_clear/2);
        translate([-ScrewSpacing/2, 0, Mount]) 
            cylinder(h = TotalHeight, r = m3_cap_clear/2);
        //magnet pocket, 2 0.32 mm layers under, magnet is 1.6mm thick, 6mm diameter
        echo(TotalHeight-BallSize-Airgap-1.6);
        echo(TotalHeight-(BallSize + Airgap));
        translate([0, 0, TotalHeight-BallSize-Airgap-2.24])
            #cylinder(h = 10*0.32, r = 3.5);   
    }

module ball_mount ()
{
	difference () 
	{
		cylinder(r1 = cylrad , r2 = cylrad,  TotalHeight - (BallSize*BallProtrude));
	
		translate([0,0,TotalHeight - BallSize/2]) 
		{
			cube(size = [cylrad*2+5, cylrad/2, BallSize*1.25], center = true );
			rotate([0,0,90]) cube(size = [cylrad*2+5, cylrad/2, BallSize*1.25], center = true );
		}
	
		translate([0,0,TotalHeight - (BallSize/2)]) 
		{
			sphere (BallSize/2+Airgap, $fa=5, $fs=0.1);
		}
	}
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
