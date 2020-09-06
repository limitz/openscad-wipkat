include <shorthand.scad>

module rail(keepouts=1)
{
    cub(46, 28, 10, [0,0,1], at=[0,0,-1])
    {
        color("silver") 
        Tz(5) 
        cub(300, 12, 8, [0,0,1], at = [0,0,1]) cub(300, 30.5, 30.5, [0,0,1]);
        
        color("red") 
        Mx() My() T(10,10) 
        {
            cyl(4,4,20, [0,0,-1]);
            Tz(-4) cyl(8,8,4, [0,0,0]);    
        }
        //belt
        color("grey") Tz(3) cub(300, 7, 2);

        //keepout
        //Mx()
        if (keepouts)
        {
            hull() 
            {
                Tx(28) cub(20,12,20);
                Tx(40) cub(10,12,60);
            }
            Tx(27) cub(10,12,60);
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
        //My() Ty(25) cyl(5,5,100);
        // H Bolts
        Tz(-15) Ry(90) {
            My() Ty(15) cyl(5,5,100);
            //cyl([5,5,100]);
        }
        Tz(5)
        {
            //Mx() 
            Tz(-5) Tx(35) Rx(90) pulley();
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
                cub(40,40,23, [0,0,-1]);
                cub(40,30,28, [0,0,-1]);
            }
            
            //Mx() 
            hull() 
            {
                cub(46,40, 13, [0,0,-1]);
                Tx(10) cub(40,30, 13, [0,0,-1]);
                Tz(-10) Tx(20) cub(3,30, 3, [0,0,-1]);
            }
            
            hull()
            {
                Tz(-5) Tx(20) cub(55,18, 3, [0,0,-1]);
                Tz(-10) Tx(20) cub(4,18, 18, [0,0,-1]);
            }
            //Mx() 
            hull() 
            {
                Tx(20) cub(60,30, 4, [0,0,-1]);
                Tx(20) cub(36,30, 13, [0,0,-1]);
                //Tz(-15) Tx(20) cub(4,18, 3, [0,0,-1]);
            }
        }
        
        mask();
    }
    % mask(0);
}

module reinforce()
{
    //Mx() 
    color("red") difference()
    {
        union() {
            hull(){
            
                 cub(46,10, 8, [0,0,-1]);
           
            }
            hull() 
            {
                Tz(0) Tx(30) cub(35,18, 8, [0,0,-1]);
                Tz(-10) Tx(15) cub(14,18, 18, [0,0,-1]);
              
            }
        }
        mask();
    }
}


// PICK one
color ("red") reinforce();
! color ("#9999FFAA") model();
