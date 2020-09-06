include <openscad-shorthand/shorthand.scad>

module rail(keepouts=1)
{
    cub(46, 28, 10, [0,0,1], at=[0,0,-1])
    {
        color("silver") Tz(5) cub(300, 12, 8, [0,0,1], at = [0,0,1]) cub(300, 31, 31, [0,0,1]);
        color("red") Mx() My() T(10,10) {
            cyl(4,4,20, [0,0,-1]);
            Tz(-4) cyl(8,8,4, [0,0,0]);
            
        }
        //belt
        color("grey") Tz(3) cub(300, 7, 2);

        //keepout
        if (keepouts)
        {
            Mx() hull() {
                Tx(28) cub(20,15,20);
                Tx(40) cub(10,15,60);
            }
            Mx() Tx(27) cub(10,15,60);
        }
            
    }
}

module pulley()
{
    color("yellow")
    {
        difference()
        {
            cyl(15,15,9.5);
            cyl(16,16,7.0);
        }
        cyl([13,13,9]);
        cyl([6,6,50]);
    }
}

module mask(keepouts = 1)
{
    Tz(-5)
    {
        cub(31, 300, 31, [0,0,-1]);
        // V Bolts
        My() Ty(25) cyl(5,5,100);
        // H Bolts
        Tz(-15) Ry(90) {
            My() Ty(25) cyl(5,5,100);
            cyl([5,5,100]);
        }
        Tz(5)
        {
            Mx() Tz(-5) Tx(37) Rx(90) pulley();
            rail(keepouts);
        }
    }
}

module model()
{
    difference()
    {
        Tz(0) 
        {
            hull()
            {
                cub(38,65,23, [0,0,-1]);
                cub(38,55,28, [0,0,-1]);
            }
            
            Mx() hull() 
            {
                cub(45,45, 10, [0,0,-1]);
                Tx(10) cub(45,35, 12, [0,0,-1]);
                Tz(-25) Tx(20) cub(3,30, 3, [0,0,-1]);
            }
            Mx() hull() 
            {
                Tx(20) cub(45,35, 12, [0,0,-1]);
                Tz(-25) Tx(20) cub(3,30, 3, [0,0,-1]);
            }
        }
        
        mask();
    }
    //% mask(0);
}

module reinforce()
{
    Mx() color("red") difference()
    {
        {
            hull() 
            {
                Tz(-0) Tx(28) cub(28,24, 10, [0,0,-1]);
                Tz(-14) Tx(20) cub(3,20, 3, [0,0,-1]);
            }
        }
        mask();
    }
}


// PICK one
color ("red") reinforce();
! color ("#9999FFAA") model();
