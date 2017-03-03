function z_scale(z="floor") =
    _z_units[ search([z],_z_units,1,0)[0] ]  [1];

_basis=25.4;
_z_units=[ 
        ["demo", 4],
        ["floor",6.5], 
        ["wall_half",_basis],
        ["wall",_basis*2],
        ["riser", _basis-1.75],
        ["riser_full", _basis*2-1.75]
        ];

module battery_holder() {
    difference() {
        union() {
            cube([29.8,29.8,3.8]);
            translate([-.9,29.8/2-.5,0]) cube([31.6,1,3.8]);
            translate([29.8/2-.5,-.9,0]) cube([1,31.6,3.8]);
        }
        middle = (29.8-10.5)/2;
        translate([29.8/2,29.8/2,-1]) cylinder(6,10.2, 10.2);
        translate([middle-1,-1,3.8-1.5]) cube([5,10,2]);
        translate([-1,29.8-middle-4,3.8-1.5]) cube([10,5,2]);
        translate([29.8-middle-4,29.8+1-10,3.8-1.5]) cube([5,10,2]);
        translate([29.8-middle+1,middle-1,3.8-1.5]) cube([10,5,2]);

        translate([29.8-middle-4,-1,-.5]) cube([5,10,2]);
        translate([-1,middle-1,-.5]) cube([10,5,2]);
        translate([middle-1,29.8+1-10,-.5]) cube([5,10,2]);
        translate([29.8-middle+1,29.8-middle-4,-.5]) cube([10,5,2]);
    }
}

module maintenance_negative() {
    translate([-10+_basis,0,]) {
        translate([0,7,20]) {
            difference() {
                cube([20,6,20]);
                translate([9,-0.01,-1]) cube([2,2.01,22]);
                translate([-0.01,-0.01,-1]) cube([2.02,2.01,22]);
                translate([18,-0.01,-1]) cube([2.02,2.01,22]);
                translate([-1,0,14]) rotate([45,0,0]) cube([22,15,20]);
            }
            translate([2,1.7,-14.4]) rotate([7,0,0]) cube([7,2.01,15]);
            translate([11,1.7,-14.4]) rotate([7,0,0]) cube([7,2.01,15]);
            rotate([-90,0,0]) translate([8,-14,-9]) cylinder(16,0.75,0.75,$fn=200);
            rotate([-90,0,0]) translate([12,-14,-9]) cylinder(16,0.75,0.75,$fn=200);
        }
    }
}

module maintenance_negative_thin() {
    translate([-10+_basis,0,]) {
        translate([0,7,20]) {
            difference() {
                cube([20,10,30]);
                translate([9,-0.01,-1]) cube([2,2.01,22]);
                translate([-0.01,-0.01,-1]) cube([2.02,2.01,22]);
                translate([18,-0.01,-1]) cube([2.02,2.01,22]);
                translate([-1,0,14]) rotate([40,0,0]) cube([22,20,20]);
            }
            translate([2,0,-14.4]) cube([7,2.01,15]);
            translate([11,0,-14.4]) cube([7,2.01,15]);
            rotate([-90,0,0]) translate([8,-14,-9]) cylinder(16,0.75,0.75,$fn=200);
            rotate([-90,0,0]) translate([12,-14,-9]) cylinder(16,0.75,0.75,$fn=200);
        }
    }
}

module maintenance_hatch_negative() {
  translate([-10+_basis+.1, 7, 20.1]) difference() {
    translate([0,2.1,0]) cube([19.8,3.9+5,30]);
    translate([-1,0,13.8]) rotate([45,0,0]) cube([22,20,20]);
  }
}

module maintenance_hatch_negative_thin() {
  translate([-10+_basis+.1, 7, 20.1]) difference() {
    translate([0,2.1,0]) cube([19.8,3.9+5,30]);
    translate([-1,0,13.8]) rotate([40,0,0]) cube([22,20,20]);
  }
}

module torch() {
  difference() {
    union() {
      cylinder(1,3.5,3.5,$fn=200);
      cylinder(12,3,1.5,$fn=200);
      translate([0,0,6]) cylinder(1,2.5,2.5,$fn=200);
    }
    rotate([45,0,0]) translate([1.75,0.5,-0.4]) cylinder(10,.5,.5,$fn=200);
    rotate([45,0,0]) translate([-1.75,0.5,-0.4]) cylinder(10,.5,.5,$fn=200);
    translate([1.75,0,-2]) cylinder(2.5,1,1,$fn=200);
    translate([-1.75,0,-2]) cylinder(2.5,1,1,$fn=200);
  }
}

//torch();
//maintenance_hatch_negative();
//maintenance_negative();
//translate([_basis,0,0]) port();

//A();
module A(z_unit="wall", c=undef, cft=undef) {
    x = 2;
    y = 0.5;
    col = c ? c : "DarkGrey";
    fcol = cft ? cft : "LightGrey";
    difference() {
        union() {
            color(col) cube([_basis*x, _basis*y, z_scale("floor")]);
            if (z_unit == "floor") {
                color(fcol) floor_squares(x,y,z_unit);
            } else {
                color(col) translate([0,1,0]) cube([_basis*x, _basis*y-2, z_scale(z_unit)]);
            }
        }
        color(col) translate([_basis,0,0]) port();
    }
}

module openlock_port(buffer=0) {
    translate([-buffer,-7,1.4]) cube([2+buffer,7*2,4.2]);
    hull() {
        translate([0,-6,1.4]) cube([2,6*2,4.2]);
        translate([3,-5,1.4]) cube([2,5*2,4.2]);
    }
    translate([3,-5,1.4]) cube([4.8,5*2,4.2]);
}

module openlock_transition() {
    hull() {
        translate([4.99,-5,1.4]) cube([2,5*2,4.2]);
        translate([6,-5,1.4]) cube([2,5*2,4.2+.5]);
    }
}


module port() {
    buffer = 1;
    rotate([0,0,90]) {
        openlock_port(buffer);
        translate([6,-11.2,-buffer/2]) cube([4.7,11.2*2,6.1+buffer/2]);
        openlock_transition();
    }
}

