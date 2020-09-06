include <openscad-shorthand/shorthand.scad>
include <openscad-shorthand/nema.scad>
include <openscad-skf/skf.scad>

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
		
		difference()
		{
			Ty(-30) Tz(-20) 
			{
				hull()
				{
				cyl([60,18,12]);
				cub([80, 10, 12], [0,-1,0]);
				}
				cub([33, 60, 12], [0,1,0]);
			}
			Ty(-30) Tz(-20) 
			cub([15, 30, 12], [0,-1,0]);
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
        Tz(12) cyl([6,6,50]);
    }
}

module mask(keepouts = 1)
{
    Tz(-5)
    {
		Ty(-15)
        cub(31, 300, 31, [0,1,-1]);
        // V Bolts
        Tz(25) Ty(25) cyl(5,5,50);
		Tz(-25) {
			cyl(5,5,50);
			//Ty(20) cyl(5,5,50);
		}
        Tz(5)
        {
            Mx() 
            Ty(-30)
			Tz(-20) 
			Tx(18) 
			pulley();
            
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
            //hull()
            {
                //Ty(-3) cub(40,68,40, [0,0,-1]);
                 Ty(-2) cub(40,36,40, [0,0,-1]);
                 Ty(-32) 
				hull()
				{
					cub(50,10,40, [0,0,-1]);
					cub(40,20,40, [0,1,-1]);
				}
			}
            
            /*//Mx() 
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
            }*/
        }
        
        mask();
    }
    % mask(0);
}

//model();

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

module frame()
{
    cub(100, 30.5, 30.5, [1,0,0]);
}

//frame();

//Tz(SKF_LLTHC_U15[SKF_H1])


 difference()
{
    hull() Tz(-4) cub([50,50,12], align=TOP, at=LEFT+BOTTOM,bevel=[4,-4,0]) cub([50,50,12], align=TOP+LEFT, bevel=[4,-4,0]);
    
    Tx(-40)
    #My(32) cyl([6.3, 6.3, 100]);
   
    Tx(-60)
    #My(32) cyl([6.3, 6.3, 100]);
    
    Tx(-330) 
    union()
    {
        skf_assembly();
        Mx(660) Rx(180) nema(mask=[1,1,2]);
    }
}
{
    Rx(180) %nema();
    Tx(-330) %skf_assembly();
}       
// PICK one
//color ("red") reinforce();
//color ("#9999FFAA") model();
