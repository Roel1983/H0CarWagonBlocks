base_size     = [12.5, 4.8, 1.0];
triangle_size = [ 4.6, 5.0, 2.8];
connection    = 1.4;
distance      = 3.0;
tip_size      = [1.0, 1.7];

echo(str("Side to Side: ", 
    base_size[0] + 2 * (triangle_size[0])));
echo(str("Tip to tip: ", 
    base_size[0] + 2 * (triangle_size[0] + tip_size[0])));

linear_extrude(base_size[2]) {
    square([base_size[0], base_size[1]], true);
    copy_mirror([1, 0, 0]) polygon([
        [base_size[0]/2 - connection, base_size[1] / 2],
        [base_size[0]/2,  base_size[1] / 2 + connection],
        [base_size[0]/2, -base_size[1] / 2 - connection],
        [base_size[0]/2 - connection, -base_size[1] / 2]
    ]);
}

//!translate([distance,0])
copy_mirror([1, 0, 0]) copy_mirror([0, 1, 0]) {
    translate([-base_size[0]/2, distance/2]) rotate(90) intersection() {
        linear_extrude(triangle_size[2]*1.1)polygon([
            [0,0],
            [triangle_size[0], 0],
            [triangle_size[0], triangle_size[1]],
            [triangle_size[0] - tip_size[1] / 2, 
                triangle_size[1] + tip_size[0]],
            [triangle_size[0] - tip_size[1], triangle_size[1]],
            [0, triangle_size[1]]
        ]);
        rotate(-90, [1,0,0])linear_extrude(triangle_size[1] + tip_size[0]) polygon([
            [0, 0],
            [triangle_size[0],0],
            [triangle_size[0]/2, -triangle_size[2]]
        ]);
    }
}

module copy_mirror(vec=undef) {
    children();
    mirror(vec) children();
}

/*cube(base_size, center=true);
translate([base_size[0]/2, base_size[1]/2]) {
    linear_extrude(base_size[2]) {
        scale(connection) polygon([[-1,0],[0,0],[0,1]]);
    }
}*/