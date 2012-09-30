WD=get_absolute_file_path('2d_transient_try1.sce');
datafile=WD+filesep()+'2d_transient_try1_data.sci';
exec(datafile);
T=[nx,ny];
T_old=[nx,ny];
lambda=rho*C*dt/(k*dx*dx)
for i=1:1:nx
    T(i,1)=T_lower; //assigning value to lower side nodes
    T(i,ny)=T_upper; //assigning value to upper side nodes
end
for j=1:1:ny
    T(1,j)=T_left; //Left side nodes
    T(nx,j)=T_right; //Right side nodes
end
T(1,1)=0.5*(T_left+T_lower);
T(nx,1)=0.5*(T_right+T_right);
T(1,ny)=0.5*(T_left+T_upper);
T(nx,ny)=0.5*(T_right+T_upper);
for j=2:1:ny-1
    for i=2:1:nx-1
        T(i,j)=T_default;
    end
end
err=ones(nx-2,ny-2);
count=0;
xp=1:nx;
yp=1:ny;
TMIN = min(T); //Minumum of T
TMAX = max(T); //Maximum of T
show_window(); clf();
f=gcf();
f.color_map=jetcolormap(256);
f.pixmap='on';
colorbar(TMIN,TMAX);
printf("Iteration\tError\n")
while(norm(err,2)>acc)
    for j=1:1:ny
        for i=1:1:nx
            T_old(i,j)=T(i,j);
        end
    end
    for j=2:1:ny-1
        for i=2:1:nx-1
            T(i,j)=lambda*(T_old(i+1,j)+T_old(i-1,j)-4*T_old(i,j)+T_old(i,j+1)+T_old(i,j-1))+T_old(i,j);
            err(i-1,j-1)=T(i,j)-T_old(i,j);
        end
    end
    if(modulo(count,5)==0) then
        z=T;
        title('TEMPERATURE CONTOUR PLOT','color', 'black', 'fontsize',3);
        Sgrayplot(xp,yp,z, strf="042", zminmax=[TMIN,TMAX])
        show_pixmap();
        printf("%f\t%f\n",count,norm(err));
    end
    count=count+1;
    if (count>1000) then
        break;
    end
end
printf("\nNumber of iterations required is %1.0f",count);