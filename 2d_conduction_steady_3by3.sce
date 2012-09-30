//2d conduction with grid of 3*3 points
pathname=get_absolute_file_path('2d_conduction.sce')
filename=pathname+filesep()+'2d_conduction_data.sci'
exec(filename)
C=[-(T_left+T_bottom);-T_bottom;-(T_right+T_bottom);-T_left;0;-T_right;-(T_left+T_top);-T_top;-(T_right+T_top)] //matrix of constants
A=[-4 1 0 1 0 0 0 0 0
1 -4 1 0 1 0 0 0 0
0 1 -4 0 0 1 0 0 0
1 0 0 -4 1 0 1 0 0
0 1 0 1 -4 1 0 1 0
0 0 1 0 1 -4 0 0 1
0 0 0 1 0 0 -4 1 0
0 0 0 0 1 0 1 -4 1
0 0 0 0 0 1 0 1 -4] //matrix of coefficients
A_inv=inv(A) //inverse of matrix of coefficients
T=A_inv*C //solving system of equations AT=C