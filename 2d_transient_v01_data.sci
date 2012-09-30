//2d transient conduction
l=input("Enter length of square plate:");
nx=input("Enter number of nodes on each side:");
w=l; //width of plate
ny=nx; //nodes in y direction
dx=l/(nx-1); //finite difference in x direction
dy=w/(ny-1); //finite difference in y direction
k=input("Enter thermal conductivity in W/mK:");
rho=input("Enter density of plate material(kg/m^3):");
C=input("Enter specific heat capacity in J/kg.K:");
dt=0.25*k*dx*dx/(rho*C);
//initial conidtions
T_lower=input("Temperature of lower side of plate in C");
T_upper=input("Temperature of upper side of plate in C:");
T_left=input("Temperature of left side of plate in C:");
T_right=input("Temperature of right side of plate in C:");
T_default=input("Plate initial temperaturein C:");
acc=0.001 //Accuracy