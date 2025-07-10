module mount_holes(z, dia = m3_clearance, caps = 0){
    cylinder(h = z, r = dia/2);
    if(caps > 0){
        if(caps == 1 || caps == 3) 
            cylinder(h=m3_cap_depth, r = m3_cap_clear/2);
        if(caps == 2 || caps == 3)
            translate([0, 0, z-m3_cap_depth])
                cylinder(h=m3_cap_depth, r = m3_cap_clear/2);
    }         
} 