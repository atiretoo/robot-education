// hardware tester
$fn=60;
dx = 6;
dy = 6;
base_r = [1, 1.25, 1.5, 2];
dr = [-0.1, -0.05, 0., 0.05, 0.1];
difference(){
    cube([6*dx, 5*dy, 5]);
    for(row = [1:1:4]){
        for(col = [1:1:5]){
            translate([dx*col, dy*row, 0])
                cylinder(h = 5, r = base_r[row-1]+dr[col-1]);
        }
    }
}