//code for solving 2d steady state conduction
pathname=get_absolute_file_path('2d_conduction_gauss_siedel.sce')
filename=pathname+filesep()+'2d_conduction_data.sci'
exec(filename)
T=[]; //Creating empty matrix for temperature
//Temperature at the bottom of the plate
for j=1:1:nx
    T(1,j)=T_bottom;
end
//Temperature at the top of the plate
for j=1:1:nx
    T(ny,j)=T_top;
end
//Temperature at the left edge
for i=2:1:ny-1
    T(i,1)=T_left;
end
//Temperature at the right edge
for i=2:1:ny-1
    T(i,nx)=T_right;
end
//Remaining plate temperature
for i=2:1:ny-1
    for j=2:1:nx-1
        T(i,j)=0.25*(T_bottom+T_top+T_left+T_right);
    end
end
err=1;
count=0;
//While error is greater than accuracy required
while (err > acc)
    count=count+1;
    for i=2:ny-1
        for j=2:nx-1
            T_old=T(i,j);
            T(i,j)=0.25*(T(i-1,j)+T(i+1,j)+T(i,j-1)+T(i,j+1)); //Finite difference equation
            e(i,j)=T(i,j)-T_old;
        end
    end
    err=norm(e);    //Termination criterion
end
printf("Temperature distribution is given as follows \n");
disp(T); //Display Temperatures
printf("Number of iterations required is %1.0f",count);
x=1:1:ny;
y=1:1:nx;
xset('window',1);
clf(1);
TMIN = min(T); //Minumum of T
TMAX = max(T); //Maximum of T
colorbar(TMIN,TMAX);
title('TEMPERATURE CONTOUR PLOT','color', 'black', 'fontsize',3)
Sgrayplot(x,y,T,strf="041");
xset("colormap",rainbowcolormap(32));