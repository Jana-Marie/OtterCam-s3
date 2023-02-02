$fn=200;
perim=1;
explode=1;

mount = "efs_mount"; // efs_mount c_mount cs_mount None

if($preview){
    t=1.6;
    if("back_board" && 1){
        translate([0,0,0])back_board(h=t);
    }
    if("sensor_board" && 1){
        translate([0,0,-4.9-t-explode*15])sensor_board(h=t);
    }
    if("shell_b_s" && 1){
        translate([0,0,-4.9-explode*5])shell(h=5,p=perim);
    }

    if("shell_b" && 1){
        translate([0,0,4.9-t-perim-perim/2+explode*10])b_shell(h=4.9,p=perim);
    }
    if("cap_b" && 1){
        translate([0,0,4.9+4.9/2+0.5-perim-perim/2+explode*15])b_cap(h=1,p=perim);
    }
    if(mount == "efs_mount"){
        if("shell_s_l" && 1){
            translate([0,0,-4.9-t-10-explode*20])shell(h=9.9,p=perim);
        }
        if("lens_board" && 1){
            translate([0,0,-4.9-t-10-t-explode*25])lens_board(h=t);
        }
        if("efs_mount" && 1){
            translate([0,0,-4.9-t-9.9-t-t/2-9.9-explode*30])efs_mount();
        }
    }
    if(mount == "c_mount"){
        if("c_mount" && 1){
            translate([0,0,-4.9-t-10-explode*20])c_mount(h=9.9,focus=17.526,sens_h=1,p=perim);
        }
    }
    if(mount == "cs_mount"){
        if("cs_mount" && 1){
            translate([0,0,-2-t-10-explode*20])c_mount(h=7,focus=12.526,sens_h=1,p=perim);
        }
    }
} else {
    c_mount(h=7,focus=12.526,sens_h=1,p=perim);
}

module c_mount(h=10,shoff=0.5,t=1.6,x=49.8,y=49.8,r=4.9,r_d=0.5,p=1,screw=3,focus=17.526,sens_h=1){
    difference(){
        union(){
            difference(){
                union(){
                    for(i = [0:1:3]){
                        // main wall
                       color("white")rotate([0,0,90*i])translate([0,y/2-perim/2,h/2])cube([x-r-r,perim,h],center=true);
                        // screw
                        color("white")rotate([0,0,90*i])hull(){
                            translate([40/2,40/2,0])cylinder(r=r,h=h);
                            translate([x/2-r/2-r,y/2-perim/2,h/2])cube([r,perim,h],center=true);
                            translate([x/2-perim/2,y/2-r/2-r,h/2])cube([perim,r,h],center=true);
                        }
                        // inner diam
                        color("white")rotate([0,0,90*i])
                        difference(){
                            union(){
                                translate([x/2-r-r-r/4,y/2-r/4-perim,h/2])cube([r/2,r/2,h],center=true);
                                translate([x/2-r/4-perim,y/2-r-r-r/4,h/2])cube([r/2,r/2,h],center=true);
                            }
                            union(){
                                translate([x/2-r-r-r/4-r/4,y/2-r/4-perim-r/4,-0.1])cylinder(d=r,h=h+0.2);
                                translate([x/2-r/4-perim-r/4,y/2-r-r-r/4-r/4,-0.1])cylinder(d=r,h=h+0.2);
                            }
                        }
                    }
                    // lenscap
                    color("white")hull(){
                        translate([0,0,-1])minkowski(){
                            cube([x-r-r,y-r-r,3-0.1],center=true);
                            cylinder(r=r+perim,h=0.1);
                        }
                        translate([0,0,h+0.5-focus-sens_h])cylinder(d=30,h=3);
                    }
                }union(){
                    // screw
                    for(i = [-1:2:1]){
                        for(j = [-1:2:1]){
                            translate([i*20,j*20,-0.1])cylinder(d=3.05,h=h+0.2);
                        }
                    }
                    // lenshole
                    translate([0,0,h+0.5-focus-sens_h-0.1])cylinder(d=24.6,h=focus);
                    // lensthread
                    if(!$preview){
                        t_p=0.794;
                        t_h=t_p/2;
                        t_step=12;
                        t_threadstep=t_p/360;
                        translate([0,0,h+0.5-focus-sens_h-0.5])for(i=[0:t_step:360*6]){
                            if(i>0){
                                hull(){
                                    rotate([0,0,i])translate([25.4/2-0.5,0,t_h/2+t_threadstep*i])cube([1.5,0.1,t_h],center=true);
                                    rotate([0,0,i-t_step])translate([25.4/2-0.5,0,t_h/2+t_threadstep*(i-t_step)])cube([1.5,0.1,t_h],center=true);
                                }
                            }
                        }
                    }
                }
            }
            translate([0,0,-shoff])difference() {
                union() {
                    color("white")translate([0,0,h/2-t/2-0.05])minkowski(){
                        cube([x-r-r,y-r-r,h-0.1+t],center=true);
                        cylinder(r=r+perim,h=0.1);
                    }
                }union(){
                    translate([0,0,h/2-t/2-0.1])minkowski(){
                        cube([x-r-r+0.03,y-r-r+0.03,h+t+0.2],center=true);
                        cylinder(r=r,h=0.1);
                    }
                }
            }
            // 1/4"
            c_h=9.5;
            translate([-x/2+(12.7/2),0,-2.75+c_h/2])cube([12.7,12,c_h],center=true);
        }union(){
            // 1/4"
            // https://www.amazon.de/-/en/dp/B09MTS6ZZQ
            rotate([0,90,0])translate([-2.25,0,-x/2-1-0.01])cylinder(d=8,h=12.8); //6.35mm
        }
    }
}

module efs_mount(h=10,shoff=0.5,t=1.6,x=49.8,y=49.8,r=4.9,r_d=0.5,p=1,screw=3){
    difference(){
        union(){
            translate([0,0,h/2+0.5])minkowski(){
                cube([x-r-r,y-r-r,h-0.1],center=true);
                cylinder(r=r,h=0.1);
            }
            hull(){
                hull(){
                    translate([0,0,h/2-0.05])minkowski(){
                        cube([x-r-r,y-r-r,h-0.1],center=true);
                        cylinder(r=r+perim,h=0.1);
                    }
                    translate([0,0,0])cylinder(d=65,h=h/2);
                }
                // mount
                minkowski(){
                    translate([-65/2+1,0,9/2])cube([4-2,12-2,9-2],center=true);
                    sphere(r=1);
                }
            }
        }union(){
            hull(){
                translate([0,0,h])cylinder(d=43.5,h=h/3);
                translate([0,0,-0.1])cylinder(d=54.6,h=6.9+0.2);
            }
            // screw
            for(i = [-1:2:1]){
                for(j = [-1:2:1]){
                    translate([i*20,j*20,-h-0.1])cylinder(d=2.3,h=h*3+0.2);
                }
            }
            // 1/4"
            rotate([0,90,0])translate([-4.5,0,-65/2-1])cylinder(d=5.45,h=6); //6.35mm
            // indicator
            rotate([0,0,112])translate([65/2,0,5/2])rotate([0,0,0])cube([0.3,1.5,1.5],center=true);
        }
    }
    bajonett_angles = [-2, 55.75, 55.75+55.75, 55.75+55.75+54.4, 55.75+55.75+51.4+56.84, 55.75+55.75+51.4+56.84+83.63];
    angle_offset = 0;
    translate([0,0,-0.3])
    difference(){
        union(){
            translate([0,0,1.92])cylinder(d=54.6,h=2.5);
            for(i = [0:2:5]){
                rotate([0,0,bajonett_angles[i]-90])translate([54.6/2-1.4/2,-0.5,2.5/2+2.4+1.92])cube([1.4,1,2.5],center=true);
            }
        }union(){
            translate([0,0,1.92-0.1])cylinder(d=54.6-1.4*2,h=2.5+0.2);
            for(i = [0:2:5]){
                hull(){
                    rotate([0,0,angle_offset+bajonett_angles[i]-90])translate([60/2,0.5,3])cube([20,1,6],center=true);
                    rotate([0,0,angle_offset+bajonett_angles[i+1]-90])translate([60/2,-0.5,3])cube([20,1,6],center=true);
                }
            }
            translate([0,0,-1])cylinder(d1=65,d2=0,h=20);
        }
    }
}

module b_cap(h=10,shoff=0.5,t=1.6,x=49.8,y=49.8,r=4.9,r_d=0.5,p=1,screw=3){
    translate([0,0,0])difference() {
        union() {
            // main body
            color("white")translate([0,0,h/2-0.05])minkowski(){
                cube([x-r-r,y-r-r,h-0.1],center=true);
                cylinder(r=r+perim,h=0.1);
            }
        }union(){
            // recess
            translate([0,0,h/2-h/2-0.3])minkowski(){
                cube([x-r-r+0.03,y-r-r+0.03,h+0.2],center=true);
                cylinder(r=r,h=0.1);
            }
            // screw
            for(i = [-1:2:1]){
                for(j = [-1:2:1]){
                    translate([i*20,j*20,-0.1])cylinder(d=3.05,h=h+0.2);
                }
            }
            // USB-C
            color("silver")translate([x/2-35.15,y/2-5.75+0.06,-h])minkowski(){
                usb_c_r = 1;
                translate([0,0,7.7/2])cube([9-usb_c_r-usb_c_r,3.2-usb_c_r-usb_c_r,7.7-0.1],center=true);
                cylinder(r=usb_c_r+0.14,h=0.1);
            }
            // ethernet
            color("slategrey")translate([x/2-15.5/2-11,y/2-14/2-4,-h])cube([15.5+0.09*2,14+0.09*2,12.5],center=true);
            // LEDs
            for(i = [-1:2:1]){
                translate([x/2-6.77+i*0.72,y/2-20.4,-h])rotate([0,0,90])cylinder(d=1,h=h*3);
                translate([x/2-6.77+i*2.12,y/2-20.4,-h])rotate([0,0,90])cylinder(d=1,h=h*3);
            }
            // reset
            translate([-x/2+3.35,-y/2+20.85,0]) cylinder(d=3.05,h=h*3);//7534
        }
    }
}

module b_shell(h=10,shoff=0.5,t=1.6,x=49.8,y=49.8,r=4.9,r_d=0.5,p=1,screw=3.07){
    difference(){
        union(){
            shell(h,shoff,t,x,y,r,r_d,p,screw);
        }union(){
            // sd
            translate([x/2-14+16/2,-y/2+25.5-11/2-0.05,t/2])cube([16.3,11.3,1.3],center=true);
        }
    }
}

module shell(h=10,shoff=0.5,t=1.6,x=49.8,y=49.8,r=4.9,r_d=0.5,p=1,screw=3){
    difference(){
        union(){
            for(i = [0:1:3]){
                // main wall
                color("white")rotate([0,0,90*i])translate([0,y/2-perim/2,h/2])cube([x-r-r,perim,h],center=true);
                // screw
                color("white")rotate([0,0,90*i])hull(){
                    translate([40/2,40/2,0])cylinder(r=r,h=h);
                    translate([x/2-r/2-r,y/2-perim/2,h/2])cube([r,perim,h],center=true);
                    translate([x/2-perim/2,y/2-r/2-r,h/2])cube([perim,r,h],center=true);
                }
                // inner diam
                color("white")rotate([0,0,90*i])
                difference(){
                    union(){
                        translate([x/2-r-r-r/4,y/2-r/4-perim,h/2])cube([r/2,r/2,h],center=true);
                        translate([x/2-r/4-perim,y/2-r-r-r/4,h/2])cube([r/2,r/2,h],center=true);
                    }
                    union(){
                        translate([x/2-r-r-r/4-r/4,y/2-r/4-perim-r/4,-0.1])cylinder(d=r,h=h+0.2);
                        translate([x/2-r/4-perim-r/4,y/2-r-r-r/4-r/4,-0.1])cylinder(d=r,h=h+0.2);
                    }
                }
            }
        }union(){
            // screw
            for(i = [-1:2:1]){
                for(j = [-1:2:1]){
                    translate([i*20,j*20,-0.1])cylinder(d=3.05,h=h+0.2);
                }
            }
        }
    }
    translate([0,0,-shoff])difference() {
        union() {
            color("white")translate([0,0,h/2-t/2-0.05])minkowski(){
                cube([x-r-r,y-r-r,h-0.1+t],center=true);
                cylinder(r=r+perim,h=0.1);
            }
        }union(){
            translate([0,0,h/2-t/2-0.1])minkowski(){
                cube([x-r-r+0.03,y-r-r+0.03,h+t+0.2],center=true);
                cylinder(r=r,h=0.1);
            }
        }
    }
}

module lens_board(h=1.6,x=49.8,y=49.8,r=4.9){
    difference(){
        union(){
            // board
            color("green")translate([0,0,h/2])minkowski(){
                cube([x-r-r,y-r-r,h-0.1],center=true);
                cylinder(r=r,h=0.1);
            }
            // screw
            for(i = [-1:2:1]){
                for(j = [-1:2:1]){
                    color("gold")translate([i*20,j*20,0.04])cylinder(d=6,h=h+0.011);
                }
            }
        }union(){
            // screw
            for(i = [-1:2:1]){
                for(j = [-1:2:1]){
                    translate([i*20,j*20,-0.1])cylinder(d=3.05,h=h+0.2);
                }
            }
            // cutout
            cylinder(d=42,h=h+0.1);
        }
    }
}


module sensor_board(h=1.6,x=49.8,y=49.8,r=4.9){
    difference(){
        union(){
            // board
            color("green")translate([0,0,h/2])minkowski(){
                cube([x-r-r,y-r-r,h-0.1],center=true);
                cylinder(r=r,h=0.1);
            }
            // screw
            for(i = [-1:2:1]){
                for(j = [-1:2:1]){
                    color("gold")translate([i*20,j*20,0.04])cylinder(d=6,h=h+0.011);
                }
            }
            // sensor
            color("black")translate([0,0,-h+1])cube([6,7.2,1],center=true);
        }union(){
            // screw
            for(i = [-1:2:1]){
                for(j = [-1:2:1]){
                    translate([i*20,j*20,-0.1])cylinder(d=3.05,h=h+0.2);
                }
            }
            // cutout
            translate([x/2-9.6/2-10.2,-y/2+0.9+0.5,h/2])cube([9.6,1,h+0.2],center=true);
        }
    }
}


module back_board(h=1.6,x=49.8,y=49.8,r=4.9){
    difference(){
        union(){
            // board
            color("green")translate([0,0,h/2])minkowski(){
                cube([x-r-r,y-r-r,h-0.1],center=true);
                cylinder(r=r,h=0.1);
            }
            // screw
            for(i = [-1:2:1]){
                for(j = [-1:2:1]){
                    color("gold")translate([i*20,j*20,0.04])cylinder(d=6,h=h+0.011);
                }
            }
            // LEDs
            for(i = [-1:2:1]){
                translate([x/2-6.77+i*0.72,y/2-20.4,1.6])rotate([0,0,90])LED();
                translate([x/2-6.77+i*2.12,y/2-20.4,1.6])rotate([0,0,90])LED();
            }
            // SD
            color("black")translate([x/2-14+16/2,-y/2+25.5-11/2,h+0.5+1/2])cube([16,11,1],center=true);
            color("silver")translate([x/2-14.1+12/2,-y/2+25.5-11/2,h+1.6/2])cube([12,12.5,1.6],center=true);
            // USB-C
            color("silver")translate([x/2-35.15,y/2-5.75,h])minkowski(){
                usb_c_r = 1;
                translate([0,0,7.7/2])cube([9-usb_c_r-usb_c_r,3.2-usb_c_r-usb_c_r,7.7-0.1],center=true);
                cylinder(r=usb_c_r,h=0.1);
            }
            // ethernet
            color("slategrey")translate([x/2-15.5/2-11,y/2-14/2-4,h+12.5/2])cube([15.5,14,12.5],center=true);
            // wifi
            translate([x/2-38,-y/2+13.2,h])rotate([0,0,45])union(){
                color("green")translate([0,0,0.6/2])cube([12,12,0.6],center=true);
                color("silver")translate([0,0,0.6/2+1.7/2])cube([10.5,10.5,1.7],center=true);
            }
            // s3
            color("black")translate([x/2-22.85,-y/2+15.3,h+1/2])cube([11,11,1],center=true);
            // button
            translate([-x/2+3.35,-y/2+20.85,0]) union(){
                color("grey")translate([0,0,h+1])cube([3.4,4.75,2],center=true);
                color("cornflowerblue")hull(){
                    translate([0,0.4,h+2])cylinder(d=2.2,h=0.5);
                    translate([0,-0.4,h+2])cylinder(d=2.2,h=0.5);
                }
            }
        }union(){
            // screw
            for(i = [-1:2:1]){
                for(j = [-1:2:1]){
                    translate([i*20,j*20,-0.1])cylinder(d=3.05,h=h+0.2);
                }
            }
            // cutout
            translate([x/2-9.6/2-10.2,-y/2+0.9+0.5,h/2])cube([9.6,1,h+0.2],center=true);
        }
    }
}

module LED(c="red"){
    difference(){
        union(){
            color("gold")translate([0,0,0.4/2])cube([1.6,0.8,0.4],center=true);
            color(c)translate([0,0,0.9/2+0.01])cube([0.78,0.78,0.9],center=true);
        }union(){
            for(i = [-1:2:1]){
                translate([i*0.8,0,-0.05])cylinder(d=0.4,h=0.5);
            }
        }
    }
}