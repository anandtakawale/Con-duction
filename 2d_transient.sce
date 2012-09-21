//Scilab code for simulating heat conduction to a square block
pathname=get_absolute_file_path('2d_transient.sce')
filename=pathname+filesep()+'2d_conduction_data.sci'
exec(filename)
//Time step
dt=0.05;

//Ambient temperature
T_amb=100;     //degrees in Celcius

//Creat an empty matrix of the temperature
T=[];

//Lower boundary
for i=1:20,
    T(i,1)=T_bottom;
end

//Upper boundary
for i=1:20,
    T(i,20)=T_top;
end

//left boundary
for j=1:20,
    T(1,j)=T_left;
end

//right boundary
for j=1:20,
    T(20,j)=T_right;
end

for i=2:19,
    for j=2:19,
        T(i,j)=20;     //Initial condition
    end
end

x=1:20;
y=1:20;

show_window(); clf()
f=gcf();
f.color_map=jetcolormap(256);
f.pixmap='on';

colorbar(0,150);
T_new=T;  //use this line to copy boundaries
for counter=1:150,
    T=T_new;
    for i=2:19,
        for j=2:19,
            T_new(i,j)=dt*(T(i-1,j)+T(i+1,j)+T(i,j-1)+T(i,j+1)-4*T(i,j))+T(i,j);
        end
    end
    z=T_new;
    Sgrayplot(x,y,z, strf="042",rect=[-5 2 25 40], zminmax=[0,100])
    show_pixmap();
    if(abs(T_new-T)<0.01) then
        break;
    end
end