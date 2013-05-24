//POVRay-File created by 3d41.ulp v1.05
//C:/Documents and Settings/Michael Shimniok/My Documents/eagle/RS232 to TTL/RS232toTTL.brd
//2/3/2010 5:12:40 PM

#version 3.5;

//Set to on if the file should be used as .inc
#local use_file_as_inc = off;
#if(use_file_as_inc=off)


//changes the apperance of resistors (1 Blob / 0 real)
#declare global_res_shape = 1;
//randomize color of resistors 1=random 0=same color
#declare global_res_colselect = 0;
//Number of the color for the resistors
//0=Green, 1="normal color" 2=Blue 3=Brown
#declare global_res_col = 1;
//Set to on if you want to render the PCB upside-down
#declare pcb_upsidedown = off;
//Set to x or z to rotate around the corresponding axis (referring to pcb_upsidedown)
#declare pcb_rotdir = x;
//Set the length off short pins over the PCB
#declare pin_length = 2.5;
#declare global_diode_bend_radius = 1;
#declare global_res_bend_radius = 1;
#declare global_solder = on;

#declare global_show_screws = on;
#declare global_show_washers = on;
#declare global_show_nuts = on;

//Animation
#declare global_anim = off;
#local global_anim_showcampath = no;

#declare global_fast_mode = off;

#declare col_preset = 2;
#declare pin_short = on;

#declare environment = on;

#local cam_x = 0;
#local cam_y = 158;
#local cam_z = -77;
#local cam_a = 20;
#local cam_look_x = 0;
#local cam_look_y = -3;
#local cam_look_z = 0;

#local pcb_rotate_x = 0;
#local pcb_rotate_y = 0;
#local pcb_rotate_z = 0;

#local pcb_board = on;
#local pcb_parts = on;
#if(global_fast_mode=off)
	#local pcb_polygons = on;
	#local pcb_silkscreen = on;
	#local pcb_wires = on;
	#local pcb_pads_smds = on;
#else
	#local pcb_polygons = off;
	#local pcb_silkscreen = off;
	#local pcb_wires = off;
	#local pcb_pads_smds = off;
#end

#local lgt1_pos_x = 18;
#local lgt1_pos_y = 28;
#local lgt1_pos_z = 17;
#local lgt1_intense = 0.723867;
#local lgt2_pos_x = -18;
#local lgt2_pos_y = 28;
#local lgt2_pos_z = 17;
#local lgt2_intense = 0.723867;
#local lgt3_pos_x = 18;
#local lgt3_pos_y = 28;
#local lgt3_pos_z = -12;
#local lgt3_intense = 0.723867;
#local lgt4_pos_x = -18;
#local lgt4_pos_y = 28;
#local lgt4_pos_z = -12;
#local lgt4_intense = 0.723867;

//Do not change these values
#declare pcb_height = 1.500000;
#declare pcb_cuheight = 0.035000;
#declare pcb_x_size = 49.530000;
#declare pcb_y_size = 33.731200;
#declare pcb_layer1_used = 0;
#declare pcb_layer16_used = 1;
#declare inc_testmode = off;
#declare global_seed=seed(298);
#declare global_pcb_layer_dis = array[16]
{
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	1.535000,
}
#declare global_pcb_real_hole = 2.000000;

#include "tools.inc"
#include "user.inc"

global_settings{charset utf8}

#if(environment=on)
sky_sphere {pigment {Navy}
pigment {bozo turbulence 0.65 octaves 7 omega 0.7 lambda 2
color_map {
[0.0 0.1 color rgb <0.85, 0.85, 0.85> color rgb <0.75, 0.75, 0.75>]
[0.1 0.5 color rgb <0.75, 0.75, 0.75> color rgbt <1, 1, 1, 1>]
[0.5 1.0 color rgbt <1, 1, 1, 1> color rgbt <1, 1, 1, 1>]}
scale <0.1, 0.5, 0.1>} rotate -90*x}
plane{y, -10.0-max(pcb_x_size,pcb_y_size)*abs(max(sin((pcb_rotate_x/180)*pi),sin((pcb_rotate_z/180)*pi)))
texture{T_Chrome_2D
normal{waves 0.1 frequency 3000.0 scale 3000.0}} translate<0,0,0>}
#end

//Animation data
#if(global_anim=on)
#declare global_anim_showcampath = no;
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_flight=0;
#warning "No/not enough Animation Data available (min. 3 points) (Flight path)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_view=0;
#warning "No/not enough Animation Data available (min. 3 points) (View path)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#end

#if((global_anim_showcampath=yes)&(global_anim=off))
#end
#if(global_anim=on)
camera
{
	location global_anim_spline_cam_flight(clock)
	#if(global_anim_npoints_cam_view>2)
		look_at global_anim_spline_cam_view(clock)
	#else
		look_at global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	angle 45
}
light_source
{
	global_anim_spline_cam_flight(clock)
	color rgb <1,1,1>
	spotlight point_at 
	#if(global_anim_npoints_cam_view>2)
		global_anim_spline_cam_view(clock)
	#else
		global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	radius 35 falloff  40
}
#else
camera
{
	location <cam_x,cam_y,cam_z>
	look_at <cam_look_x,cam_look_y,cam_look_z>
	angle cam_a
	//translates the camera that <0,0,0> is over the Eagle <0,0>
	//translate<-24.765000,0,-16.865600>
}
#end

background{col_bgr}


//Axis uncomment to activate
//object{TOOLS_AXIS_XYZ(100,100,100 //texture{ pigment{rgb<1,0,0>} finish{diffuse 0.8 phong 1}}, //texture{ pigment{rgb<1,1,1>} finish{diffuse 0.8 phong 1}})}

light_source{<lgt1_pos_x,lgt1_pos_y,lgt1_pos_z> White*lgt1_intense}
light_source{<lgt2_pos_x,lgt2_pos_y,lgt2_pos_z> White*lgt2_intense}
light_source{<lgt3_pos_x,lgt3_pos_y,lgt3_pos_z> White*lgt3_intense}
light_source{<lgt4_pos_x,lgt4_pos_y,lgt4_pos_z> White*lgt4_intense}
#end


#macro RS232TOTTL(mac_x_ver,mac_y_ver,mac_z_ver,mac_x_rot,mac_y_rot,mac_z_rot)
union{
#if(pcb_board = on)
difference{
union{
//Board
prism{-1.500000,0.000000,8
<0.000000,0.000000><49.530000,0.000000>
<49.530000,0.000000><49.530000,33.731200>
<49.530000,33.731200><0.000000,33.731200>
<0.000000,33.731200><0.000000,0.000000>
texture{col_brd}}
}//End union(Platine)
//Holes(real)/Parts
//Holes(real)/Board
//Holes(real)/Vias
cylinder{<5.080000,0.095000,31.038800><5.080000,-1.595000,31.038800>1.400000 texture{col_hls}}
cylinder{<45.085000,0.095000,2.540000><45.085000,-1.595000,2.540000>1.400000 texture{col_hls}}
}//End difference(reale Bohrungen/Durchbrüche)
#end
#if(pcb_parts=on)//Parts
union{
#ifndef(pack_C1) #declare global_pack_C1=yes; object {CAP_DIS_ELKO_2MM5_5MM("10U",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<7.620000,0.000000,24.130000>}#end		//Elko 2,5mm Pitch, 5mm  Diameter, 11,2mm High C1 10U E2,5-5
#ifndef(pack_D1) #declare global_pack_D1=yes; object {DIODE_DIS_DO35_076MM_H("1N4148",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<17.780000,0.000000,24.130000>}#end		//Diode DO35 7mm hor. D1 1N4148 DO35-7
#ifndef(pack_LED1) #declare global_pack_LED1=yes; object {DIODE_DIS_LED_5MM(Red,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<35.560000,0.000000,26.670000>}#end		//Diskrete 5MM LED LED1  LED5MM
#ifndef(pack_LED2) #declare global_pack_LED2=yes; object {DIODE_DIS_LED_5MM(Green,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<35.560000,0.000000,7.620000>}#end		//Diskrete 5MM LED LED2  LED5MM
#ifndef(pack_Q1) #declare global_pack_Q1=yes; object {TR_TO92_G("2N3906",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<13.970000,0.000000,10.160000>}#end		//TO92 bend vertical Q1 2N3906 TO92
#ifndef(pack_Q2) #declare global_pack_Q2=yes; object {TR_TO92_G("2N3904",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<29.210000,0.000000,22.860000>}#end		//TO92 bend vertical Q2 2N3904 TO92
#ifndef(pack_R1) #declare global_pack_R1=yes; object {RES_DIS_0207_10MM(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{Orange}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<12.700000,0.000000,22.860000>}#end		//Discrete Resistor 0,3W 10MM Grid R1 10K 0207/10
#ifndef(pack_R2) #declare global_pack_R2=yes; object {RES_DIS_0207_10MM(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{Orange}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<16.510000,0.000000,3.810000>}#end		//Discrete Resistor 0,3W 10MM Grid R2 10K 0207/10
#ifndef(pack_R3) #declare global_pack_R3=yes; object {RES_DIS_0207_10MM(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{Orange}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<33.020000,0.000000,17.780000>}#end		//Discrete Resistor 0,3W 10MM Grid R3 10K 0207/10
#ifndef(pack_R4) #declare global_pack_R4=yes; object {RES_DIS_0207_10MM(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{Orange}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<21.590000,0.000000,16.510000>}#end		//Discrete Resistor 0,3W 10MM Grid R4 10K 0207/10
#ifndef(pack_R5) #declare global_pack_R5=yes; object {RES_DIS_0207_10MM(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{Orange}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<24.130000,0.000000,24.130000>}#end		//Discrete Resistor 0,3W 10MM Grid R5 10K 0207/10
#ifndef(pack_R6) #declare global_pack_R6=yes; object {RES_DIS_0207_10MM(texture{pigment{Red*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<38.100000,0.000000,17.780000>}#end		//Discrete Resistor 0,3W 10MM Grid R6 220 0207/10
#ifndef(pack_R7) #declare global_pack_R7=yes; object {RES_DIS_0207_10MM(texture{pigment{Red*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<25.400000,0.000000,7.620000>}#end		//Discrete Resistor 0,3W 10MM Grid R7 220 0207/10
#ifndef(pack_SV1) #declare global_pack_SV1=yes; object {PH_1X5()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<6.350000,0.000000,11.430000>}#end		//Header 2,54mm Grid 5Pin 1Row (jumper.lib) SV1  MA05-1
#ifndef(pack_SV2) #declare global_pack_SV2=yes; object {PH_1X4()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<43.180000,0.000000,16.510000>}#end		//Header 2,54mm Grid 4Pin 1Row (jumper.lib) SV2  MA04-1
}//End union
#end
#if(pcb_pads_smds=on)
//Pads&SMD/Parts
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<7.620000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.600200,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<7.620000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_D1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<17.780000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_D1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<17.780000,0,20.320000> texture{col_thl}}
#ifndef(global_pack_LED1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<36.830000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_LED1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<34.290000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_LED2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<35.560000,0,6.350000> texture{col_thl}}
#ifndef(global_pack_LED2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<35.560000,0,8.890000> texture{col_thl}}
#ifndef(global_pack_Q1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<12.700000,0,10.160000> texture{col_thl}}
#ifndef(global_pack_Q1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<13.970000,0,8.255000> texture{col_thl}}
#ifndef(global_pack_Q1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<15.240000,0,10.160000> texture{col_thl}}
#ifndef(global_pack_Q2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<29.210000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_Q2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<27.305000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_Q2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<29.210000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<12.700000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<12.700000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<11.430000,0,3.810000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<21.590000,0,3.810000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<33.020000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<33.020000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<16.510000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<26.670000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_R5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<24.130000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_R5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<24.130000,0,29.210000> texture{col_thl}}
#ifndef(global_pack_R6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<38.100000,0,22.860000> texture{col_thl}}
#ifndef(global_pack_R6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,2+global_tmp,0) rotate<0,-270.000000,0>translate<38.100000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_R7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<25.400000,0,2.540000> texture{col_thl}}
#ifndef(global_pack_R7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.422400,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<25.400000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<6.350000,0,6.350000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<6.350000,0,8.890000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<6.350000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<6.350000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_SV1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<6.350000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<43.180000,0,12.700000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<43.180000,0,15.240000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<43.180000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_SV2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<43.180000,0,20.320000> texture{col_thl}}
//Pads/Vias
object{TOOLS_PCB_VIA(3.816000,2.800000,1,16,0,0) translate<5.080000,0,31.038800> texture{col_thl}}
object{TOOLS_PCB_VIA(3.816000,2.800000,1,16,0,0) translate<45.085000,0,2.540000> texture{col_thl}}
#end
#if(pcb_wires=on)
union{
//Signals
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<6.350000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<7.620000,-1.535000,11.430000>}
box{<0,0,-0.508000><1.270000,0.035000,0.508000> rotate<0,0.000000,0> translate<6.350000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<7.620000,-1.535000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<7.620000,-1.535000,26.670000>}
box{<0,0,-0.508000><1.270000,0.035000,0.508000> rotate<0,90.000000,0> translate<7.620000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<7.620000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<8.890000,-1.535000,12.700000>}
box{<0,0,-0.508000><1.796051,0.035000,0.508000> rotate<0,-44.997030,0> translate<7.620000,-1.535000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<8.890000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<8.890000,-1.535000,19.050000>}
box{<0,0,-0.508000><6.350000,0.035000,0.508000> rotate<0,90.000000,0> translate<8.890000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<7.620000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<8.890000,-1.535000,27.940000>}
box{<0,0,-0.508000><1.796051,0.035000,0.508000> rotate<0,-44.997030,0> translate<7.620000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<8.890000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<10.160000,-1.535000,20.320000>}
box{<0,0,-0.508000><1.796051,0.035000,0.508000> rotate<0,-44.997030,0> translate<8.890000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<11.430000,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<11.430000,-1.535000,5.080000>}
box{<0,0,-0.508000><1.270000,0.035000,0.508000> rotate<0,90.000000,0> translate<11.430000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<6.350000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<11.430000,-1.535000,8.890000>}
box{<0,0,-0.508000><5.080000,0.035000,0.508000> rotate<0,0.000000,0> translate<6.350000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<11.430000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<12.700000,-1.535000,10.160000>}
box{<0,0,-0.508000><1.796051,0.035000,0.508000> rotate<0,-44.997030,0> translate<11.430000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<12.700000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<12.700000,-1.535000,17.780000>}
box{<0,0,-0.508000><7.620000,0.035000,0.508000> rotate<0,90.000000,0> translate<12.700000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<8.890000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<12.700000,-1.535000,27.940000>}
box{<0,0,-0.508000><3.810000,0.035000,0.508000> rotate<0,0.000000,0> translate<8.890000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<11.430000,-1.535000,5.080000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<13.970000,-1.535000,7.620000>}
box{<0,0,-0.508000><3.592102,0.035000,0.508000> rotate<0,-44.997030,0> translate<11.430000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<13.970000,-1.535000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<13.970000,-1.535000,8.255000>}
box{<0,0,-0.508000><0.635000,0.035000,0.508000> rotate<0,90.000000,0> translate<13.970000,-1.535000,8.255000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<16.510000,-1.535000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<17.780000,-1.535000,17.780000>}
box{<0,0,-0.508000><1.796051,0.035000,0.508000> rotate<0,-44.997030,0> translate<16.510000,-1.535000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<17.780000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<17.780000,-1.535000,17.780000>}
box{<0,0,-0.508000><2.540000,0.035000,0.508000> rotate<0,-90.000000,0> translate<17.780000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<10.160000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<17.780000,-1.535000,20.320000>}
box{<0,0,-0.508000><7.620000,0.035000,0.508000> rotate<0,0.000000,0> translate<10.160000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<12.700000,-1.535000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<17.780000,-1.535000,27.940000>}
box{<0,0,-0.508000><5.080000,0.035000,0.508000> rotate<0,0.000000,0> translate<12.700000,-1.535000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<15.240000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<21.590000,-1.535000,10.160000>}
box{<0,0,-0.508000><6.350000,0.035000,0.508000> rotate<0,0.000000,0> translate<15.240000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<21.590000,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<24.130000,-1.535000,12.700000>}
box{<0,0,-0.508000><3.592102,0.035000,0.508000> rotate<0,-44.997030,0> translate<21.590000,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<24.130000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<24.130000,-1.535000,21.590000>}
box{<0,0,-0.508000><2.540000,0.035000,0.508000> rotate<0,90.000000,0> translate<24.130000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<24.130000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<25.400000,-1.535000,12.700000>}
box{<0,0,-0.508000><1.270000,0.035000,0.508000> rotate<0,0.000000,0> translate<24.130000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<24.130000,-1.535000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<25.400000,-1.535000,22.860000>}
box{<0,0,-0.508000><1.796051,0.035000,0.508000> rotate<0,-44.997030,0> translate<24.130000,-1.535000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<21.590000,-1.535000,3.810000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<26.670000,-1.535000,8.890000>}
box{<0,0,-0.508000><7.184205,0.035000,0.508000> rotate<0,-44.997030,0> translate<21.590000,-1.535000,3.810000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<24.130000,-1.535000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<26.670000,-1.535000,16.510000>}
box{<0,0,-0.508000><3.592102,0.035000,0.508000> rotate<0,44.997030,0> translate<24.130000,-1.535000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<25.400000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<27.305000,-1.535000,22.860000>}
box{<0,0,-0.508000><1.905000,0.035000,0.508000> rotate<0,0.000000,0> translate<25.400000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<25.400000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<31.750000,-1.535000,2.540000>}
box{<0,0,-0.508000><6.350000,0.035000,0.508000> rotate<0,0.000000,0> translate<25.400000,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<29.210000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<31.750000,-1.535000,24.130000>}
box{<0,0,-0.508000><2.540000,0.035000,0.508000> rotate<0,0.000000,0> translate<29.210000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<25.400000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<33.020000,-1.535000,12.700000>}
box{<0,0,-0.508000><7.620000,0.035000,0.508000> rotate<0,0.000000,0> translate<25.400000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<31.750000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<33.020000,-1.535000,22.860000>}
box{<0,0,-0.508000><1.796051,0.035000,0.508000> rotate<0,44.997030,0> translate<31.750000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<31.750000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<34.290000,-1.535000,26.670000>}
box{<0,0,-0.508000><3.592102,0.035000,0.508000> rotate<0,-44.997030,0> translate<31.750000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<31.750000,-1.535000,2.540000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<35.560000,-1.535000,6.350000>}
box{<0,0,-0.508000><5.388154,0.035000,0.508000> rotate<0,-44.997030,0> translate<31.750000,-1.535000,2.540000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<26.670000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<35.560000,-1.535000,8.890000>}
box{<0,0,-0.508000><8.890000,0.035000,0.508000> rotate<0,0.000000,0> translate<26.670000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<36.830000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<36.830000,-1.535000,26.670000>}
box{<0,0,-0.508000><2.540000,0.035000,0.508000> rotate<0,90.000000,0> translate<36.830000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<33.020000,-1.535000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<38.100000,-1.535000,17.780000>}
box{<0,0,-0.508000><7.184205,0.035000,0.508000> rotate<0,44.997030,0> translate<33.020000,-1.535000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<36.830000,-1.535000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<38.100000,-1.535000,22.860000>}
box{<0,0,-0.508000><1.796051,0.035000,0.508000> rotate<0,44.997030,0> translate<36.830000,-1.535000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<35.560000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<43.180000,-1.535000,8.890000>}
box{<0,0,-0.508000><7.620000,0.035000,0.508000> rotate<0,0.000000,0> translate<35.560000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<33.020000,-1.535000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<43.180000,-1.535000,12.700000>}
box{<0,0,-0.508000><10.160000,0.035000,0.508000> rotate<0,0.000000,0> translate<33.020000,-1.535000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<38.100000,-1.535000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<43.180000,-1.535000,17.780000>}
box{<0,0,-0.508000><5.080000,0.035000,0.508000> rotate<0,0.000000,0> translate<38.100000,-1.535000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<43.180000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<44.450000,-1.535000,20.320000>}
box{<0,0,-0.508000><1.270000,0.035000,0.508000> rotate<0,0.000000,0> translate<43.180000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<43.180000,-1.535000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<45.720000,-1.535000,11.430000>}
box{<0,0,-0.508000><3.592102,0.035000,0.508000> rotate<0,-44.997030,0> translate<43.180000,-1.535000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<44.450000,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<45.720000,-1.535000,19.050000>}
box{<0,0,-0.508000><1.796051,0.035000,0.508000> rotate<0,44.997030,0> translate<44.450000,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<45.720000,-1.535000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<45.720000,-1.535000,19.050000>}
box{<0,0,-0.508000><7.620000,0.035000,0.508000> rotate<0,90.000000,0> translate<45.720000,-1.535000,19.050000> }
//Text
//Rect
union{
texture{col_pds}
}
texture{col_wrs}
}
#end
#if(pcb_polygons=on)
union{
//Polygons
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,0.812700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,32.918400>}
box{<0,0,-0.203200><32.105700,0.035000,0.203200> rotate<0,90.000000,0> translate<0.812700,-1.535000,32.918400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,0.812700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,0.812700>}
box{<0,0,-0.203200><47.904500,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,0.812700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,0.812800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,0.812800>}
box{<0,0,-0.203200><47.904500,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,0.812800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,1.219200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.565500,-1.535000,1.219200>}
box{<0,0,-0.203200><23.752800,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,1.219200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,1.625600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.159100,-1.535000,1.625600>}
box{<0,0,-0.203200><23.346400,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,1.625600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,2.032000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.876000,-1.535000,2.032000>}
box{<0,0,-0.203200><23.063300,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,2.032000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,2.438400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.646300,-1.535000,2.438400>}
box{<0,0,-0.203200><9.833600,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,2.438400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,2.844800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.239900,-1.535000,2.844800>}
box{<0,0,-0.203200><9.427200,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,2.844800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.906000,-1.535000,3.251200>}
box{<0,0,-0.203200><9.093300,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.906000,-1.535000,3.657600>}
box{<0,0,-0.203200><9.093300,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.906000,-1.535000,4.064000>}
box{<0,0,-0.203200><9.093300,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.935300,-1.535000,4.470400>}
box{<0,0,-0.203200><9.122600,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.845800,-1.535000,4.876800>}
box{<0,0,-0.203200><4.033100,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.305000,-1.535000,5.283200>}
box{<0,0,-0.203200><3.492300,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.051100,-1.535000,5.689600>}
box{<0,0,-0.203200><3.238400,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.911600,-1.535000,6.096000>}
box{<0,0,-0.203200><3.098900,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.911600,-1.535000,6.502400>}
box{<0,0,-0.203200><3.098900,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.009200,-1.535000,6.908800>}
box{<0,0,-0.203200><3.196500,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.203600,-1.535000,7.315200>}
box{<0,0,-0.203200><3.390900,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,7.721600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.406600,-1.535000,7.721600>}
box{<0,0,-0.203200><3.593900,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,7.721600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.093200,-1.535000,8.128000>}
box{<0,0,-0.203200><3.280500,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,8.534400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.924900,-1.535000,8.534400>}
box{<0,0,-0.203200><3.112200,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,8.534400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.911600,-1.535000,8.940800>}
box{<0,0,-0.203200><3.098900,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.967100,-1.535000,9.347200>}
box{<0,0,-0.203200><3.154400,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.135500,-1.535000,9.753600>}
box{<0,0,-0.203200><3.322800,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.508200,-1.535000,10.160000>}
box{<0,0,-0.203200><3.695500,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.135300,-1.535000,10.566400>}
box{<0,0,-0.203200><3.322600,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.967000,-1.535000,10.972800>}
box{<0,0,-0.203200><3.154300,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.911600,-1.535000,11.379200>}
box{<0,0,-0.203200><3.098900,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,11.785600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.925000,-1.535000,11.785600>}
box{<0,0,-0.203200><3.112300,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,11.785600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.093400,-1.535000,12.192000>}
box{<0,0,-0.203200><3.280700,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.406800,-1.535000,12.598400>}
box{<0,0,-0.203200><3.594100,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,12.598400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.203400,-1.535000,13.004800>}
box{<0,0,-0.203200><3.390700,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.009100,-1.535000,13.411200>}
box{<0,0,-0.203200><3.196400,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.911600,-1.535000,13.817600>}
box{<0,0,-0.203200><3.098900,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.911600,-1.535000,14.224000>}
box{<0,0,-0.203200><3.098900,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.051300,-1.535000,14.630400>}
box{<0,0,-0.203200><3.238600,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.305100,-1.535000,15.036800>}
box{<0,0,-0.203200><3.492400,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.846200,-1.535000,15.443200>}
box{<0,0,-0.203200><4.033500,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.569200,-1.535000,15.849600>}
box{<0,0,-0.203200><6.756500,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.569200,-1.535000,16.256000>}
box{<0,0,-0.203200><6.756500,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.569200,-1.535000,16.662400>}
box{<0,0,-0.203200><6.756500,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.569200,-1.535000,17.068800>}
box{<0,0,-0.203200><6.756500,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,17.475200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.569200,-1.535000,17.475200>}
box{<0,0,-0.203200><6.756500,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,17.475200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,17.881600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.569200,-1.535000,17.881600>}
box{<0,0,-0.203200><6.756500,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,17.881600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.569200,-1.535000,18.288000>}
box{<0,0,-0.203200><6.756500,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.569200,-1.535000,18.694400>}
box{<0,0,-0.203200><6.756500,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,19.100800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.569200,-1.535000,19.100800>}
box{<0,0,-0.203200><6.756500,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,19.100800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.649800,-1.535000,19.507200>}
box{<0,0,-0.203200><6.837100,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,19.913600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.885800,-1.535000,19.913600>}
box{<0,0,-0.203200><7.073100,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,19.913600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.292200,-1.535000,20.320000>}
box{<0,0,-0.203200><7.479500,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.698600,-1.535000,20.726400>}
box{<0,0,-0.203200><7.885900,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,21.132800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.105000,-1.535000,21.132800>}
box{<0,0,-0.203200><8.292300,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,21.132800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,21.539200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.652300,-1.535000,21.539200>}
box{<0,0,-0.203200><8.839600,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,21.539200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.539200,-1.535000,21.945600>}
box{<0,0,-0.203200><15.726500,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.986500,-1.535000,22.352000>}
box{<0,0,-0.203200><16.173800,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,22.352000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,22.758400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.430700,-1.535000,22.758400>}
box{<0,0,-0.203200><22.618000,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,22.758400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,23.164800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.837100,-1.535000,23.164800>}
box{<0,0,-0.203200><23.024400,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,23.164800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,23.571200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.243500,-1.535000,23.571200>}
box{<0,0,-0.203200><23.430800,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,23.571200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,23.977600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.761400,-1.535000,23.977600>}
box{<0,0,-0.203200><5.948700,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,23.977600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.355000,-1.535000,24.384000>}
box{<0,0,-0.203200><5.542300,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,24.790400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.007100,-1.535000,24.790400>}
box{<0,0,-0.203200><5.194400,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,24.790400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,25.196800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.007100,-1.535000,25.196800>}
box{<0,0,-0.203200><5.194400,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,25.196800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,25.603200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.007100,-1.535000,25.603200>}
box{<0,0,-0.203200><5.194400,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,25.603200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,26.009600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.007100,-1.535000,26.009600>}
box{<0,0,-0.203200><5.194400,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,26.009600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.299200,-1.535000,26.416000>}
box{<0,0,-0.203200><5.486500,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,26.822400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.299200,-1.535000,26.822400>}
box{<0,0,-0.203200><5.486500,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,26.822400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,27.228800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.421900,-1.535000,27.228800>}
box{<0,0,-0.203200><5.609200,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,27.228800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,27.635200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.717400,-1.535000,27.635200>}
box{<0,0,-0.203200><5.904700,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,27.635200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,28.041600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.123800,-1.535000,28.041600>}
box{<0,0,-0.203200><6.311100,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,28.041600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,28.448000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.530200,-1.535000,28.448000>}
box{<0,0,-0.203200><6.717500,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,28.448000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,28.854400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.936600,-1.535000,28.854400>}
box{<0,0,-0.203200><7.123900,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,28.854400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,29.260800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.865700,-1.535000,29.260800>}
box{<0,0,-0.203200><11.053000,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,29.260800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,29.667200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.640800,-1.535000,29.667200>}
box{<0,0,-0.203200><15.828100,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,29.667200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,30.073600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.231800,-1.535000,30.073600>}
box{<0,0,-0.203200><16.419100,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,30.073600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,30.480000>}
box{<0,0,-0.203200><47.904500,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,30.886400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,30.886400>}
box{<0,0,-0.203200><47.904500,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,30.886400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,31.292800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,31.292800>}
box{<0,0,-0.203200><47.904500,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,31.292800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,31.699200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,31.699200>}
box{<0,0,-0.203200><47.904500,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,31.699200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,32.105600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,32.105600>}
box{<0,0,-0.203200><47.904500,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,32.105600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,32.512000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,32.512000>}
box{<0,0,-0.203200><47.904500,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,32.512000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<0.812700,-1.535000,32.918400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,32.918400>}
box{<0,0,-0.203200><47.904500,0.035000,0.203200> rotate<0,0.000000,0> translate<0.812700,-1.535000,32.918400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.911600,-1.535000,6.026600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.159100,-1.535000,5.429100>}
box{<0,0,-0.203200><0.646732,0.035000,0.203200> rotate<0,67.494940,0> translate<3.911600,-1.535000,6.026600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.911600,-1.535000,6.673300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.911600,-1.535000,6.026600>}
box{<0,0,-0.203200><0.646700,0.035000,0.203200> rotate<0,-90.000000,0> translate<3.911600,-1.535000,6.026600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.911600,-1.535000,6.673300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.159100,-1.535000,7.270800>}
box{<0,0,-0.203200><0.646732,0.035000,0.203200> rotate<0,-67.494940,0> translate<3.911600,-1.535000,6.673300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.911600,-1.535000,8.566600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.159100,-1.535000,7.969100>}
box{<0,0,-0.203200><0.646732,0.035000,0.203200> rotate<0,67.494940,0> translate<3.911600,-1.535000,8.566600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.911600,-1.535000,9.213300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.911600,-1.535000,8.566600>}
box{<0,0,-0.203200><0.646700,0.035000,0.203200> rotate<0,-90.000000,0> translate<3.911600,-1.535000,8.566600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.911600,-1.535000,9.213300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.159100,-1.535000,9.810800>}
box{<0,0,-0.203200><0.646732,0.035000,0.203200> rotate<0,-67.494940,0> translate<3.911600,-1.535000,9.213300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.911600,-1.535000,11.106600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.159100,-1.535000,10.509100>}
box{<0,0,-0.203200><0.646732,0.035000,0.203200> rotate<0,67.494940,0> translate<3.911600,-1.535000,11.106600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.911600,-1.535000,11.753300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.911600,-1.535000,11.106600>}
box{<0,0,-0.203200><0.646700,0.035000,0.203200> rotate<0,-90.000000,0> translate<3.911600,-1.535000,11.106600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.911600,-1.535000,11.753300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.159100,-1.535000,12.350800>}
box{<0,0,-0.203200><0.646732,0.035000,0.203200> rotate<0,-67.494940,0> translate<3.911600,-1.535000,11.753300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.911600,-1.535000,13.646600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.159100,-1.535000,13.049100>}
box{<0,0,-0.203200><0.646732,0.035000,0.203200> rotate<0,67.494940,0> translate<3.911600,-1.535000,13.646600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.911600,-1.535000,14.293300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.911600,-1.535000,13.646600>}
box{<0,0,-0.203200><0.646700,0.035000,0.203200> rotate<0,-90.000000,0> translate<3.911600,-1.535000,13.646600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<3.911600,-1.535000,14.293300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.159100,-1.535000,14.890800>}
box{<0,0,-0.203200><0.646732,0.035000,0.203200> rotate<0,-67.494940,0> translate<3.911600,-1.535000,14.293300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.159100,-1.535000,5.429100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.616300,-1.535000,4.971900>}
box{<0,0,-0.203200><0.646578,0.035000,0.203200> rotate<0,44.997030,0> translate<4.159100,-1.535000,5.429100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.159100,-1.535000,7.270800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.508300,-1.535000,7.619900>}
box{<0,0,-0.203200><0.493773,0.035000,0.203200> rotate<0,-44.988826,0> translate<4.159100,-1.535000,7.270800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.159100,-1.535000,7.969100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.508300,-1.535000,7.619900>}
box{<0,0,-0.203200><0.493843,0.035000,0.203200> rotate<0,44.997030,0> translate<4.159100,-1.535000,7.969100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.159100,-1.535000,9.810800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.508300,-1.535000,10.159900>}
box{<0,0,-0.203200><0.493773,0.035000,0.203200> rotate<0,-44.988826,0> translate<4.159100,-1.535000,9.810800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.159100,-1.535000,10.509100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.508300,-1.535000,10.159900>}
box{<0,0,-0.203200><0.493843,0.035000,0.203200> rotate<0,44.997030,0> translate<4.159100,-1.535000,10.509100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.159100,-1.535000,12.350800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.508300,-1.535000,12.699900>}
box{<0,0,-0.203200><0.493773,0.035000,0.203200> rotate<0,-44.988826,0> translate<4.159100,-1.535000,12.350800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.159100,-1.535000,13.049100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.508300,-1.535000,12.699900>}
box{<0,0,-0.203200><0.493843,0.035000,0.203200> rotate<0,44.997030,0> translate<4.159100,-1.535000,13.049100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.159100,-1.535000,14.890800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.616300,-1.535000,15.348000>}
box{<0,0,-0.203200><0.646578,0.035000,0.203200> rotate<0,-44.997030,0> translate<4.159100,-1.535000,14.890800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.616300,-1.535000,4.971900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.213800,-1.535000,4.724400>}
box{<0,0,-0.203200><0.646732,0.035000,0.203200> rotate<0,22.499120,0> translate<4.616300,-1.535000,4.971900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<4.616300,-1.535000,15.348000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.213800,-1.535000,15.595500>}
box{<0,0,-0.203200><0.646732,0.035000,0.203200> rotate<0,-22.499120,0> translate<4.616300,-1.535000,15.348000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.213800,-1.535000,4.724400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.486100,-1.535000,4.724400>}
box{<0,0,-0.203200><2.272300,0.035000,0.203200> rotate<0,0.000000,0> translate<5.213800,-1.535000,4.724400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<5.213800,-1.535000,15.595500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.486100,-1.535000,15.595500>}
box{<0,0,-0.203200><2.272300,0.035000,0.203200> rotate<0,0.000000,0> translate<5.213800,-1.535000,15.595500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.007100,-1.535000,24.731900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.951900,-1.535000,23.787100>}
box{<0,0,-0.203200><1.336149,0.035000,0.203200> rotate<0,44.997030,0> translate<6.007100,-1.535000,24.731900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.007100,-1.535000,26.068000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.007100,-1.535000,24.731900>}
box{<0,0,-0.203200><1.336100,0.035000,0.203200> rotate<0,-90.000000,0> translate<6.007100,-1.535000,24.731900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.007100,-1.535000,26.068000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.299200,-1.535000,26.360100>}
box{<0,0,-0.203200><0.413092,0.035000,0.203200> rotate<0,-44.997030,0> translate<6.007100,-1.535000,26.068000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.299200,-1.535000,26.407200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.299200,-1.535000,26.360100>}
box{<0,0,-0.203200><0.047100,0.035000,0.203200> rotate<0,-90.000000,0> translate<6.299200,-1.535000,26.360100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.299200,-1.535000,26.932700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.299200,-1.535000,26.407200>}
box{<0,0,-0.203200><0.525500,0.035000,0.203200> rotate<0,-90.000000,0> translate<6.299200,-1.535000,26.407200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.299200,-1.535000,26.932700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.500300,-1.535000,27.418100>}
box{<0,0,-0.203200><0.525409,0.035000,0.203200> rotate<0,-67.491441,0> translate<6.299200,-1.535000,26.932700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.500300,-1.535000,27.418100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.770300,-1.535000,28.688100>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<6.500300,-1.535000,27.418100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<6.951900,-1.535000,23.787100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.288000,-1.535000,23.787100>}
box{<0,0,-0.203200><1.336100,0.035000,0.203200> rotate<0,0.000000,0> translate<6.951900,-1.535000,23.787100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.486100,-1.535000,4.724400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.083600,-1.535000,4.971900>}
box{<0,0,-0.203200><0.646732,0.035000,0.203200> rotate<0,-22.499120,0> translate<7.486100,-1.535000,4.724400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.486100,-1.535000,15.595500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.569200,-1.535000,15.561000>}
box{<0,0,-0.203200><0.089977,0.035000,0.203200> rotate<0,22.544902,0> translate<7.486100,-1.535000,15.595500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.569200,-1.535000,18.787200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.569200,-1.535000,15.561000>}
box{<0,0,-0.203200><3.226200,0.035000,0.203200> rotate<0,-90.000000,0> translate<7.569200,-1.535000,15.561000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.569200,-1.535000,19.312700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.569200,-1.535000,18.787200>}
box{<0,0,-0.203200><0.525500,0.035000,0.203200> rotate<0,-90.000000,0> translate<7.569200,-1.535000,18.787200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.569200,-1.535000,19.312700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.770300,-1.535000,19.798100>}
box{<0,0,-0.203200><0.525409,0.035000,0.203200> rotate<0,-67.491441,0> translate<7.569200,-1.535000,19.312700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.770300,-1.535000,19.798100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.411800,-1.535000,21.439600>}
box{<0,0,-0.203200><2.321432,0.035000,0.203200> rotate<0,-44.997030,0> translate<7.770300,-1.535000,19.798100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.770300,-1.535000,28.688100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.141800,-1.535000,29.059600>}
box{<0,0,-0.203200><0.525380,0.035000,0.203200> rotate<0,-44.997030,0> translate<7.770300,-1.535000,28.688100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<7.854000,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.109200,-1.535000,4.876800>}
box{<0,0,-0.203200><2.255200,0.035000,0.203200> rotate<0,0.000000,0> translate<7.854000,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.083600,-1.535000,4.971900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.540800,-1.535000,5.429100>}
box{<0,0,-0.203200><0.646578,0.035000,0.203200> rotate<0,-44.997030,0> translate<8.083600,-1.535000,4.971900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.141800,-1.535000,29.059600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.627200,-1.535000,29.260700>}
box{<0,0,-0.203200><0.525409,0.035000,0.203200> rotate<0,-22.502619,0> translate<8.141800,-1.535000,29.059600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.242300,-1.535000,7.569200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.540800,-1.535000,7.270800>}
box{<0,0,-0.203200><0.422072,0.035000,0.203200> rotate<0,44.987432,0> translate<8.242300,-1.535000,7.569200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.242300,-1.535000,7.569200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.167200,-1.535000,7.569200>}
box{<0,0,-0.203200><2.924900,0.035000,0.203200> rotate<0,0.000000,0> translate<8.242300,-1.535000,7.569200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.242300,-1.535000,10.210700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.323600,-1.535000,10.291900>}
box{<0,0,-0.203200><0.114905,0.035000,0.203200> rotate<0,-44.961774,0> translate<8.242300,-1.535000,10.210700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.242300,-1.535000,10.210700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.882900,-1.535000,10.210700>}
box{<0,0,-0.203200><2.640600,0.035000,0.203200> rotate<0,0.000000,0> translate<8.242300,-1.535000,10.210700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.288000,-1.535000,23.787100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.232800,-1.535000,24.731900>}
box{<0,0,-0.203200><1.336149,0.035000,0.203200> rotate<0,-44.997030,0> translate<8.288000,-1.535000,23.787100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.323600,-1.535000,10.291900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.368100,-1.535000,10.310300>}
box{<0,0,-0.203200><0.048154,0.035000,0.203200> rotate<0,-22.462787,0> translate<8.323600,-1.535000,10.291900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.368100,-1.535000,10.310300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.739600,-1.535000,10.681800>}
box{<0,0,-0.203200><0.525380,0.035000,0.203200> rotate<0,-44.997030,0> translate<8.368100,-1.535000,10.310300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.394900,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.109200,-1.535000,5.283200>}
box{<0,0,-0.203200><1.714300,0.035000,0.203200> rotate<0,0.000000,0> translate<8.394900,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.478500,-1.535000,23.977600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.649800,-1.535000,23.977600>}
box{<0,0,-0.203200><16.171300,0.035000,0.203200> rotate<0,0.000000,0> translate<8.478500,-1.535000,23.977600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.496400,-1.535000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.797500,-1.535000,7.315200>}
box{<0,0,-0.203200><3.301100,0.035000,0.203200> rotate<0,0.000000,0> translate<8.496400,-1.535000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.540800,-1.535000,5.429100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.788300,-1.535000,6.026600>}
box{<0,0,-0.203200><0.646732,0.035000,0.203200> rotate<0,-67.494940,0> translate<8.540800,-1.535000,5.429100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.540800,-1.535000,7.270800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.788300,-1.535000,6.673300>}
box{<0,0,-0.203200><0.646732,0.035000,0.203200> rotate<0,67.494940,0> translate<8.540800,-1.535000,7.270800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.624200,-1.535000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.176000,-1.535000,10.566400>}
box{<0,0,-0.203200><2.551800,0.035000,0.203200> rotate<0,0.000000,0> translate<8.624200,-1.535000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.627200,-1.535000,29.260700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.865600,-1.535000,29.260700>}
box{<0,0,-0.203200><3.238400,0.035000,0.203200> rotate<0,0.000000,0> translate<8.627200,-1.535000,29.260700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.648700,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.253000,-1.535000,5.689600>}
box{<0,0,-0.203200><1.604300,0.035000,0.203200> rotate<0,0.000000,0> translate<8.648700,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.690800,-1.535000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.391100,-1.535000,6.908800>}
box{<0,0,-0.203200><2.700300,0.035000,0.203200> rotate<0,0.000000,0> translate<8.690800,-1.535000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.739600,-1.535000,10.681800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.739600,-1.535000,10.681900>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,90.000000,0> translate<8.739600,-1.535000,10.681900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.739600,-1.535000,10.681900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.009600,-1.535000,11.951800>}
box{<0,0,-0.203200><1.795981,0.035000,0.203200> rotate<0,-44.994774,0> translate<8.739600,-1.535000,10.681900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.788300,-1.535000,6.026600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.788300,-1.535000,6.673300>}
box{<0,0,-0.203200><0.646700,0.035000,0.203200> rotate<0,90.000000,0> translate<8.788300,-1.535000,6.673300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.788300,-1.535000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.578300,-1.535000,6.096000>}
box{<0,0,-0.203200><1.790000,0.035000,0.203200> rotate<0,0.000000,0> translate<8.788300,-1.535000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.788300,-1.535000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.984700,-1.535000,6.502400>}
box{<0,0,-0.203200><2.196400,0.035000,0.203200> rotate<0,0.000000,0> translate<8.788300,-1.535000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<8.884900,-1.535000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.686000,-1.535000,24.384000>}
box{<0,0,-0.203200><18.801100,0.035000,0.203200> rotate<0,0.000000,0> translate<8.884900,-1.535000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.030500,-1.535000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.357700,-1.535000,10.972800>}
box{<0,0,-0.203200><2.327200,0.035000,0.203200> rotate<0,0.000000,0> translate<9.030500,-1.535000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.059200,-1.535000,26.241500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.232800,-1.535000,26.068000>}
box{<0,0,-0.203200><0.245437,0.035000,0.203200> rotate<0,44.980524,0> translate<9.059200,-1.535000,26.241500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.059200,-1.535000,26.241500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.437000,-1.535000,26.619200>}
box{<0,0,-0.203200><0.534219,0.035000,0.203200> rotate<0,-44.989447,0> translate<9.059200,-1.535000,26.241500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.232800,-1.535000,24.731900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.232800,-1.535000,26.068000>}
box{<0,0,-0.203200><1.336100,0.035000,0.203200> rotate<0,90.000000,0> translate<9.232800,-1.535000,26.068000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.232800,-1.535000,24.790400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.715200,-1.535000,24.790400>}
box{<0,0,-0.203200><18.482400,0.035000,0.203200> rotate<0,0.000000,0> translate<9.232800,-1.535000,24.790400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.232800,-1.535000,25.196800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.121600,-1.535000,25.196800>}
box{<0,0,-0.203200><18.888800,0.035000,0.203200> rotate<0,0.000000,0> translate<9.232800,-1.535000,25.196800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.232800,-1.535000,25.603200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.528000,-1.535000,25.603200>}
box{<0,0,-0.203200><19.295200,0.035000,0.203200> rotate<0,0.000000,0> translate<9.232800,-1.535000,25.603200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.232800,-1.535000,26.009600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.843900,-1.535000,26.009600>}
box{<0,0,-0.203200><7.611100,0.035000,0.203200> rotate<0,0.000000,0> translate<9.232800,-1.535000,26.009600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.233700,-1.535000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.068700,-1.535000,26.416000>}
box{<0,0,-0.203200><2.835000,0.035000,0.203200> rotate<0,0.000000,0> translate<9.233700,-1.535000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.411800,-1.535000,21.439600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.897200,-1.535000,21.640700>}
box{<0,0,-0.203200><0.525409,0.035000,0.203200> rotate<0,-22.502619,0> translate<9.411800,-1.535000,21.439600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.436900,-1.535000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.379200,-1.535000,11.379200>}
box{<0,0,-0.203200><1.942300,0.035000,0.203200> rotate<0,0.000000,0> translate<9.436900,-1.535000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.437000,-1.535000,26.619200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.865600,-1.535000,26.619200>}
box{<0,0,-0.203200><2.428600,0.035000,0.203200> rotate<0,0.000000,0> translate<9.437000,-1.535000,26.619200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.843300,-1.535000,11.785600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.379200,-1.535000,11.785600>}
box{<0,0,-0.203200><1.535900,0.035000,0.203200> rotate<0,0.000000,0> translate<9.843300,-1.535000,11.785600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.897200,-1.535000,21.640700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.422700,-1.535000,21.640700>}
box{<0,0,-0.203200><0.525500,0.035000,0.203200> rotate<0,0.000000,0> translate<9.897200,-1.535000,21.640700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.906000,-1.535000,3.178700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.798700,-1.535000,2.286000>}
box{<0,0,-0.203200><1.262468,0.035000,0.203200> rotate<0,44.997030,0> translate<9.906000,-1.535000,3.178700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.906000,-1.535000,4.441200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.906000,-1.535000,3.178700>}
box{<0,0,-0.203200><1.262500,0.035000,0.203200> rotate<0,-90.000000,0> translate<9.906000,-1.535000,3.178700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<9.906000,-1.535000,4.441200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.109200,-1.535000,4.644300>}
box{<0,0,-0.203200><0.287297,0.035000,0.203200> rotate<0,-44.982929,0> translate<9.906000,-1.535000,4.441200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.009600,-1.535000,11.951800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.210700,-1.535000,12.437200>}
box{<0,0,-0.203200><0.525409,0.035000,0.203200> rotate<0,-67.491441,0> translate<10.009600,-1.535000,11.951800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.109100,-1.535000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.379200,-1.535000,12.192000>}
box{<0,0,-0.203200><1.270100,0.035000,0.203200> rotate<0,0.000000,0> translate<10.109100,-1.535000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.109200,-1.535000,4.817200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.109200,-1.535000,4.644300>}
box{<0,0,-0.203200><0.172900,0.035000,0.203200> rotate<0,-90.000000,0> translate<10.109200,-1.535000,4.644300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.109200,-1.535000,5.342700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.109200,-1.535000,4.817200>}
box{<0,0,-0.203200><0.525500,0.035000,0.203200> rotate<0,-90.000000,0> translate<10.109200,-1.535000,4.817200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.109200,-1.535000,5.342700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.310300,-1.535000,5.828100>}
box{<0,0,-0.203200><0.525409,0.035000,0.203200> rotate<0,-67.491441,0> translate<10.109200,-1.535000,5.342700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.210700,-1.535000,12.437200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.210700,-1.535000,12.962700>}
box{<0,0,-0.203200><0.525500,0.035000,0.203200> rotate<0,90.000000,0> translate<10.210700,-1.535000,12.962700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.210700,-1.535000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.379200,-1.535000,12.598400>}
box{<0,0,-0.203200><1.168500,0.035000,0.203200> rotate<0,0.000000,0> translate<10.210700,-1.535000,12.598400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.210700,-1.535000,12.962700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.210700,-1.535000,18.502900>}
box{<0,0,-0.203200><5.540200,0.035000,0.203200> rotate<0,90.000000,0> translate<10.210700,-1.535000,18.502900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.210700,-1.535000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.379200,-1.535000,13.004800>}
box{<0,0,-0.203200><1.168500,0.035000,0.203200> rotate<0,0.000000,0> translate<10.210700,-1.535000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.210700,-1.535000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.379200,-1.535000,13.411200>}
box{<0,0,-0.203200><1.168500,0.035000,0.203200> rotate<0,0.000000,0> translate<10.210700,-1.535000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.210700,-1.535000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.379200,-1.535000,13.817600>}
box{<0,0,-0.203200><1.168500,0.035000,0.203200> rotate<0,0.000000,0> translate<10.210700,-1.535000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.210700,-1.535000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.379200,-1.535000,14.224000>}
box{<0,0,-0.203200><1.168500,0.035000,0.203200> rotate<0,0.000000,0> translate<10.210700,-1.535000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.210700,-1.535000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.379200,-1.535000,14.630400>}
box{<0,0,-0.203200><1.168500,0.035000,0.203200> rotate<0,0.000000,0> translate<10.210700,-1.535000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.210700,-1.535000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.379200,-1.535000,15.036800>}
box{<0,0,-0.203200><1.168500,0.035000,0.203200> rotate<0,0.000000,0> translate<10.210700,-1.535000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.210700,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.379200,-1.535000,15.443200>}
box{<0,0,-0.203200><1.168500,0.035000,0.203200> rotate<0,0.000000,0> translate<10.210700,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.210700,-1.535000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.379200,-1.535000,15.849600>}
box{<0,0,-0.203200><1.168500,0.035000,0.203200> rotate<0,0.000000,0> translate<10.210700,-1.535000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.210700,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.379200,-1.535000,16.256000>}
box{<0,0,-0.203200><1.168500,0.035000,0.203200> rotate<0,0.000000,0> translate<10.210700,-1.535000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.210700,-1.535000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.379200,-1.535000,16.662400>}
box{<0,0,-0.203200><1.168500,0.035000,0.203200> rotate<0,0.000000,0> translate<10.210700,-1.535000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.210700,-1.535000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.255900,-1.535000,17.068800>}
box{<0,0,-0.203200><1.045200,0.035000,0.203200> rotate<0,0.000000,0> translate<10.210700,-1.535000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.210700,-1.535000,17.475200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.176000,-1.535000,17.475200>}
box{<0,0,-0.203200><0.965300,0.035000,0.203200> rotate<0,0.000000,0> translate<10.210700,-1.535000,17.475200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.210700,-1.535000,17.881600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.176000,-1.535000,17.881600>}
box{<0,0,-0.203200><0.965300,0.035000,0.203200> rotate<0,0.000000,0> translate<10.210700,-1.535000,17.881600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.210700,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.176000,-1.535000,18.288000>}
box{<0,0,-0.203200><0.965300,0.035000,0.203200> rotate<0,0.000000,0> translate<10.210700,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.210700,-1.535000,18.502900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.707000,-1.535000,18.999200>}
box{<0,0,-0.203200><0.701874,0.035000,0.203200> rotate<0,-44.997030,0> translate<10.210700,-1.535000,18.502900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.310300,-1.535000,5.828100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.446000,-1.535000,7.963700>}
box{<0,0,-0.203200><3.020265,0.035000,0.203200> rotate<0,-44.995689,0> translate<10.310300,-1.535000,5.828100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.402200,-1.535000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.459300,-1.535000,18.694400>}
box{<0,0,-0.203200><1.057100,0.035000,0.203200> rotate<0,0.000000,0> translate<10.402200,-1.535000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.422700,-1.535000,21.640700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.383000,-1.535000,21.640700>}
box{<0,0,-0.203200><5.960300,0.035000,0.203200> rotate<0,0.000000,0> translate<10.422700,-1.535000,21.640700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.707000,-1.535000,18.999200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.764100,-1.535000,18.999200>}
box{<0,0,-0.203200><1.057100,0.035000,0.203200> rotate<0,0.000000,0> translate<10.707000,-1.535000,18.999200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.798700,-1.535000,2.286000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.061200,-1.535000,2.286000>}
box{<0,0,-0.203200><1.262500,0.035000,0.203200> rotate<0,0.000000,0> translate<10.798700,-1.535000,2.286000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.882900,-1.535000,10.210700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.176000,-1.535000,10.503800>}
box{<0,0,-0.203200><0.414506,0.035000,0.203200> rotate<0,-44.997030,0> translate<10.882900,-1.535000,10.210700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.167200,-1.535000,7.569200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.692700,-1.535000,7.569200>}
box{<0,0,-0.203200><0.525500,0.035000,0.203200> rotate<0,0.000000,0> translate<11.167200,-1.535000,7.569200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.176000,-1.535000,10.791200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.176000,-1.535000,10.503800>}
box{<0,0,-0.203200><0.287400,0.035000,0.203200> rotate<0,-90.000000,0> translate<11.176000,-1.535000,10.503800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.176000,-1.535000,10.791200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.379200,-1.535000,10.994300>}
box{<0,0,-0.203200><0.287297,0.035000,0.203200> rotate<0,-44.982929,0> translate<11.176000,-1.535000,10.791200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.176000,-1.535000,17.148700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.379200,-1.535000,16.945600>}
box{<0,0,-0.203200><0.287297,0.035000,0.203200> rotate<0,44.982929,0> translate<11.176000,-1.535000,17.148700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.176000,-1.535000,18.411200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.176000,-1.535000,17.148700>}
box{<0,0,-0.203200><1.262500,0.035000,0.203200> rotate<0,-90.000000,0> translate<11.176000,-1.535000,17.148700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.176000,-1.535000,18.411200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.764100,-1.535000,18.999200>}
box{<0,0,-0.203200><0.831628,0.035000,0.203200> rotate<0,-44.992159,0> translate<11.176000,-1.535000,18.411200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.379200,-1.535000,16.945600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.379200,-1.535000,10.994300>}
box{<0,0,-0.203200><5.951300,0.035000,0.203200> rotate<0,-90.000000,0> translate<11.379200,-1.535000,10.994300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.692700,-1.535000,7.569200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.178100,-1.535000,7.770300>}
box{<0,0,-0.203200><0.525409,0.035000,0.203200> rotate<0,-22.502619,0> translate<11.692700,-1.535000,7.569200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.865600,-1.535000,26.619200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.068700,-1.535000,26.416000>}
box{<0,0,-0.203200><0.287297,0.035000,0.203200> rotate<0,45.011131,0> translate<11.865600,-1.535000,26.619200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<11.865600,-1.535000,29.260700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.068700,-1.535000,29.463900>}
box{<0,0,-0.203200><0.287297,0.035000,0.203200> rotate<0,-45.011131,0> translate<11.865600,-1.535000,29.260700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.060500,-1.535000,7.721600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.203900,-1.535000,7.721600>}
box{<0,0,-0.203200><0.143400,0.035000,0.203200> rotate<0,0.000000,0> translate<12.060500,-1.535000,7.721600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.061200,-1.535000,2.286000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.953900,-1.535000,3.178700>}
box{<0,0,-0.203200><1.262468,0.035000,0.203200> rotate<0,-44.997030,0> translate<12.061200,-1.535000,2.286000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.068700,-1.535000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.331200,-1.535000,26.416000>}
box{<0,0,-0.203200><1.262500,0.035000,0.203200> rotate<0,0.000000,0> translate<12.068700,-1.535000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.068700,-1.535000,29.463900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.331200,-1.535000,29.463900>}
box{<0,0,-0.203200><1.262500,0.035000,0.203200> rotate<0,0.000000,0> translate<12.068700,-1.535000,29.463900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.178100,-1.535000,7.770300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.446000,-1.535000,8.038300>}
box{<0,0,-0.203200><0.378939,0.035000,0.203200> rotate<0,-45.007721,0> translate<12.178100,-1.535000,7.770300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.213600,-1.535000,2.438400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.806300,-1.535000,2.438400>}
box{<0,0,-0.203200><8.592700,0.035000,0.203200> rotate<0,0.000000,0> translate<12.213600,-1.535000,2.438400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.446000,-1.535000,8.038300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.446000,-1.535000,7.963700>}
box{<0,0,-0.203200><0.074600,0.035000,0.203200> rotate<0,-90.000000,0> translate<12.446000,-1.535000,7.963700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.620000,-1.535000,2.844800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.399900,-1.535000,2.844800>}
box{<0,0,-0.203200><7.779900,0.035000,0.203200> rotate<0,0.000000,0> translate<12.620000,-1.535000,2.844800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.806400,-1.535000,4.588600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.953900,-1.535000,4.441200>}
box{<0,0,-0.203200><0.208526,0.035000,0.203200> rotate<0,44.977603,0> translate<12.806400,-1.535000,4.588600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.806400,-1.535000,4.588600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.718100,-1.535000,6.500300>}
box{<0,0,-0.203200><2.703552,0.035000,0.203200> rotate<0,-44.997030,0> translate<12.806400,-1.535000,4.588600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.924700,-1.535000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.095200,-1.535000,4.470400>}
box{<0,0,-0.203200><7.170500,0.035000,0.203200> rotate<0,0.000000,0> translate<12.924700,-1.535000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.953900,-1.535000,3.178700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.953900,-1.535000,4.441200>}
box{<0,0,-0.203200><1.262500,0.035000,0.203200> rotate<0,90.000000,0> translate<12.953900,-1.535000,4.441200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.953900,-1.535000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.066000,-1.535000,3.251200>}
box{<0,0,-0.203200><7.112100,0.035000,0.203200> rotate<0,0.000000,0> translate<12.953900,-1.535000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.953900,-1.535000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.066000,-1.535000,3.657600>}
box{<0,0,-0.203200><7.112100,0.035000,0.203200> rotate<0,0.000000,0> translate<12.953900,-1.535000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<12.953900,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.066000,-1.535000,4.064000>}
box{<0,0,-0.203200><7.112100,0.035000,0.203200> rotate<0,0.000000,0> translate<12.953900,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.094600,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.501600,-1.535000,4.876800>}
box{<0,0,-0.203200><7.407000,0.035000,0.203200> rotate<0,0.000000,0> translate<13.094600,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.331200,-1.535000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.534300,-1.535000,26.619200>}
box{<0,0,-0.203200><0.287297,0.035000,0.203200> rotate<0,-45.011131,0> translate<13.331200,-1.535000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.331200,-1.535000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.467000,-1.535000,26.416000>}
box{<0,0,-0.203200><3.135800,0.035000,0.203200> rotate<0,0.000000,0> translate<13.331200,-1.535000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.331200,-1.535000,29.463900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.534300,-1.535000,29.260700>}
box{<0,0,-0.203200><0.287297,0.035000,0.203200> rotate<0,45.011131,0> translate<13.331200,-1.535000,29.463900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.501000,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.908000,-1.535000,5.283200>}
box{<0,0,-0.203200><7.407000,0.035000,0.203200> rotate<0,0.000000,0> translate<13.501000,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.534300,-1.535000,26.619200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.382900,-1.535000,26.619200>}
box{<0,0,-0.203200><2.848600,0.035000,0.203200> rotate<0,0.000000,0> translate<13.534300,-1.535000,26.619200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.534300,-1.535000,29.260700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.382900,-1.535000,29.260700>}
box{<0,0,-0.203200><2.848600,0.035000,0.203200> rotate<0,0.000000,0> translate<13.534300,-1.535000,29.260700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.534300,-1.535000,29.260800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.383000,-1.535000,29.260800>}
box{<0,0,-0.203200><2.848700,0.035000,0.203200> rotate<0,0.000000,0> translate<13.534300,-1.535000,29.260800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.635800,-1.535000,18.999200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.223900,-1.535000,18.411200>}
box{<0,0,-0.203200><0.831628,0.035000,0.203200> rotate<0,44.992159,0> translate<13.635800,-1.535000,18.999200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.635800,-1.535000,18.999200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.383000,-1.535000,18.999200>}
box{<0,0,-0.203200><2.747200,0.035000,0.203200> rotate<0,0.000000,0> translate<13.635800,-1.535000,18.999200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.907400,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.601800,-1.535000,5.689600>}
box{<0,0,-0.203200><7.694400,0.035000,0.203200> rotate<0,0.000000,0> translate<13.907400,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<13.940700,-1.535000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.459200,-1.535000,18.694400>}
box{<0,0,-0.203200><2.518500,0.035000,0.203200> rotate<0,0.000000,0> translate<13.940700,-1.535000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.020700,-1.535000,11.095800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.020700,-1.535000,16.945600>}
box{<0,0,-0.203200><5.849800,0.035000,0.203200> rotate<0,90.000000,0> translate<14.020700,-1.535000,16.945600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.020700,-1.535000,11.095800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.608700,-1.535000,11.683900>}
box{<0,0,-0.203200><0.831628,0.035000,0.203200> rotate<0,-45.001902,0> translate<14.020700,-1.535000,11.095800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.020700,-1.535000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.304100,-1.535000,11.379200>}
box{<0,0,-0.203200><0.283400,0.035000,0.203200> rotate<0,0.000000,0> translate<14.020700,-1.535000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.020700,-1.535000,11.785600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.347800,-1.535000,11.785600>}
box{<0,0,-0.203200><7.327100,0.035000,0.203200> rotate<0,0.000000,0> translate<14.020700,-1.535000,11.785600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.020700,-1.535000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.754200,-1.535000,12.192000>}
box{<0,0,-0.203200><7.733500,0.035000,0.203200> rotate<0,0.000000,0> translate<14.020700,-1.535000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.020700,-1.535000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.160600,-1.535000,12.598400>}
box{<0,0,-0.203200><8.139900,0.035000,0.203200> rotate<0,0.000000,0> translate<14.020700,-1.535000,12.598400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.020700,-1.535000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.567000,-1.535000,13.004800>}
box{<0,0,-0.203200><8.546300,0.035000,0.203200> rotate<0,0.000000,0> translate<14.020700,-1.535000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.020700,-1.535000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.973400,-1.535000,13.411200>}
box{<0,0,-0.203200><8.952700,0.035000,0.203200> rotate<0,0.000000,0> translate<14.020700,-1.535000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.020700,-1.535000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.379800,-1.535000,13.817600>}
box{<0,0,-0.203200><9.359100,0.035000,0.203200> rotate<0,0.000000,0> translate<14.020700,-1.535000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.020700,-1.535000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.798800,-1.535000,14.224000>}
box{<0,0,-0.203200><27.778100,0.035000,0.203200> rotate<0,0.000000,0> translate<14.020700,-1.535000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.020700,-1.535000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.399200,-1.535000,14.630400>}
box{<0,0,-0.203200><30.378500,0.035000,0.203200> rotate<0,0.000000,0> translate<14.020700,-1.535000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.020700,-1.535000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.827900,-1.535000,15.036800>}
box{<0,0,-0.203200><1.807200,0.035000,0.203200> rotate<0,0.000000,0> translate<14.020700,-1.535000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.020700,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.421500,-1.535000,15.443200>}
box{<0,0,-0.203200><1.400800,0.035000,0.203200> rotate<0,0.000000,0> translate<14.020700,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.020700,-1.535000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.015100,-1.535000,15.849600>}
box{<0,0,-0.203200><0.994400,0.035000,0.203200> rotate<0,0.000000,0> translate<14.020700,-1.535000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.020700,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.986000,-1.535000,16.256000>}
box{<0,0,-0.203200><0.965300,0.035000,0.203200> rotate<0,0.000000,0> translate<14.020700,-1.535000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.020700,-1.535000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.986000,-1.535000,16.662400>}
box{<0,0,-0.203200><0.965300,0.035000,0.203200> rotate<0,0.000000,0> translate<14.020700,-1.535000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.020700,-1.535000,16.945600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.223900,-1.535000,17.148700>}
box{<0,0,-0.203200><0.287297,0.035000,0.203200> rotate<0,-44.982929,0> translate<14.020700,-1.535000,16.945600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.143900,-1.535000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.986000,-1.535000,17.068800>}
box{<0,0,-0.203200><0.842100,0.035000,0.203200> rotate<0,0.000000,0> translate<14.143900,-1.535000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.223900,-1.535000,17.148700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.223900,-1.535000,18.411200>}
box{<0,0,-0.203200><1.262500,0.035000,0.203200> rotate<0,90.000000,0> translate<14.223900,-1.535000,18.411200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.223900,-1.535000,17.475200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.320000,-1.535000,17.475200>}
box{<0,0,-0.203200><1.096100,0.035000,0.203200> rotate<0,0.000000,0> translate<14.223900,-1.535000,17.475200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.223900,-1.535000,17.881600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.726400,-1.535000,17.881600>}
box{<0,0,-0.203200><1.502500,0.035000,0.203200> rotate<0,0.000000,0> translate<14.223900,-1.535000,17.881600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.223900,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.420300,-1.535000,18.288000>}
box{<0,0,-0.203200><2.196400,0.035000,0.203200> rotate<0,0.000000,0> translate<14.223900,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.313800,-1.535000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.008200,-1.535000,6.096000>}
box{<0,0,-0.203200><7.694400,0.035000,0.203200> rotate<0,0.000000,0> translate<14.313800,-1.535000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.608700,-1.535000,11.683900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.871200,-1.535000,11.683900>}
box{<0,0,-0.203200><1.262500,0.035000,0.203200> rotate<0,0.000000,0> translate<14.608700,-1.535000,11.683900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.718100,-1.535000,6.500300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.089600,-1.535000,6.871800>}
box{<0,0,-0.203200><0.525380,0.035000,0.203200> rotate<0,-44.997030,0> translate<14.718100,-1.535000,6.500300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.720200,-1.535000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.414600,-1.535000,6.502400>}
box{<0,0,-0.203200><7.694400,0.035000,0.203200> rotate<0,0.000000,0> translate<14.720200,-1.535000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.986000,-1.535000,15.878700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.878700,-1.535000,14.986000>}
box{<0,0,-0.203200><1.262468,0.035000,0.203200> rotate<0,44.997030,0> translate<14.986000,-1.535000,15.878700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.986000,-1.535000,17.141200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.986000,-1.535000,15.878700>}
box{<0,0,-0.203200><1.262500,0.035000,0.203200> rotate<0,-90.000000,0> translate<14.986000,-1.535000,15.878700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<14.986000,-1.535000,17.141200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.878700,-1.535000,18.033900>}
box{<0,0,-0.203200><1.262468,0.035000,0.203200> rotate<0,-44.997030,0> translate<14.986000,-1.535000,17.141200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.089600,-1.535000,6.871800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.290700,-1.535000,7.357200>}
box{<0,0,-0.203200><0.525409,0.035000,0.203200> rotate<0,-67.491441,0> translate<15.089600,-1.535000,6.871800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.104900,-1.535000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.821000,-1.535000,6.908800>}
box{<0,0,-0.203200><7.716100,0.035000,0.203200> rotate<0,0.000000,0> translate<15.104900,-1.535000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.273200,-1.535000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.227400,-1.535000,7.315200>}
box{<0,0,-0.203200><7.954200,0.035000,0.203200> rotate<0,0.000000,0> translate<15.273200,-1.535000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.290700,-1.535000,7.357200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.290700,-1.535000,7.420500>}
box{<0,0,-0.203200><0.063300,0.035000,0.203200> rotate<0,90.000000,0> translate<15.290700,-1.535000,7.420500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.290700,-1.535000,7.420500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.493900,-1.535000,7.623700>}
box{<0,0,-0.203200><0.287368,0.035000,0.203200> rotate<0,-44.997030,0> translate<15.290700,-1.535000,7.420500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.493900,-1.535000,7.623700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.493900,-1.535000,8.636000>}
box{<0,0,-0.203200><1.012300,0.035000,0.203200> rotate<0,90.000000,0> translate<15.493900,-1.535000,8.636000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.493900,-1.535000,7.721600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.633800,-1.535000,7.721600>}
box{<0,0,-0.203200><8.139900,0.035000,0.203200> rotate<0,0.000000,0> translate<15.493900,-1.535000,7.721600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.493900,-1.535000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.040200,-1.535000,8.128000>}
box{<0,0,-0.203200><8.546300,0.035000,0.203200> rotate<0,0.000000,0> translate<15.493900,-1.535000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.493900,-1.535000,8.534400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.446600,-1.535000,8.534400>}
box{<0,0,-0.203200><8.952700,0.035000,0.203200> rotate<0,0.000000,0> translate<15.493900,-1.535000,8.534400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.493900,-1.535000,8.636000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.871200,-1.535000,8.636000>}
box{<0,0,-0.203200><0.377300,0.035000,0.203200> rotate<0,0.000000,0> translate<15.493900,-1.535000,8.636000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.871200,-1.535000,8.636000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.074400,-1.535000,8.839200>}
box{<0,0,-0.203200><0.287368,0.035000,0.203200> rotate<0,-44.997030,0> translate<15.871200,-1.535000,8.636000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.871200,-1.535000,11.683900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.074400,-1.535000,11.480700>}
box{<0,0,-0.203200><0.287368,0.035000,0.203200> rotate<0,44.997030,0> translate<15.871200,-1.535000,11.683900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.878700,-1.535000,14.986000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.141200,-1.535000,14.986000>}
box{<0,0,-0.203200><1.262500,0.035000,0.203200> rotate<0,0.000000,0> translate<15.878700,-1.535000,14.986000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<15.878700,-1.535000,18.033900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.166200,-1.535000,18.033900>}
box{<0,0,-0.203200><0.287500,0.035000,0.203200> rotate<0,0.000000,0> translate<15.878700,-1.535000,18.033900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.074400,-1.535000,8.839200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.327200,-1.535000,8.839200>}
box{<0,0,-0.203200><5.252800,0.035000,0.203200> rotate<0,0.000000,0> translate<16.074400,-1.535000,8.839200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.074400,-1.535000,11.480700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.042900,-1.535000,11.480700>}
box{<0,0,-0.203200><4.968500,0.035000,0.203200> rotate<0,0.000000,0> translate<16.074400,-1.535000,11.480700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.166200,-1.535000,18.033900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.459200,-1.535000,18.327000>}
box{<0,0,-0.203200><0.414435,0.035000,0.203200> rotate<0,-45.006805,0> translate<16.166200,-1.535000,18.033900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.382900,-1.535000,26.619200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.488000,-1.535000,26.365500>}
box{<0,0,-0.203200><0.274608,0.035000,0.203200> rotate<0,67.492843,0> translate<16.382900,-1.535000,26.619200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.382900,-1.535000,29.260700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.488000,-1.535000,29.514400>}
box{<0,0,-0.203200><0.274608,0.035000,0.203200> rotate<0,-67.492843,0> translate<16.382900,-1.535000,29.260700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.383000,-1.535000,18.999200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.459200,-1.535000,18.815000>}
box{<0,0,-0.203200><0.199339,0.035000,0.203200> rotate<0,67.521604,0> translate<16.383000,-1.535000,18.999200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.383000,-1.535000,21.640700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.488000,-1.535000,21.894400>}
box{<0,0,-0.203200><0.274570,0.035000,0.203200> rotate<0,-67.512120,0> translate<16.383000,-1.535000,21.640700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.459200,-1.535000,18.815000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.459200,-1.535000,18.327000>}
box{<0,0,-0.203200><0.488000,0.035000,0.203200> rotate<0,-90.000000,0> translate<16.459200,-1.535000,18.327000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.488000,-1.535000,21.894400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.916700,-1.535000,22.323100>}
box{<0,0,-0.203200><0.606273,0.035000,0.203200> rotate<0,-44.997030,0> translate<16.488000,-1.535000,21.894400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.488000,-1.535000,26.365500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.916700,-1.535000,25.936800>}
box{<0,0,-0.203200><0.606273,0.035000,0.203200> rotate<0,44.997030,0> translate<16.488000,-1.535000,26.365500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.488000,-1.535000,29.514400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.916700,-1.535000,29.943100>}
box{<0,0,-0.203200><0.606273,0.035000,0.203200> rotate<0,-44.997030,0> translate<16.488000,-1.535000,29.514400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.916700,-1.535000,22.323100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.476800,-1.535000,22.555100>}
box{<0,0,-0.203200><0.606247,0.035000,0.203200> rotate<0,-22.498426,0> translate<16.916700,-1.535000,22.323100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.916700,-1.535000,25.936800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.476800,-1.535000,25.704800>}
box{<0,0,-0.203200><0.606247,0.035000,0.203200> rotate<0,22.498426,0> translate<16.916700,-1.535000,25.936800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<16.916700,-1.535000,29.943100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.476800,-1.535000,30.175100>}
box{<0,0,-0.203200><0.606247,0.035000,0.203200> rotate<0,-22.498426,0> translate<16.916700,-1.535000,29.943100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.141200,-1.535000,14.986000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.033900,-1.535000,15.878700>}
box{<0,0,-0.203200><1.262468,0.035000,0.203200> rotate<0,-44.997030,0> translate<17.141200,-1.535000,14.986000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.192000,-1.535000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.987900,-1.535000,15.036800>}
box{<0,0,-0.203200><8.795900,0.035000,0.203200> rotate<0,0.000000,0> translate<17.192000,-1.535000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.476800,-1.535000,22.555100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.083100,-1.535000,22.555100>}
box{<0,0,-0.203200><0.606300,0.035000,0.203200> rotate<0,0.000000,0> translate<17.476800,-1.535000,22.555100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.476800,-1.535000,25.704800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.083100,-1.535000,25.704800>}
box{<0,0,-0.203200><0.606300,0.035000,0.203200> rotate<0,0.000000,0> translate<17.476800,-1.535000,25.704800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.476800,-1.535000,30.175100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.083100,-1.535000,30.175100>}
box{<0,0,-0.203200><0.606300,0.035000,0.203200> rotate<0,0.000000,0> translate<17.476800,-1.535000,30.175100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<17.598400,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.581500,-1.535000,15.443200>}
box{<0,0,-0.203200><7.983100,0.035000,0.203200> rotate<0,0.000000,0> translate<17.598400,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.004800,-1.535000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.175100,-1.535000,15.849600>}
box{<0,0,-0.203200><7.170300,0.035000,0.203200> rotate<0,0.000000,0> translate<18.004800,-1.535000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.033900,-1.535000,15.878700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.033900,-1.535000,16.166200>}
box{<0,0,-0.203200><0.287500,0.035000,0.203200> rotate<0,90.000000,0> translate<18.033900,-1.535000,16.166200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.033900,-1.535000,16.166200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.528100,-1.535000,16.660300>}
box{<0,0,-0.203200><0.698834,0.035000,0.203200> rotate<0,-44.991233,0> translate<18.033900,-1.535000,16.166200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.083100,-1.535000,22.555100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.643200,-1.535000,22.323100>}
box{<0,0,-0.203200><0.606247,0.035000,0.203200> rotate<0,22.498426,0> translate<18.083100,-1.535000,22.555100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.083100,-1.535000,25.704800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.643200,-1.535000,25.936800>}
box{<0,0,-0.203200><0.606247,0.035000,0.203200> rotate<0,-22.498426,0> translate<18.083100,-1.535000,25.704800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.083100,-1.535000,30.175100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.643200,-1.535000,29.943100>}
box{<0,0,-0.203200><0.606247,0.035000,0.203200> rotate<0,22.498426,0> translate<18.083100,-1.535000,30.175100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.123700,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.056100,-1.535000,16.256000>}
box{<0,0,-0.203200><6.932400,0.035000,0.203200> rotate<0,0.000000,0> translate<18.123700,-1.535000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.328200,-1.535000,30.073600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,30.073600>}
box{<0,0,-0.203200><30.389000,0.035000,0.203200> rotate<0,0.000000,0> translate<18.328200,-1.535000,30.073600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.528100,-1.535000,16.660300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.899600,-1.535000,17.031800>}
box{<0,0,-0.203200><0.525380,0.035000,0.203200> rotate<0,-44.997030,0> translate<18.528100,-1.535000,16.660300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.530200,-1.535000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.649700,-1.535000,16.662400>}
box{<0,0,-0.203200><6.119500,0.035000,0.203200> rotate<0,0.000000,0> translate<18.530200,-1.535000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.573500,-1.535000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.024300,-1.535000,22.352000>}
box{<0,0,-0.203200><4.450800,0.035000,0.203200> rotate<0,0.000000,0> translate<18.573500,-1.535000,22.352000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.643200,-1.535000,22.323100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.071900,-1.535000,21.894400>}
box{<0,0,-0.203200><0.606273,0.035000,0.203200> rotate<0,44.997030,0> translate<18.643200,-1.535000,22.323100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.643200,-1.535000,25.936800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.071900,-1.535000,26.365500>}
box{<0,0,-0.203200><0.606273,0.035000,0.203200> rotate<0,-44.997030,0> translate<18.643200,-1.535000,25.936800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.643200,-1.535000,29.943100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.071900,-1.535000,29.514400>}
box{<0,0,-0.203200><0.606273,0.035000,0.203200> rotate<0,44.997030,0> translate<18.643200,-1.535000,29.943100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.716000,-1.535000,26.009600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.761900,-1.535000,26.009600>}
box{<0,0,-0.203200><13.045900,0.035000,0.203200> rotate<0,0.000000,0> translate<18.716000,-1.535000,26.009600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.899600,-1.535000,17.031800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.100700,-1.535000,17.517200>}
box{<0,0,-0.203200><0.525409,0.035000,0.203200> rotate<0,-67.491441,0> translate<18.899600,-1.535000,17.031800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.914900,-1.535000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.243300,-1.535000,17.068800>}
box{<0,0,-0.203200><5.328400,0.035000,0.203200> rotate<0,0.000000,0> translate<18.914900,-1.535000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<18.919100,-1.535000,29.667200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,29.667200>}
box{<0,0,-0.203200><29.798100,0.035000,0.203200> rotate<0,0.000000,0> translate<18.919100,-1.535000,29.667200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.020700,-1.535000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.847700,-1.535000,21.945600>}
box{<0,0,-0.203200><3.827000,0.035000,0.203200> rotate<0,0.000000,0> translate<19.020700,-1.535000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.071900,-1.535000,21.894400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.303900,-1.535000,21.334300>}
box{<0,0,-0.203200><0.606247,0.035000,0.203200> rotate<0,67.495634,0> translate<19.071900,-1.535000,21.894400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.071900,-1.535000,26.365500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.303900,-1.535000,26.925600>}
box{<0,0,-0.203200><0.606247,0.035000,0.203200> rotate<0,-67.495634,0> translate<19.071900,-1.535000,26.365500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.071900,-1.535000,29.514400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.303900,-1.535000,28.954300>}
box{<0,0,-0.203200><0.606247,0.035000,0.203200> rotate<0,67.495634,0> translate<19.071900,-1.535000,29.514400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.083200,-1.535000,17.475200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.836900,-1.535000,17.475200>}
box{<0,0,-0.203200><4.753700,0.035000,0.203200> rotate<0,0.000000,0> translate<19.083200,-1.535000,17.475200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.092800,-1.535000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.168300,-1.535000,26.416000>}
box{<0,0,-0.203200><13.075500,0.035000,0.203200> rotate<0,0.000000,0> translate<19.092800,-1.535000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.100700,-1.535000,17.517200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.100700,-1.535000,18.815000>}
box{<0,0,-0.203200><1.297800,0.035000,0.203200> rotate<0,90.000000,0> translate<19.100700,-1.535000,18.815000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.100700,-1.535000,17.881600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.143100,-1.535000,17.881600>}
box{<0,0,-0.203200><4.042400,0.035000,0.203200> rotate<0,0.000000,0> translate<19.100700,-1.535000,17.881600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.100700,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.736700,-1.535000,18.288000>}
box{<0,0,-0.203200><3.636000,0.035000,0.203200> rotate<0,0.000000,0> translate<19.100700,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.100700,-1.535000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.606000,-1.535000,18.694400>}
box{<0,0,-0.203200><3.505300,0.035000,0.203200> rotate<0,0.000000,0> translate<19.100700,-1.535000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.100700,-1.535000,18.815000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.303900,-1.535000,19.305600>}
box{<0,0,-0.203200><0.531017,0.035000,0.203200> rotate<0,-67.496858,0> translate<19.100700,-1.535000,18.815000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.177000,-1.535000,29.260800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,29.260800>}
box{<0,0,-0.203200><29.540200,0.035000,0.203200> rotate<0,0.000000,0> translate<19.177000,-1.535000,29.260800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.219000,-1.535000,19.100800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.606000,-1.535000,19.100800>}
box{<0,0,-0.203200><3.387000,0.035000,0.203200> rotate<0,0.000000,0> translate<19.219000,-1.535000,19.100800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.219100,-1.535000,21.539200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.809200,-1.535000,21.539200>}
box{<0,0,-0.203200><3.590100,0.035000,0.203200> rotate<0,0.000000,0> translate<19.219100,-1.535000,21.539200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.261100,-1.535000,26.822400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.574700,-1.535000,26.822400>}
box{<0,0,-0.203200><13.313600,0.035000,0.203200> rotate<0,0.000000,0> translate<19.261100,-1.535000,26.822400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.303900,-1.535000,19.305600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.303900,-1.535000,21.334300>}
box{<0,0,-0.203200><2.028700,0.035000,0.203200> rotate<0,90.000000,0> translate<19.303900,-1.535000,21.334300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.303900,-1.535000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.606000,-1.535000,19.507200>}
box{<0,0,-0.203200><3.302100,0.035000,0.203200> rotate<0,0.000000,0> translate<19.303900,-1.535000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.303900,-1.535000,19.913600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.809200,-1.535000,19.913600>}
box{<0,0,-0.203200><3.505300,0.035000,0.203200> rotate<0,0.000000,0> translate<19.303900,-1.535000,19.913600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.303900,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.809200,-1.535000,20.320000>}
box{<0,0,-0.203200><3.505300,0.035000,0.203200> rotate<0,0.000000,0> translate<19.303900,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.303900,-1.535000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.809200,-1.535000,20.726400>}
box{<0,0,-0.203200><3.505300,0.035000,0.203200> rotate<0,0.000000,0> translate<19.303900,-1.535000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.303900,-1.535000,21.132800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.809200,-1.535000,21.132800>}
box{<0,0,-0.203200><3.505300,0.035000,0.203200> rotate<0,0.000000,0> translate<19.303900,-1.535000,21.132800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.303900,-1.535000,26.925600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.303900,-1.535000,28.954300>}
box{<0,0,-0.203200><2.028700,0.035000,0.203200> rotate<0,90.000000,0> translate<19.303900,-1.535000,28.954300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.303900,-1.535000,27.228800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.766000,-1.535000,27.228800>}
box{<0,0,-0.203200><13.462100,0.035000,0.203200> rotate<0,0.000000,0> translate<19.303900,-1.535000,27.228800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.303900,-1.535000,27.635200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.100000,-1.535000,27.635200>}
box{<0,0,-0.203200><13.796100,0.035000,0.203200> rotate<0,0.000000,0> translate<19.303900,-1.535000,27.635200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.303900,-1.535000,28.041600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.506400,-1.535000,28.041600>}
box{<0,0,-0.203200><14.202500,0.035000,0.203200> rotate<0,0.000000,0> translate<19.303900,-1.535000,28.041600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.303900,-1.535000,28.448000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,28.448000>}
box{<0,0,-0.203200><29.413300,0.035000,0.203200> rotate<0,0.000000,0> translate<19.303900,-1.535000,28.448000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<19.303900,-1.535000,28.854400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,28.854400>}
box{<0,0,-0.203200><29.413300,0.035000,0.203200> rotate<0,0.000000,0> translate<19.303900,-1.535000,28.854400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.066000,-1.535000,3.178700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.958700,-1.535000,2.286000>}
box{<0,0,-0.203200><1.262468,0.035000,0.203200> rotate<0,44.997030,0> translate<20.066000,-1.535000,3.178700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.066000,-1.535000,4.441200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.066000,-1.535000,3.178700>}
box{<0,0,-0.203200><1.262500,0.035000,0.203200> rotate<0,-90.000000,0> translate<20.066000,-1.535000,3.178700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.066000,-1.535000,4.441200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.958700,-1.535000,5.333900>}
box{<0,0,-0.203200><1.262468,0.035000,0.203200> rotate<0,-44.997030,0> translate<20.066000,-1.535000,4.441200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.958700,-1.535000,2.286000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.221200,-1.535000,2.286000>}
box{<0,0,-0.203200><1.262500,0.035000,0.203200> rotate<0,0.000000,0> translate<20.958700,-1.535000,2.286000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<20.958700,-1.535000,5.333900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.246100,-1.535000,5.333900>}
box{<0,0,-0.203200><0.287400,0.035000,0.203200> rotate<0,0.000000,0> translate<20.958700,-1.535000,5.333900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.042900,-1.535000,11.480700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.010300,-1.535000,13.448100>}
box{<0,0,-0.203200><2.782324,0.035000,0.203200> rotate<0,-44.997030,0> translate<21.042900,-1.535000,11.480700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.246100,-1.535000,5.333900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.550300,-1.535000,9.638100>}
box{<0,0,-0.203200><6.087058,0.035000,0.203200> rotate<0,-44.997030,0> translate<21.246100,-1.535000,5.333900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.327200,-1.535000,8.839200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.852700,-1.535000,8.839200>}
box{<0,0,-0.203200><0.525500,0.035000,0.203200> rotate<0,0.000000,0> translate<21.327200,-1.535000,8.839200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<21.852700,-1.535000,8.839200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.338100,-1.535000,9.040300>}
box{<0,0,-0.203200><0.525409,0.035000,0.203200> rotate<0,-22.502619,0> translate<21.852700,-1.535000,8.839200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.097900,-1.535000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.853000,-1.535000,8.940800>}
box{<0,0,-0.203200><2.755100,0.035000,0.203200> rotate<0,0.000000,0> translate<22.097900,-1.535000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.221200,-1.535000,2.286000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.113900,-1.535000,3.178700>}
box{<0,0,-0.203200><1.262468,0.035000,0.203200> rotate<0,-44.997030,0> translate<22.221200,-1.535000,2.286000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.338100,-1.535000,9.040300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.621300,-1.535000,11.323500>}
box{<0,0,-0.203200><3.228932,0.035000,0.203200> rotate<0,-44.997030,0> translate<22.338100,-1.535000,9.040300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.373600,-1.535000,2.438400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.876000,-1.535000,2.438400>}
box{<0,0,-0.203200><1.502400,0.035000,0.203200> rotate<0,0.000000,0> translate<22.373600,-1.535000,2.438400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.606000,-1.535000,18.418700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.498700,-1.535000,17.526000>}
box{<0,0,-0.203200><1.262468,0.035000,0.203200> rotate<0,44.997030,0> translate<22.606000,-1.535000,18.418700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.606000,-1.535000,19.681200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.606000,-1.535000,18.418700>}
box{<0,0,-0.203200><1.262500,0.035000,0.203200> rotate<0,-90.000000,0> translate<22.606000,-1.535000,18.418700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.606000,-1.535000,19.681200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.809200,-1.535000,19.884400>}
box{<0,0,-0.203200><0.287368,0.035000,0.203200> rotate<0,-44.997030,0> translate<22.606000,-1.535000,19.681200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.645000,-1.535000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.259400,-1.535000,9.347200>}
box{<0,0,-0.203200><2.614400,0.035000,0.203200> rotate<0,0.000000,0> translate<22.645000,-1.535000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.780000,-1.535000,2.844800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.876000,-1.535000,2.844800>}
box{<0,0,-0.203200><1.096000,0.035000,0.203200> rotate<0,0.000000,0> translate<22.780000,-1.535000,2.844800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.809200,-1.535000,21.327200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.809200,-1.535000,19.884400>}
box{<0,0,-0.203200><1.442800,0.035000,0.203200> rotate<0,-90.000000,0> translate<22.809200,-1.535000,19.884400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.809200,-1.535000,21.852700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.809200,-1.535000,21.327200>}
box{<0,0,-0.203200><0.525500,0.035000,0.203200> rotate<0,-90.000000,0> translate<22.809200,-1.535000,21.327200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<22.809200,-1.535000,21.852700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.010300,-1.535000,22.338100>}
box{<0,0,-0.203200><0.525409,0.035000,0.203200> rotate<0,-67.491441,0> translate<22.809200,-1.535000,21.852700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.010300,-1.535000,13.448100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.381800,-1.535000,13.819600>}
box{<0,0,-0.203200><0.525380,0.035000,0.203200> rotate<0,-44.997030,0> translate<23.010300,-1.535000,13.448100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.010300,-1.535000,22.338100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.280300,-1.535000,23.608000>}
box{<0,0,-0.203200><1.795981,0.035000,0.203200> rotate<0,-44.994774,0> translate<23.010300,-1.535000,22.338100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.051400,-1.535000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.665800,-1.535000,9.753600>}
box{<0,0,-0.203200><2.614400,0.035000,0.203200> rotate<0,0.000000,0> translate<23.051400,-1.535000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.113900,-1.535000,3.178700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.113900,-1.535000,3.466100>}
box{<0,0,-0.203200><0.287400,0.035000,0.203200> rotate<0,90.000000,0> translate<23.113900,-1.535000,3.466100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.113900,-1.535000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.956000,-1.535000,3.251200>}
box{<0,0,-0.203200><0.842100,0.035000,0.203200> rotate<0,0.000000,0> translate<23.113900,-1.535000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.113900,-1.535000,3.466100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.217000,-1.535000,7.569200>}
box{<0,0,-0.203200><5.802660,0.035000,0.203200> rotate<0,-44.997030,0> translate<23.113900,-1.535000,3.466100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.305400,-1.535000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.362400,-1.535000,3.657600>}
box{<0,0,-0.203200><1.057000,0.035000,0.203200> rotate<0,0.000000,0> translate<23.305400,-1.535000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.381800,-1.535000,13.819600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.867200,-1.535000,14.020700>}
box{<0,0,-0.203200><0.525409,0.035000,0.203200> rotate<0,-22.502619,0> translate<23.381800,-1.535000,13.819600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.457800,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.284900,-1.535000,10.160000>}
box{<0,0,-0.203200><2.827100,0.035000,0.203200> rotate<0,0.000000,0> translate<23.457800,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.498700,-1.535000,17.526000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.786100,-1.535000,17.526000>}
box{<0,0,-0.203200><0.287400,0.035000,0.203200> rotate<0,0.000000,0> translate<23.498700,-1.535000,17.526000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.711800,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.406200,-1.535000,4.064000>}
box{<0,0,-0.203200><7.694400,0.035000,0.203200> rotate<0,0.000000,0> translate<23.711800,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.786100,-1.535000,17.526000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.146000,-1.535000,16.166100>}
box{<0,0,-0.203200><1.923189,0.035000,0.203200> rotate<0,44.997030,0> translate<23.786100,-1.535000,17.526000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.864200,-1.535000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.988700,-1.535000,10.566400>}
box{<0,0,-0.203200><19.124500,0.035000,0.203200> rotate<0,0.000000,0> translate<23.864200,-1.535000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.867200,-1.535000,14.020700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.565600,-1.535000,14.020700>}
box{<0,0,-0.203200><0.698400,0.035000,0.203200> rotate<0,0.000000,0> translate<23.867200,-1.535000,14.020700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.876000,-1.535000,1.908700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.768700,-1.535000,1.016000>}
box{<0,0,-0.203200><1.262468,0.035000,0.203200> rotate<0,44.997030,0> translate<23.876000,-1.535000,1.908700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.876000,-1.535000,3.171200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.876000,-1.535000,1.908700>}
box{<0,0,-0.203200><1.262500,0.035000,0.203200> rotate<0,-90.000000,0> translate<23.876000,-1.535000,1.908700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<23.876000,-1.535000,3.171200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.768700,-1.535000,4.063900>}
box{<0,0,-0.203200><1.262468,0.035000,0.203200> rotate<0,-44.997030,0> translate<23.876000,-1.535000,3.171200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.118200,-1.535000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.812600,-1.535000,4.470400>}
box{<0,0,-0.203200><7.694400,0.035000,0.203200> rotate<0,0.000000,0> translate<24.118200,-1.535000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.270600,-1.535000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.395100,-1.535000,10.972800>}
box{<0,0,-0.203200><19.124500,0.035000,0.203200> rotate<0,0.000000,0> translate<24.270600,-1.535000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.280300,-1.535000,23.608100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.280300,-1.535000,23.608000>}
box{<0,0,-0.203200><0.000100,0.035000,0.203200> rotate<0,-90.000000,0> translate<24.280300,-1.535000,23.608000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.280300,-1.535000,23.608100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.651800,-1.535000,23.979600>}
box{<0,0,-0.203200><0.525380,0.035000,0.203200> rotate<0,-44.997030,0> translate<24.280300,-1.535000,23.608100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.524600,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.219000,-1.535000,4.876800>}
box{<0,0,-0.203200><7.694400,0.035000,0.203200> rotate<0,0.000000,0> translate<24.524600,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.565600,-1.535000,14.020700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.768700,-1.535000,14.223900>}
box{<0,0,-0.203200><0.287297,0.035000,0.203200> rotate<0,-45.011131,0> translate<24.565600,-1.535000,14.020700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.621300,-1.535000,11.323500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.768700,-1.535000,11.176000>}
box{<0,0,-0.203200><0.208526,0.035000,0.203200> rotate<0,45.016458,0> translate<24.621300,-1.535000,11.323500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.651800,-1.535000,23.979600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.137200,-1.535000,24.180700>}
box{<0,0,-0.203200><0.525409,0.035000,0.203200> rotate<0,-22.502619,0> translate<24.651800,-1.535000,23.979600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.768700,-1.535000,1.016000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.031200,-1.535000,1.016000>}
box{<0,0,-0.203200><1.262500,0.035000,0.203200> rotate<0,0.000000,0> translate<24.768700,-1.535000,1.016000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.768700,-1.535000,4.063900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.031200,-1.535000,4.063900>}
box{<0,0,-0.203200><1.262500,0.035000,0.203200> rotate<0,0.000000,0> translate<24.768700,-1.535000,4.063900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.768700,-1.535000,11.176000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.031200,-1.535000,11.176000>}
box{<0,0,-0.203200><1.262500,0.035000,0.203200> rotate<0,0.000000,0> translate<24.768700,-1.535000,11.176000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.768700,-1.535000,14.223900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.031200,-1.535000,14.223900>}
box{<0,0,-0.203200><1.262500,0.035000,0.203200> rotate<0,0.000000,0> translate<24.768700,-1.535000,14.223900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<24.931000,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.625400,-1.535000,5.283200>}
box{<0,0,-0.203200><7.694400,0.035000,0.203200> rotate<0,0.000000,0> translate<24.931000,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.137200,-1.535000,24.180700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.470500,-1.535000,24.180700>}
box{<0,0,-0.203200><1.333300,0.035000,0.203200> rotate<0,0.000000,0> translate<25.137200,-1.535000,24.180700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.146000,-1.535000,15.878700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.038700,-1.535000,14.986000>}
box{<0,0,-0.203200><1.262468,0.035000,0.203200> rotate<0,44.997030,0> translate<25.146000,-1.535000,15.878700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.146000,-1.535000,16.166100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.146000,-1.535000,15.878700>}
box{<0,0,-0.203200><0.287400,0.035000,0.203200> rotate<0,-90.000000,0> translate<25.146000,-1.535000,15.878700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.337400,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.031800,-1.535000,5.689600>}
box{<0,0,-0.203200><7.694400,0.035000,0.203200> rotate<0,0.000000,0> translate<25.337400,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.450700,-1.535000,19.884400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.450700,-1.535000,21.042900>}
box{<0,0,-0.203200><1.158500,0.035000,0.203200> rotate<0,90.000000,0> translate<25.450700,-1.535000,21.042900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.450700,-1.535000,19.884400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.653900,-1.535000,19.681200>}
box{<0,0,-0.203200><0.287368,0.035000,0.203200> rotate<0,44.997030,0> translate<25.450700,-1.535000,19.884400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.450700,-1.535000,19.913600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.098500,-1.535000,19.913600>}
box{<0,0,-0.203200><8.647800,0.035000,0.203200> rotate<0,0.000000,0> translate<25.450700,-1.535000,19.913600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.450700,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.692100,-1.535000,20.320000>}
box{<0,0,-0.203200><8.241400,0.035000,0.203200> rotate<0,0.000000,0> translate<25.450700,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.450700,-1.535000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.285700,-1.535000,20.726400>}
box{<0,0,-0.203200><7.835000,0.035000,0.203200> rotate<0,0.000000,0> translate<25.450700,-1.535000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.450700,-1.535000,21.042900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.946900,-1.535000,21.539200>}
box{<0,0,-0.203200><0.701803,0.035000,0.203200> rotate<0,-45.002803,0> translate<25.450700,-1.535000,21.042900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.540500,-1.535000,21.132800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.879300,-1.535000,21.132800>}
box{<0,0,-0.203200><7.338800,0.035000,0.203200> rotate<0,0.000000,0> translate<25.540500,-1.535000,21.132800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.550300,-1.535000,9.638100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.921800,-1.535000,10.009600>}
box{<0,0,-0.203200><0.525380,0.035000,0.203200> rotate<0,-44.997030,0> translate<25.550300,-1.535000,9.638100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.653900,-1.535000,19.393800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.653900,-1.535000,19.681200>}
box{<0,0,-0.203200><0.287400,0.035000,0.203200> rotate<0,90.000000,0> translate<25.653900,-1.535000,19.681200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.653900,-1.535000,19.393800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.013800,-1.535000,18.033900>}
box{<0,0,-0.203200><1.923189,0.035000,0.203200> rotate<0,44.997030,0> translate<25.653900,-1.535000,19.393800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.653900,-1.535000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.504900,-1.535000,19.507200>}
box{<0,0,-0.203200><8.851000,0.035000,0.203200> rotate<0,0.000000,0> translate<25.653900,-1.535000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.743800,-1.535000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.438200,-1.535000,6.096000>}
box{<0,0,-0.203200><7.694400,0.035000,0.203200> rotate<0,0.000000,0> translate<25.743800,-1.535000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.921800,-1.535000,10.009600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.407200,-1.535000,10.210700>}
box{<0,0,-0.203200><0.525409,0.035000,0.203200> rotate<0,-22.502619,0> translate<25.921800,-1.535000,10.009600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.946900,-1.535000,19.100800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.911300,-1.535000,19.100800>}
box{<0,0,-0.203200><8.964400,0.035000,0.203200> rotate<0,0.000000,0> translate<25.946900,-1.535000,19.100800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<25.946900,-1.535000,21.539200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.470500,-1.535000,21.539200>}
box{<0,0,-0.203200><0.523600,0.035000,0.203200> rotate<0,0.000000,0> translate<25.946900,-1.535000,21.539200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.031200,-1.535000,1.016000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.234300,-1.535000,1.219200>}
box{<0,0,-0.203200><0.287297,0.035000,0.203200> rotate<0,-45.011131,0> translate<26.031200,-1.535000,1.016000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.031200,-1.535000,4.063900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.234300,-1.535000,3.860700>}
box{<0,0,-0.203200><0.287297,0.035000,0.203200> rotate<0,45.011131,0> translate<26.031200,-1.535000,4.063900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.031200,-1.535000,11.176000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.234300,-1.535000,11.379200>}
box{<0,0,-0.203200><0.287297,0.035000,0.203200> rotate<0,-45.011131,0> translate<26.031200,-1.535000,11.176000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.031200,-1.535000,14.223900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.234300,-1.535000,14.020700>}
box{<0,0,-0.203200><0.287297,0.035000,0.203200> rotate<0,45.011131,0> translate<26.031200,-1.535000,14.223900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.038700,-1.535000,14.986000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.301200,-1.535000,14.986000>}
box{<0,0,-0.203200><1.262500,0.035000,0.203200> rotate<0,0.000000,0> translate<26.038700,-1.535000,14.986000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.150200,-1.535000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.844600,-1.535000,6.502400>}
box{<0,0,-0.203200><7.694400,0.035000,0.203200> rotate<0,0.000000,0> translate<26.150200,-1.535000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.234300,-1.535000,1.219200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.012700,-1.535000,1.219200>}
box{<0,0,-0.203200><5.778400,0.035000,0.203200> rotate<0,0.000000,0> translate<26.234300,-1.535000,1.219200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.234300,-1.535000,3.860700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.202900,-1.535000,3.860700>}
box{<0,0,-0.203200><4.968600,0.035000,0.203200> rotate<0,0.000000,0> translate<26.234300,-1.535000,3.860700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.234300,-1.535000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.185600,-1.535000,11.379200>}
box{<0,0,-0.203200><5.951300,0.035000,0.203200> rotate<0,0.000000,0> translate<26.234300,-1.535000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.234300,-1.535000,14.020700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.185600,-1.535000,14.020700>}
box{<0,0,-0.203200><5.951300,0.035000,0.203200> rotate<0,0.000000,0> translate<26.234300,-1.535000,14.020700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.353300,-1.535000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.317700,-1.535000,18.694400>}
box{<0,0,-0.203200><8.964400,0.035000,0.203200> rotate<0,0.000000,0> translate<26.353300,-1.535000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.407200,-1.535000,10.210700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.725500,-1.535000,10.210700>}
box{<0,0,-0.203200><8.318300,0.035000,0.203200> rotate<0,0.000000,0> translate<26.407200,-1.535000,10.210700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.470500,-1.535000,21.539200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.673700,-1.535000,21.336000>}
box{<0,0,-0.203200><0.287368,0.035000,0.203200> rotate<0,44.997030,0> translate<26.470500,-1.535000,21.539200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.470500,-1.535000,24.180700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.673700,-1.535000,24.383900>}
box{<0,0,-0.203200><0.287368,0.035000,0.203200> rotate<0,-44.997030,0> translate<26.470500,-1.535000,24.180700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.556600,-1.535000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.036000,-1.535000,6.908800>}
box{<0,0,-0.203200><7.479400,0.035000,0.203200> rotate<0,0.000000,0> translate<26.556600,-1.535000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.673700,-1.535000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.936200,-1.535000,21.336000>}
box{<0,0,-0.203200><1.262500,0.035000,0.203200> rotate<0,0.000000,0> translate<26.673700,-1.535000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.673700,-1.535000,24.383900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.686000,-1.535000,24.383900>}
box{<0,0,-0.203200><1.012300,0.035000,0.203200> rotate<0,0.000000,0> translate<26.673700,-1.535000,24.383900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.759700,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.724100,-1.535000,18.288000>}
box{<0,0,-0.203200><8.964400,0.035000,0.203200> rotate<0,0.000000,0> translate<26.759700,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<26.963000,-1.535000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.370100,-1.535000,7.315200>}
box{<0,0,-0.203200><7.407100,0.035000,0.203200> rotate<0,0.000000,0> translate<26.963000,-1.535000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.013800,-1.535000,18.033900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.301200,-1.535000,18.033900>}
box{<0,0,-0.203200><0.287400,0.035000,0.203200> rotate<0,0.000000,0> translate<27.013800,-1.535000,18.033900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.217000,-1.535000,7.569200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.624100,-1.535000,7.569200>}
box{<0,0,-0.203200><7.407100,0.035000,0.203200> rotate<0,0.000000,0> translate<27.217000,-1.535000,7.569200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.301200,-1.535000,14.986000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.193900,-1.535000,15.878700>}
box{<0,0,-0.203200><1.262468,0.035000,0.203200> rotate<0,-44.997030,0> translate<27.301200,-1.535000,14.986000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.301200,-1.535000,18.033900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.193900,-1.535000,17.141200>}
box{<0,0,-0.203200><1.262468,0.035000,0.203200> rotate<0,44.997030,0> translate<27.301200,-1.535000,18.033900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.352000,-1.535000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.399200,-1.535000,15.036800>}
box{<0,0,-0.203200><17.047200,0.035000,0.203200> rotate<0,0.000000,0> translate<27.352000,-1.535000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.453500,-1.535000,17.881600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.130500,-1.535000,17.881600>}
box{<0,0,-0.203200><8.677000,0.035000,0.203200> rotate<0,0.000000,0> translate<27.453500,-1.535000,17.881600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.686000,-1.535000,24.761200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.686000,-1.535000,24.383900>}
box{<0,0,-0.203200><0.377300,0.035000,0.203200> rotate<0,-90.000000,0> translate<27.686000,-1.535000,24.383900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.686000,-1.535000,24.761200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.578700,-1.535000,25.653900>}
box{<0,0,-0.203200><1.262468,0.035000,0.203200> rotate<0,-44.997030,0> translate<27.686000,-1.535000,24.761200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.758400,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.399200,-1.535000,15.443200>}
box{<0,0,-0.203200><16.640800,0.035000,0.203200> rotate<0,0.000000,0> translate<27.758400,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.859900,-1.535000,17.475200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.536900,-1.535000,17.475200>}
box{<0,0,-0.203200><8.677000,0.035000,0.203200> rotate<0,0.000000,0> translate<27.859900,-1.535000,17.475200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<27.936200,-1.535000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.828900,-1.535000,22.228700>}
box{<0,0,-0.203200><1.262468,0.035000,0.203200> rotate<0,-44.997030,0> translate<27.936200,-1.535000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.139400,-1.535000,21.539200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.185500,-1.535000,21.539200>}
box{<0,0,-0.203200><4.046100,0.035000,0.203200> rotate<0,0.000000,0> translate<28.139400,-1.535000,21.539200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.164800,-1.535000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.399200,-1.535000,15.849600>}
box{<0,0,-0.203200><16.234400,0.035000,0.203200> rotate<0,0.000000,0> translate<28.164800,-1.535000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.193900,-1.535000,15.878700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.193900,-1.535000,17.141200>}
box{<0,0,-0.203200><1.262500,0.035000,0.203200> rotate<0,90.000000,0> translate<28.193900,-1.535000,17.141200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.193900,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.798500,-1.535000,16.256000>}
box{<0,0,-0.203200><13.604600,0.035000,0.203200> rotate<0,0.000000,0> translate<28.193900,-1.535000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.193900,-1.535000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.349700,-1.535000,16.662400>}
box{<0,0,-0.203200><9.155800,0.035000,0.203200> rotate<0,0.000000,0> translate<28.193900,-1.535000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.193900,-1.535000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.943300,-1.535000,17.068800>}
box{<0,0,-0.203200><8.749400,0.035000,0.203200> rotate<0,0.000000,0> translate<28.193900,-1.535000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.545800,-1.535000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.779100,-1.535000,21.945600>}
box{<0,0,-0.203200><3.233300,0.035000,0.203200> rotate<0,0.000000,0> translate<28.545800,-1.535000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.578700,-1.535000,25.653900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.841200,-1.535000,25.653900>}
box{<0,0,-0.203200><1.262500,0.035000,0.203200> rotate<0,0.000000,0> translate<28.578700,-1.535000,25.653900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.828900,-1.535000,22.228700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.828900,-1.535000,22.606000>}
box{<0,0,-0.203200><0.377300,0.035000,0.203200> rotate<0,90.000000,0> translate<28.828900,-1.535000,22.606000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.828900,-1.535000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.496000,-1.535000,22.352000>}
box{<0,0,-0.203200><2.667100,0.035000,0.203200> rotate<0,0.000000,0> translate<28.828900,-1.535000,22.352000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<28.828900,-1.535000,22.606000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.841200,-1.535000,22.606000>}
box{<0,0,-0.203200><1.012300,0.035000,0.203200> rotate<0,0.000000,0> translate<28.828900,-1.535000,22.606000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.841200,-1.535000,22.606000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.044400,-1.535000,22.809200>}
box{<0,0,-0.203200><0.287368,0.035000,0.203200> rotate<0,-44.997030,0> translate<29.841200,-1.535000,22.606000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.841200,-1.535000,25.653900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.044400,-1.535000,25.450700>}
box{<0,0,-0.203200><0.287368,0.035000,0.203200> rotate<0,44.997030,0> translate<29.841200,-1.535000,25.653900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.891900,-1.535000,25.603200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.355500,-1.535000,25.603200>}
box{<0,0,-0.203200><1.463600,0.035000,0.203200> rotate<0,0.000000,0> translate<29.891900,-1.535000,25.603200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<29.993600,-1.535000,22.758400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.253700,-1.535000,22.758400>}
box{<0,0,-0.203200><1.260100,0.035000,0.203200> rotate<0,0.000000,0> translate<29.993600,-1.535000,22.758400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.044400,-1.535000,22.809200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.202900,-1.535000,22.809200>}
box{<0,0,-0.203200><1.158500,0.035000,0.203200> rotate<0,0.000000,0> translate<30.044400,-1.535000,22.809200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<30.044400,-1.535000,25.450700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.202900,-1.535000,25.450700>}
box{<0,0,-0.203200><1.158500,0.035000,0.203200> rotate<0,0.000000,0> translate<30.044400,-1.535000,25.450700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.202900,-1.535000,3.860700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.036000,-1.535000,6.693800>}
box{<0,0,-0.203200><4.006608,0.035000,0.203200> rotate<0,-44.997030,0> translate<31.202900,-1.535000,3.860700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.202900,-1.535000,22.809200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.496000,-1.535000,22.516100>}
box{<0,0,-0.203200><0.414506,0.035000,0.203200> rotate<0,44.997030,0> translate<31.202900,-1.535000,22.809200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.202900,-1.535000,25.450700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.766000,-1.535000,27.013700>}
box{<0,0,-0.203200><2.210487,0.035000,0.203200> rotate<0,-44.995197,0> translate<31.202900,-1.535000,25.450700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.496000,-1.535000,22.228700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.388700,-1.535000,21.336000>}
box{<0,0,-0.203200><1.262468,0.035000,0.203200> rotate<0,44.997030,0> translate<31.496000,-1.535000,22.228700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.496000,-1.535000,22.516100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<31.496000,-1.535000,22.228700>}
box{<0,0,-0.203200><0.287400,0.035000,0.203200> rotate<0,-90.000000,0> translate<31.496000,-1.535000,22.228700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.012700,-1.535000,1.219200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.498100,-1.535000,1.420300>}
box{<0,0,-0.203200><0.525409,0.035000,0.203200> rotate<0,-22.502619,0> translate<32.012700,-1.535000,1.219200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.012700,-1.535000,1.219200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,1.219200>}
box{<0,0,-0.203200><16.704500,0.035000,0.203200> rotate<0,0.000000,0> translate<32.012700,-1.535000,1.219200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.185600,-1.535000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.388700,-1.535000,11.176000>}
box{<0,0,-0.203200><0.287297,0.035000,0.203200> rotate<0,45.011131,0> translate<32.185600,-1.535000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.185600,-1.535000,14.020700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.388700,-1.535000,14.223900>}
box{<0,0,-0.203200><0.287297,0.035000,0.203200> rotate<0,-45.011131,0> translate<32.185600,-1.535000,14.020700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.388700,-1.535000,11.176000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.651200,-1.535000,11.176000>}
box{<0,0,-0.203200><1.262500,0.035000,0.203200> rotate<0,0.000000,0> translate<32.388700,-1.535000,11.176000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.388700,-1.535000,14.223900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.651200,-1.535000,14.223900>}
box{<0,0,-0.203200><1.262500,0.035000,0.203200> rotate<0,0.000000,0> translate<32.388700,-1.535000,14.223900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.388700,-1.535000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.676100,-1.535000,21.336000>}
box{<0,0,-0.203200><0.287400,0.035000,0.203200> rotate<0,0.000000,0> translate<32.388700,-1.535000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.498100,-1.535000,1.420300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.869600,-1.535000,1.791800>}
box{<0,0,-0.203200><0.525380,0.035000,0.203200> rotate<0,-44.997030,0> translate<32.498100,-1.535000,1.420300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.676100,-1.535000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.980300,-1.535000,17.031800>}
box{<0,0,-0.203200><6.087058,0.035000,0.203200> rotate<0,44.997030,0> translate<32.676100,-1.535000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.703400,-1.535000,1.625600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,1.625600>}
box{<0,0,-0.203200><16.013800,0.035000,0.203200> rotate<0,0.000000,0> translate<32.703400,-1.535000,1.625600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.766000,-1.535000,27.301200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.766000,-1.535000,27.013700>}
box{<0,0,-0.203200><0.287500,0.035000,0.203200> rotate<0,-90.000000,0> translate<32.766000,-1.535000,27.013700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.766000,-1.535000,27.301200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.658700,-1.535000,28.193900>}
box{<0,0,-0.203200><1.262468,0.035000,0.203200> rotate<0,-44.997030,0> translate<32.766000,-1.535000,27.301200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<32.869600,-1.535000,1.791800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.903800,-1.535000,4.826000>}
box{<0,0,-0.203200><4.291007,0.035000,0.203200> rotate<0,-44.997030,0> translate<32.869600,-1.535000,1.791800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.109800,-1.535000,2.032000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,2.032000>}
box{<0,0,-0.203200><15.607400,0.035000,0.203200> rotate<0,0.000000,0> translate<33.109800,-1.535000,2.032000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.516200,-1.535000,2.438400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,2.438400>}
box{<0,0,-0.203200><15.201000,0.035000,0.203200> rotate<0,0.000000,0> translate<33.516200,-1.535000,2.438400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.651200,-1.535000,11.176000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.854300,-1.535000,11.379200>}
box{<0,0,-0.203200><0.287297,0.035000,0.203200> rotate<0,-45.011131,0> translate<33.651200,-1.535000,11.176000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.651200,-1.535000,14.223900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.854300,-1.535000,14.020700>}
box{<0,0,-0.203200><0.287297,0.035000,0.203200> rotate<0,45.011131,0> translate<33.651200,-1.535000,14.223900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.658700,-1.535000,28.193900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.921200,-1.535000,28.193900>}
box{<0,0,-0.203200><1.262500,0.035000,0.203200> rotate<0,0.000000,0> translate<33.658700,-1.535000,28.193900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.761400,-1.535000,24.273600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.543900,-1.535000,23.491200>}
box{<0,0,-0.203200><1.106551,0.035000,0.203200> rotate<0,44.993369,0> translate<33.761400,-1.535000,24.273600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.761400,-1.535000,24.273600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.633700,-1.535000,25.146000>}
box{<0,0,-0.203200><1.233689,0.035000,0.203200> rotate<0,-45.000314,0> translate<33.761400,-1.535000,24.273600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.854300,-1.535000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.265600,-1.535000,11.379200>}
box{<0,0,-0.203200><3.411300,0.035000,0.203200> rotate<0,0.000000,0> translate<33.854300,-1.535000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.854300,-1.535000,14.020700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.265600,-1.535000,14.020700>}
box{<0,0,-0.203200><3.411300,0.035000,0.203200> rotate<0,0.000000,0> translate<33.854300,-1.535000,14.020700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.871700,-1.535000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.509200,-1.535000,24.384000>}
box{<0,0,-0.203200><1.637500,0.035000,0.203200> rotate<0,0.000000,0> translate<33.871700,-1.535000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<33.922600,-1.535000,2.844800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,2.844800>}
box{<0,0,-0.203200><14.794600,0.035000,0.203200> rotate<0,0.000000,0> translate<33.922600,-1.535000,2.844800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.036000,-1.535000,6.981200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.036000,-1.535000,6.693800>}
box{<0,0,-0.203200><0.287400,0.035000,0.203200> rotate<0,-90.000000,0> translate<34.036000,-1.535000,6.693800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.036000,-1.535000,6.981200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.624100,-1.535000,7.569200>}
box{<0,0,-0.203200><0.831628,0.035000,0.203200> rotate<0,-44.992159,0> translate<34.036000,-1.535000,6.981200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.057500,-1.535000,23.977600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.509200,-1.535000,23.977600>}
box{<0,0,-0.203200><1.451700,0.035000,0.203200> rotate<0,0.000000,0> translate<34.057500,-1.535000,23.977600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.278100,-1.535000,24.790400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.509200,-1.535000,24.790400>}
box{<0,0,-0.203200><1.231100,0.035000,0.203200> rotate<0,0.000000,0> translate<34.278100,-1.535000,24.790400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.329000,-1.535000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,3.251200>}
box{<0,0,-0.203200><14.388200,0.035000,0.203200> rotate<0,0.000000,0> translate<34.329000,-1.535000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.463900,-1.535000,23.571200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.631800,-1.535000,23.571200>}
box{<0,0,-0.203200><1.167900,0.035000,0.203200> rotate<0,0.000000,0> translate<34.463900,-1.535000,23.571200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.543900,-1.535000,23.203800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.543900,-1.535000,23.491200>}
box{<0,0,-0.203200><0.287400,0.035000,0.203200> rotate<0,90.000000,0> translate<34.543900,-1.535000,23.491200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.543900,-1.535000,23.203800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.647000,-1.535000,19.100700>}
box{<0,0,-0.203200><5.802660,0.035000,0.203200> rotate<0,44.997030,0> translate<34.543900,-1.535000,23.203800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.582900,-1.535000,23.164800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.927300,-1.535000,23.164800>}
box{<0,0,-0.203200><1.344400,0.035000,0.203200> rotate<0,0.000000,0> translate<34.582900,-1.535000,23.164800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.633700,-1.535000,25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.921200,-1.535000,25.146000>}
box{<0,0,-0.203200><0.287500,0.035000,0.203200> rotate<0,0.000000,0> translate<34.633700,-1.535000,25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.725500,-1.535000,10.210700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.928700,-1.535000,10.413900>}
box{<0,0,-0.203200><0.287368,0.035000,0.203200> rotate<0,-44.997030,0> translate<34.725500,-1.535000,10.210700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.735400,-1.535000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,3.657600>}
box{<0,0,-0.203200><13.981800,0.035000,0.203200> rotate<0,0.000000,0> translate<34.735400,-1.535000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.921200,-1.535000,25.146000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.509200,-1.535000,25.734100>}
box{<0,0,-0.203200><0.831628,0.035000,0.203200> rotate<0,-45.001902,0> translate<34.921200,-1.535000,25.146000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.921200,-1.535000,28.193900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.560000,-1.535000,27.555100>}
box{<0,0,-0.203200><0.903400,0.035000,0.203200> rotate<0,44.997030,0> translate<34.921200,-1.535000,28.193900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.928700,-1.535000,10.413900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.191200,-1.535000,10.413900>}
box{<0,0,-0.203200><1.262500,0.035000,0.203200> rotate<0,0.000000,0> translate<34.928700,-1.535000,10.413900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.971900,-1.535000,25.196800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.509200,-1.535000,25.196800>}
box{<0,0,-0.203200><0.537300,0.035000,0.203200> rotate<0,0.000000,0> translate<34.971900,-1.535000,25.196800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<34.989300,-1.535000,22.758400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.333700,-1.535000,22.758400>}
box{<0,0,-0.203200><1.344400,0.035000,0.203200> rotate<0,0.000000,0> translate<34.989300,-1.535000,22.758400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.073500,-1.535000,28.041600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.046500,-1.535000,28.041600>}
box{<0,0,-0.203200><0.973000,0.035000,0.203200> rotate<0,0.000000,0> translate<35.073500,-1.535000,28.041600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.141800,-1.535000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,4.064000>}
box{<0,0,-0.203200><13.575400,0.035000,0.203200> rotate<0,0.000000,0> translate<35.141800,-1.535000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.378300,-1.535000,25.603200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.509200,-1.535000,25.603200>}
box{<0,0,-0.203200><0.130900,0.035000,0.203200> rotate<0,0.000000,0> translate<35.378300,-1.535000,25.603200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.395700,-1.535000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.576000,-1.535000,22.352000>}
box{<0,0,-0.203200><1.180300,0.035000,0.203200> rotate<0,0.000000,0> translate<35.395700,-1.535000,22.352000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.479900,-1.535000,27.635200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.640100,-1.535000,27.635200>}
box{<0,0,-0.203200><0.160200,0.035000,0.203200> rotate<0,0.000000,0> translate<35.479900,-1.535000,27.635200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.509200,-1.535000,23.867200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.710300,-1.535000,23.381800>}
box{<0,0,-0.203200><0.525409,0.035000,0.203200> rotate<0,67.491441,0> translate<35.509200,-1.535000,23.867200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.509200,-1.535000,24.392700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.509200,-1.535000,23.867200>}
box{<0,0,-0.203200><0.525500,0.035000,0.203200> rotate<0,-90.000000,0> translate<35.509200,-1.535000,23.867200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.509200,-1.535000,25.734100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.509200,-1.535000,24.392700>}
box{<0,0,-0.203200><1.341400,0.035000,0.203200> rotate<0,-90.000000,0> translate<35.509200,-1.535000,24.392700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.548200,-1.535000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,4.470400>}
box{<0,0,-0.203200><13.169000,0.035000,0.203200> rotate<0,0.000000,0> translate<35.548200,-1.535000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.560000,-1.535000,27.555100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.198700,-1.535000,28.193900>}
box{<0,0,-0.203200><0.903329,0.035000,0.203200> rotate<0,-45.001515,0> translate<35.560000,-1.535000,27.555100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.710300,-1.535000,23.381800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.576000,-1.535000,22.516100>}
box{<0,0,-0.203200><1.224285,0.035000,0.203200> rotate<0,44.997030,0> translate<35.710300,-1.535000,23.381800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.802100,-1.535000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.859100,-1.535000,21.945600>}
box{<0,0,-0.203200><1.057000,0.035000,0.203200> rotate<0,0.000000,0> translate<35.802100,-1.535000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<35.903800,-1.535000,4.826000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.191200,-1.535000,4.826000>}
box{<0,0,-0.203200><0.287400,0.035000,0.203200> rotate<0,0.000000,0> translate<35.903800,-1.535000,4.826000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.191200,-1.535000,4.826000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.083900,-1.535000,5.718700>}
box{<0,0,-0.203200><1.262468,0.035000,0.203200> rotate<0,-44.997030,0> translate<36.191200,-1.535000,4.826000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.191200,-1.535000,10.413900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.394400,-1.535000,10.210700>}
box{<0,0,-0.203200><0.287368,0.035000,0.203200> rotate<0,44.997030,0> translate<36.191200,-1.535000,10.413900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.198700,-1.535000,28.193900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.461200,-1.535000,28.193900>}
box{<0,0,-0.203200><1.262500,0.035000,0.203200> rotate<0,0.000000,0> translate<36.198700,-1.535000,28.193900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.208500,-1.535000,21.539200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.265500,-1.535000,21.539200>}
box{<0,0,-0.203200><1.057000,0.035000,0.203200> rotate<0,0.000000,0> translate<36.208500,-1.535000,21.539200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.242000,-1.535000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,4.876800>}
box{<0,0,-0.203200><12.475200,0.035000,0.203200> rotate<0,0.000000,0> translate<36.242000,-1.535000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.394400,-1.535000,10.210700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.632900,-1.535000,10.210700>}
box{<0,0,-0.203200><6.238500,0.035000,0.203200> rotate<0,0.000000,0> translate<36.394400,-1.535000,10.210700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.495800,-1.535000,7.569200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.083900,-1.535000,6.981200>}
box{<0,0,-0.203200><0.831628,0.035000,0.203200> rotate<0,44.992159,0> translate<36.495800,-1.535000,7.569200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.495800,-1.535000,7.569200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.442700,-1.535000,7.569200>}
box{<0,0,-0.203200><6.946900,0.035000,0.203200> rotate<0,0.000000,0> translate<36.495800,-1.535000,7.569200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.576000,-1.535000,22.228700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.468700,-1.535000,21.336000>}
box{<0,0,-0.203200><1.262468,0.035000,0.203200> rotate<0,44.997030,0> translate<36.576000,-1.535000,22.228700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.576000,-1.535000,22.516100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.576000,-1.535000,22.228700>}
box{<0,0,-0.203200><0.287400,0.035000,0.203200> rotate<0,-90.000000,0> translate<36.576000,-1.535000,22.228700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.614900,-1.535000,21.132800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.944400,-1.535000,21.132800>}
box{<0,0,-0.203200><4.329500,0.035000,0.203200> rotate<0,0.000000,0> translate<36.614900,-1.535000,21.132800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.648400,-1.535000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,5.283200>}
box{<0,0,-0.203200><12.068800,0.035000,0.203200> rotate<0,0.000000,0> translate<36.648400,-1.535000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.749900,-1.535000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,7.315200>}
box{<0,0,-0.203200><11.967300,0.035000,0.203200> rotate<0,0.000000,0> translate<36.749900,-1.535000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<36.980300,-1.535000,17.031800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.351800,-1.535000,16.660300>}
box{<0,0,-0.203200><0.525380,0.035000,0.203200> rotate<0,44.997030,0> translate<36.980300,-1.535000,17.031800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.021300,-1.535000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.776100,-1.535000,20.726400>}
box{<0,0,-0.203200><3.754800,0.035000,0.203200> rotate<0,0.000000,0> translate<37.021300,-1.535000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.054800,-1.535000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,5.689600>}
box{<0,0,-0.203200><11.662400,0.035000,0.203200> rotate<0,0.000000,0> translate<37.054800,-1.535000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.083900,-1.535000,5.718700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.083900,-1.535000,6.981200>}
box{<0,0,-0.203200><1.262500,0.035000,0.203200> rotate<0,90.000000,0> translate<37.083900,-1.535000,6.981200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.083900,-1.535000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,6.096000>}
box{<0,0,-0.203200><11.633300,0.035000,0.203200> rotate<0,0.000000,0> translate<37.083900,-1.535000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.083900,-1.535000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,6.502400>}
box{<0,0,-0.203200><11.633300,0.035000,0.203200> rotate<0,0.000000,0> translate<37.083900,-1.535000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.083900,-1.535000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,6.908800>}
box{<0,0,-0.203200><11.633300,0.035000,0.203200> rotate<0,0.000000,0> translate<37.083900,-1.535000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.265600,-1.535000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.468700,-1.535000,11.176000>}
box{<0,0,-0.203200><0.287297,0.035000,0.203200> rotate<0,45.011131,0> translate<37.265600,-1.535000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.265600,-1.535000,14.020700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.468700,-1.535000,14.223900>}
box{<0,0,-0.203200><0.287297,0.035000,0.203200> rotate<0,-45.011131,0> translate<37.265600,-1.535000,14.020700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.351800,-1.535000,16.660300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.837200,-1.535000,16.459200>}
box{<0,0,-0.203200><0.525409,0.035000,0.203200> rotate<0,22.502619,0> translate<37.351800,-1.535000,16.660300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.427700,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.741600,-1.535000,20.320000>}
box{<0,0,-0.203200><3.313900,0.035000,0.203200> rotate<0,0.000000,0> translate<37.427700,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.461200,-1.535000,28.193900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.353900,-1.535000,27.301200>}
box{<0,0,-0.203200><1.262468,0.035000,0.203200> rotate<0,44.997030,0> translate<37.461200,-1.535000,28.193900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.468700,-1.535000,11.176000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.731200,-1.535000,11.176000>}
box{<0,0,-0.203200><1.262500,0.035000,0.203200> rotate<0,0.000000,0> translate<37.468700,-1.535000,11.176000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.468700,-1.535000,14.223900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.731200,-1.535000,14.223900>}
box{<0,0,-0.203200><1.262500,0.035000,0.203200> rotate<0,0.000000,0> translate<37.468700,-1.535000,14.223900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.468700,-1.535000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.731200,-1.535000,21.336000>}
box{<0,0,-0.203200><1.262500,0.035000,0.203200> rotate<0,0.000000,0> translate<37.468700,-1.535000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.613500,-1.535000,28.041600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,28.041600>}
box{<0,0,-0.203200><11.103700,0.035000,0.203200> rotate<0,0.000000,0> translate<37.613500,-1.535000,28.041600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.834100,-1.535000,19.913600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.775900,-1.535000,19.913600>}
box{<0,0,-0.203200><2.941800,0.035000,0.203200> rotate<0,0.000000,0> translate<37.834100,-1.535000,19.913600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<37.837200,-1.535000,16.459200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.389000,-1.535000,16.459200>}
box{<0,0,-0.203200><3.551800,0.035000,0.203200> rotate<0,0.000000,0> translate<37.837200,-1.535000,16.459200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.019900,-1.535000,27.635200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,27.635200>}
box{<0,0,-0.203200><10.697300,0.035000,0.203200> rotate<0,0.000000,0> translate<38.019900,-1.535000,27.635200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.150700,-1.535000,24.677000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.150700,-1.535000,25.835500>}
box{<0,0,-0.203200><1.158500,0.035000,0.203200> rotate<0,90.000000,0> translate<38.150700,-1.535000,25.835500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.150700,-1.535000,24.677000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.443800,-1.535000,24.383900>}
box{<0,0,-0.203200><0.414506,0.035000,0.203200> rotate<0,44.997030,0> translate<38.150700,-1.535000,24.677000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.150700,-1.535000,24.790400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,24.790400>}
box{<0,0,-0.203200><10.566500,0.035000,0.203200> rotate<0,0.000000,0> translate<38.150700,-1.535000,24.790400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.150700,-1.535000,25.196800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,25.196800>}
box{<0,0,-0.203200><10.566500,0.035000,0.203200> rotate<0,0.000000,0> translate<38.150700,-1.535000,25.196800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.150700,-1.535000,25.603200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,25.603200>}
box{<0,0,-0.203200><10.566500,0.035000,0.203200> rotate<0,0.000000,0> translate<38.150700,-1.535000,25.603200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.150700,-1.535000,25.835500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.353900,-1.535000,26.038700>}
box{<0,0,-0.203200><0.287368,0.035000,0.203200> rotate<0,-44.997030,0> translate<38.150700,-1.535000,25.835500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.240500,-1.535000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.944300,-1.535000,19.507200>}
box{<0,0,-0.203200><2.703800,0.035000,0.203200> rotate<0,0.000000,0> translate<38.240500,-1.535000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.324800,-1.535000,26.009600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,26.009600>}
box{<0,0,-0.203200><10.392400,0.035000,0.203200> rotate<0,0.000000,0> translate<38.324800,-1.535000,26.009600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.353900,-1.535000,26.038700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.353900,-1.535000,27.301200>}
box{<0,0,-0.203200><1.262500,0.035000,0.203200> rotate<0,90.000000,0> translate<38.353900,-1.535000,27.301200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.353900,-1.535000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,26.416000>}
box{<0,0,-0.203200><10.363300,0.035000,0.203200> rotate<0,0.000000,0> translate<38.353900,-1.535000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.353900,-1.535000,26.822400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,26.822400>}
box{<0,0,-0.203200><10.363300,0.035000,0.203200> rotate<0,0.000000,0> translate<38.353900,-1.535000,26.822400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.353900,-1.535000,27.228800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,27.228800>}
box{<0,0,-0.203200><10.363300,0.035000,0.203200> rotate<0,0.000000,0> translate<38.353900,-1.535000,27.228800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.443700,-1.535000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,24.384000>}
box{<0,0,-0.203200><10.273500,0.035000,0.203200> rotate<0,0.000000,0> translate<38.443700,-1.535000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.443800,-1.535000,24.383900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.731200,-1.535000,24.383900>}
box{<0,0,-0.203200><0.287400,0.035000,0.203200> rotate<0,0.000000,0> translate<38.443800,-1.535000,24.383900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.646900,-1.535000,19.100800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.287400,-1.535000,19.100800>}
box{<0,0,-0.203200><2.640500,0.035000,0.203200> rotate<0,0.000000,0> translate<38.646900,-1.535000,19.100800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.647000,-1.535000,19.100700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.287600,-1.535000,19.100700>}
box{<0,0,-0.203200><2.640600,0.035000,0.203200> rotate<0,0.000000,0> translate<38.647000,-1.535000,19.100700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.731200,-1.535000,11.176000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.934300,-1.535000,11.379200>}
box{<0,0,-0.203200><0.287297,0.035000,0.203200> rotate<0,-45.011131,0> translate<38.731200,-1.535000,11.176000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.731200,-1.535000,14.223900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.934300,-1.535000,14.020700>}
box{<0,0,-0.203200><0.287297,0.035000,0.203200> rotate<0,45.011131,0> translate<38.731200,-1.535000,14.223900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.731200,-1.535000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.623900,-1.535000,22.228700>}
box{<0,0,-0.203200><1.262468,0.035000,0.203200> rotate<0,-44.997030,0> translate<38.731200,-1.535000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.731200,-1.535000,24.383900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.623900,-1.535000,23.491200>}
box{<0,0,-0.203200><1.262468,0.035000,0.203200> rotate<0,44.997030,0> translate<38.731200,-1.535000,24.383900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.934300,-1.535000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.389000,-1.535000,11.379200>}
box{<0,0,-0.203200><2.454700,0.035000,0.203200> rotate<0,0.000000,0> translate<38.934300,-1.535000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.934300,-1.535000,14.020700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.389000,-1.535000,14.020700>}
box{<0,0,-0.203200><2.454700,0.035000,0.203200> rotate<0,0.000000,0> translate<38.934300,-1.535000,14.020700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<38.934400,-1.535000,21.539200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.287500,-1.535000,21.539200>}
box{<0,0,-0.203200><2.353100,0.035000,0.203200> rotate<0,0.000000,0> translate<38.934400,-1.535000,21.539200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.137500,-1.535000,23.977600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,23.977600>}
box{<0,0,-0.203200><9.579700,0.035000,0.203200> rotate<0,0.000000,0> translate<39.137500,-1.535000,23.977600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.340800,-1.535000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,21.945600>}
box{<0,0,-0.203200><9.376400,0.035000,0.203200> rotate<0,0.000000,0> translate<39.340800,-1.535000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.543900,-1.535000,23.571200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,23.571200>}
box{<0,0,-0.203200><9.173300,0.035000,0.203200> rotate<0,0.000000,0> translate<39.543900,-1.535000,23.571200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.623900,-1.535000,22.228700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.623900,-1.535000,23.491200>}
box{<0,0,-0.203200><1.262500,0.035000,0.203200> rotate<0,90.000000,0> translate<39.623900,-1.535000,23.491200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.623900,-1.535000,22.352000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,22.352000>}
box{<0,0,-0.203200><9.093300,0.035000,0.203200> rotate<0,0.000000,0> translate<39.623900,-1.535000,22.352000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.623900,-1.535000,22.758400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,22.758400>}
box{<0,0,-0.203200><9.093300,0.035000,0.203200> rotate<0,0.000000,0> translate<39.623900,-1.535000,22.758400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<39.623900,-1.535000,23.164800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,23.164800>}
box{<0,0,-0.203200><9.093300,0.035000,0.203200> rotate<0,0.000000,0> translate<39.623900,-1.535000,23.164800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.741600,-1.535000,19.996600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.989100,-1.535000,19.399100>}
box{<0,0,-0.203200><0.646732,0.035000,0.203200> rotate<0,67.494940,0> translate<40.741600,-1.535000,19.996600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.741600,-1.535000,20.643300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.741600,-1.535000,19.996600>}
box{<0,0,-0.203200><0.646700,0.035000,0.203200> rotate<0,-90.000000,0> translate<40.741600,-1.535000,19.996600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.741600,-1.535000,20.643300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.989100,-1.535000,21.240800>}
box{<0,0,-0.203200><0.646732,0.035000,0.203200> rotate<0,-67.494940,0> translate<40.741600,-1.535000,20.643300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.989100,-1.535000,19.399100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.287600,-1.535000,19.100700>}
box{<0,0,-0.203200><0.422072,0.035000,0.203200> rotate<0,44.987432,0> translate<40.989100,-1.535000,19.399100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<40.989100,-1.535000,21.240800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.446300,-1.535000,21.698000>}
box{<0,0,-0.203200><0.646578,0.035000,0.203200> rotate<0,-44.997030,0> translate<40.989100,-1.535000,21.240800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.389000,-1.535000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.446300,-1.535000,11.321900>}
box{<0,0,-0.203200><0.081034,0.035000,0.203200> rotate<0,44.997030,0> translate<41.389000,-1.535000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.389000,-1.535000,14.020700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.446300,-1.535000,14.078000>}
box{<0,0,-0.203200><0.081034,0.035000,0.203200> rotate<0,-44.997030,0> translate<41.389000,-1.535000,14.020700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.389000,-1.535000,16.459200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.446300,-1.535000,16.401900>}
box{<0,0,-0.203200><0.081034,0.035000,0.203200> rotate<0,44.997030,0> translate<41.389000,-1.535000,16.459200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.446300,-1.535000,11.321900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.043800,-1.535000,11.074400>}
box{<0,0,-0.203200><0.646732,0.035000,0.203200> rotate<0,22.499120,0> translate<41.446300,-1.535000,11.321900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.446300,-1.535000,14.078000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.043800,-1.535000,14.325500>}
box{<0,0,-0.203200><0.646732,0.035000,0.203200> rotate<0,-22.499120,0> translate<41.446300,-1.535000,14.078000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.446300,-1.535000,16.401900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.043800,-1.535000,16.154400>}
box{<0,0,-0.203200><0.646732,0.035000,0.203200> rotate<0,22.499120,0> translate<41.446300,-1.535000,16.401900> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<41.446300,-1.535000,21.698000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.043800,-1.535000,21.945500>}
box{<0,0,-0.203200><0.646732,0.035000,0.203200> rotate<0,-22.499120,0> translate<41.446300,-1.535000,21.698000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.043800,-1.535000,11.074400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.496700,-1.535000,11.074400>}
box{<0,0,-0.203200><1.452900,0.035000,0.203200> rotate<0,0.000000,0> translate<42.043800,-1.535000,11.074400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.043800,-1.535000,14.325500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.316100,-1.535000,14.325500>}
box{<0,0,-0.203200><2.272300,0.035000,0.203200> rotate<0,0.000000,0> translate<42.043800,-1.535000,14.325500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.043800,-1.535000,16.154400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.316100,-1.535000,16.154400>}
box{<0,0,-0.203200><2.272300,0.035000,0.203200> rotate<0,0.000000,0> translate<42.043800,-1.535000,16.154400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.043800,-1.535000,21.945500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.316100,-1.535000,21.945500>}
box{<0,0,-0.203200><2.272300,0.035000,0.203200> rotate<0,0.000000,0> translate<42.043800,-1.535000,21.945500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<42.632900,-1.535000,10.210700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.496700,-1.535000,11.074400>}
box{<0,0,-0.203200><1.221527,0.035000,0.203200> rotate<0,-44.993714,0> translate<42.632900,-1.535000,10.210700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.442700,-1.535000,7.569200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.928100,-1.535000,7.770300>}
box{<0,0,-0.203200><0.525409,0.035000,0.203200> rotate<0,-22.502619,0> translate<43.442700,-1.535000,7.569200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.810500,-1.535000,7.721600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,7.721600>}
box{<0,0,-0.203200><4.906700,0.035000,0.203200> rotate<0,0.000000,0> translate<43.810500,-1.535000,7.721600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<43.928100,-1.535000,7.770300>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.299600,-1.535000,8.141800>}
box{<0,0,-0.203200><0.525380,0.035000,0.203200> rotate<0,-44.997030,0> translate<43.928100,-1.535000,7.770300> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.285800,-1.535000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,8.128000>}
box{<0,0,-0.203200><4.431400,0.035000,0.203200> rotate<0,0.000000,0> translate<44.285800,-1.535000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.299600,-1.535000,8.141800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.839600,-1.535000,10.681800>}
box{<0,0,-0.203200><3.592102,0.035000,0.203200> rotate<0,-44.997030,0> translate<44.299600,-1.535000,8.141800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.316100,-1.535000,14.325500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.399200,-1.535000,14.291000>}
box{<0,0,-0.203200><0.089977,0.035000,0.203200> rotate<0,22.544902,0> translate<44.316100,-1.535000,14.325500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.316100,-1.535000,16.154400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.399200,-1.535000,16.188900>}
box{<0,0,-0.203200><0.089977,0.035000,0.203200> rotate<0,-22.544902,0> translate<44.316100,-1.535000,16.154400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.316100,-1.535000,21.945500>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.913600,-1.535000,21.698000>}
box{<0,0,-0.203200><0.646732,0.035000,0.203200> rotate<0,22.499120,0> translate<44.316100,-1.535000,21.945500> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.399200,-1.535000,16.188900>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.399200,-1.535000,14.291000>}
box{<0,0,-0.203200><1.897900,0.035000,0.203200> rotate<0,-90.000000,0> translate<44.399200,-1.535000,14.291000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.692200,-1.535000,8.534400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,8.534400>}
box{<0,0,-0.203200><4.025000,0.035000,0.203200> rotate<0,0.000000,0> translate<44.692200,-1.535000,8.534400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<44.913600,-1.535000,21.698000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.153500,-1.535000,21.458000>}
box{<0,0,-0.203200><0.339341,0.035000,0.203200> rotate<0,45.008968,0> translate<44.913600,-1.535000,21.698000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.072400,-1.535000,21.539200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,21.539200>}
box{<0,0,-0.203200><3.644800,0.035000,0.203200> rotate<0,0.000000,0> translate<45.072400,-1.535000,21.539200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.098600,-1.535000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,8.940800>}
box{<0,0,-0.203200><3.618600,0.035000,0.203200> rotate<0,0.000000,0> translate<45.098600,-1.535000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.153500,-1.535000,21.458000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.198100,-1.535000,21.439600>}
box{<0,0,-0.203200><0.048246,0.035000,0.203200> rotate<0,22.417412,0> translate<45.153500,-1.535000,21.458000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.198100,-1.535000,21.439600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.468100,-1.535000,20.169600>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<45.198100,-1.535000,21.439600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.504900,-1.535000,21.132800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,21.132800>}
box{<0,0,-0.203200><3.212300,0.035000,0.203200> rotate<0,0.000000,0> translate<45.504900,-1.535000,21.132800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.505000,-1.535000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,9.347200>}
box{<0,0,-0.203200><3.212200,0.035000,0.203200> rotate<0,0.000000,0> translate<45.505000,-1.535000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.911300,-1.535000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,20.726400>}
box{<0,0,-0.203200><2.805900,0.035000,0.203200> rotate<0,0.000000,0> translate<45.911300,-1.535000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<45.911400,-1.535000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,9.753600>}
box{<0,0,-0.203200><2.805800,0.035000,0.203200> rotate<0,0.000000,0> translate<45.911400,-1.535000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.317700,-1.535000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,20.320000>}
box{<0,0,-0.203200><2.399500,0.035000,0.203200> rotate<0,0.000000,0> translate<46.317700,-1.535000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.317800,-1.535000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,10.160000>}
box{<0,0,-0.203200><2.399400,0.035000,0.203200> rotate<0,0.000000,0> translate<46.317800,-1.535000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.468100,-1.535000,20.169600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.839600,-1.535000,19.798100>}
box{<0,0,-0.203200><0.525380,0.035000,0.203200> rotate<0,44.997030,0> translate<46.468100,-1.535000,20.169600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.724100,-1.535000,19.913600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,19.913600>}
box{<0,0,-0.203200><1.993100,0.035000,0.203200> rotate<0,0.000000,0> translate<46.724100,-1.535000,19.913600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.724200,-1.535000,10.566400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,10.566400>}
box{<0,0,-0.203200><1.993000,0.035000,0.203200> rotate<0,0.000000,0> translate<46.724200,-1.535000,10.566400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.839600,-1.535000,10.681800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.040700,-1.535000,11.167200>}
box{<0,0,-0.203200><0.525409,0.035000,0.203200> rotate<0,-67.491441,0> translate<46.839600,-1.535000,10.681800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.839600,-1.535000,19.798100>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.040700,-1.535000,19.312700>}
box{<0,0,-0.203200><0.525409,0.035000,0.203200> rotate<0,67.491441,0> translate<46.839600,-1.535000,19.798100> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.960100,-1.535000,10.972800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,10.972800>}
box{<0,0,-0.203200><1.757100,0.035000,0.203200> rotate<0,0.000000,0> translate<46.960100,-1.535000,10.972800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<46.960200,-1.535000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,19.507200>}
box{<0,0,-0.203200><1.757000,0.035000,0.203200> rotate<0,0.000000,0> translate<46.960200,-1.535000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.040700,-1.535000,11.167200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.040700,-1.535000,11.692700>}
box{<0,0,-0.203200><0.525500,0.035000,0.203200> rotate<0,90.000000,0> translate<47.040700,-1.535000,11.692700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.040700,-1.535000,11.379200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,11.379200>}
box{<0,0,-0.203200><1.676500,0.035000,0.203200> rotate<0,0.000000,0> translate<47.040700,-1.535000,11.379200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.040700,-1.535000,11.692700>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.040700,-1.535000,19.312700>}
box{<0,0,-0.203200><7.620000,0.035000,0.203200> rotate<0,90.000000,0> translate<47.040700,-1.535000,19.312700> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.040700,-1.535000,11.785600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,11.785600>}
box{<0,0,-0.203200><1.676500,0.035000,0.203200> rotate<0,0.000000,0> translate<47.040700,-1.535000,11.785600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.040700,-1.535000,12.192000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,12.192000>}
box{<0,0,-0.203200><1.676500,0.035000,0.203200> rotate<0,0.000000,0> translate<47.040700,-1.535000,12.192000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.040700,-1.535000,12.598400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,12.598400>}
box{<0,0,-0.203200><1.676500,0.035000,0.203200> rotate<0,0.000000,0> translate<47.040700,-1.535000,12.598400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.040700,-1.535000,13.004800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,13.004800>}
box{<0,0,-0.203200><1.676500,0.035000,0.203200> rotate<0,0.000000,0> translate<47.040700,-1.535000,13.004800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.040700,-1.535000,13.411200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,13.411200>}
box{<0,0,-0.203200><1.676500,0.035000,0.203200> rotate<0,0.000000,0> translate<47.040700,-1.535000,13.411200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.040700,-1.535000,13.817600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,13.817600>}
box{<0,0,-0.203200><1.676500,0.035000,0.203200> rotate<0,0.000000,0> translate<47.040700,-1.535000,13.817600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.040700,-1.535000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,14.224000>}
box{<0,0,-0.203200><1.676500,0.035000,0.203200> rotate<0,0.000000,0> translate<47.040700,-1.535000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.040700,-1.535000,14.630400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,14.630400>}
box{<0,0,-0.203200><1.676500,0.035000,0.203200> rotate<0,0.000000,0> translate<47.040700,-1.535000,14.630400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.040700,-1.535000,15.036800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,15.036800>}
box{<0,0,-0.203200><1.676500,0.035000,0.203200> rotate<0,0.000000,0> translate<47.040700,-1.535000,15.036800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.040700,-1.535000,15.443200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,15.443200>}
box{<0,0,-0.203200><1.676500,0.035000,0.203200> rotate<0,0.000000,0> translate<47.040700,-1.535000,15.443200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.040700,-1.535000,15.849600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,15.849600>}
box{<0,0,-0.203200><1.676500,0.035000,0.203200> rotate<0,0.000000,0> translate<47.040700,-1.535000,15.849600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.040700,-1.535000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,16.256000>}
box{<0,0,-0.203200><1.676500,0.035000,0.203200> rotate<0,0.000000,0> translate<47.040700,-1.535000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.040700,-1.535000,16.662400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,16.662400>}
box{<0,0,-0.203200><1.676500,0.035000,0.203200> rotate<0,0.000000,0> translate<47.040700,-1.535000,16.662400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.040700,-1.535000,17.068800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,17.068800>}
box{<0,0,-0.203200><1.676500,0.035000,0.203200> rotate<0,0.000000,0> translate<47.040700,-1.535000,17.068800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.040700,-1.535000,17.475200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,17.475200>}
box{<0,0,-0.203200><1.676500,0.035000,0.203200> rotate<0,0.000000,0> translate<47.040700,-1.535000,17.475200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.040700,-1.535000,17.881600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,17.881600>}
box{<0,0,-0.203200><1.676500,0.035000,0.203200> rotate<0,0.000000,0> translate<47.040700,-1.535000,17.881600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.040700,-1.535000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,18.288000>}
box{<0,0,-0.203200><1.676500,0.035000,0.203200> rotate<0,0.000000,0> translate<47.040700,-1.535000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.040700,-1.535000,18.694400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,18.694400>}
box{<0,0,-0.203200><1.676500,0.035000,0.203200> rotate<0,0.000000,0> translate<47.040700,-1.535000,18.694400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<47.040700,-1.535000,19.100800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,19.100800>}
box{<0,0,-0.203200><1.676500,0.035000,0.203200> rotate<0,0.000000,0> translate<47.040700,-1.535000,19.100800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,32.918400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<48.717200,-1.535000,0.812700>}
box{<0,0,-0.203200><32.105700,0.035000,0.203200> rotate<0,-90.000000,0> translate<48.717200,-1.535000,0.812700> }
texture{col_pol}
}
#end
union{
cylinder{<7.620000,0.038000,22.860000><7.620000,-1.538000,22.860000>0.406400}
cylinder{<7.620000,0.038000,25.400000><7.620000,-1.538000,25.400000>0.406400}
cylinder{<17.780000,0.038000,27.940000><17.780000,-1.538000,27.940000>0.406400}
cylinder{<17.780000,0.038000,20.320000><17.780000,-1.538000,20.320000>0.406400}
cylinder{<36.830000,0.038000,26.670000><36.830000,-1.538000,26.670000>0.406400}
cylinder{<34.290000,0.038000,26.670000><34.290000,-1.538000,26.670000>0.406400}
cylinder{<35.560000,0.038000,6.350000><35.560000,-1.538000,6.350000>0.406400}
cylinder{<35.560000,0.038000,8.890000><35.560000,-1.538000,8.890000>0.406400}
cylinder{<12.700000,0.038000,10.160000><12.700000,-1.538000,10.160000>0.406400}
cylinder{<13.970000,0.038000,8.255000><13.970000,-1.538000,8.255000>0.406400}
cylinder{<15.240000,0.038000,10.160000><15.240000,-1.538000,10.160000>0.406400}
cylinder{<29.210000,0.038000,24.130000><29.210000,-1.538000,24.130000>0.406400}
cylinder{<27.305000,0.038000,22.860000><27.305000,-1.538000,22.860000>0.406400}
cylinder{<29.210000,0.038000,21.590000><29.210000,-1.538000,21.590000>0.406400}
cylinder{<12.700000,0.038000,27.940000><12.700000,-1.538000,27.940000>0.406400}
cylinder{<12.700000,0.038000,17.780000><12.700000,-1.538000,17.780000>0.406400}
cylinder{<11.430000,0.038000,3.810000><11.430000,-1.538000,3.810000>0.406400}
cylinder{<21.590000,0.038000,3.810000><21.590000,-1.538000,3.810000>0.406400}
cylinder{<33.020000,0.038000,22.860000><33.020000,-1.538000,22.860000>0.406400}
cylinder{<33.020000,0.038000,12.700000><33.020000,-1.538000,12.700000>0.406400}
cylinder{<16.510000,0.038000,16.510000><16.510000,-1.538000,16.510000>0.406400}
cylinder{<26.670000,0.038000,16.510000><26.670000,-1.538000,16.510000>0.406400}
cylinder{<24.130000,0.038000,19.050000><24.130000,-1.538000,19.050000>0.406400}
cylinder{<24.130000,0.038000,29.210000><24.130000,-1.538000,29.210000>0.406400}
cylinder{<38.100000,0.038000,22.860000><38.100000,-1.538000,22.860000>0.406400}
cylinder{<38.100000,0.038000,12.700000><38.100000,-1.538000,12.700000>0.406400}
cylinder{<25.400000,0.038000,2.540000><25.400000,-1.538000,2.540000>0.406400}
cylinder{<25.400000,0.038000,12.700000><25.400000,-1.538000,12.700000>0.406400}
cylinder{<6.350000,0.038000,6.350000><6.350000,-1.538000,6.350000>0.508000}
cylinder{<6.350000,0.038000,8.890000><6.350000,-1.538000,8.890000>0.508000}
cylinder{<6.350000,0.038000,11.430000><6.350000,-1.538000,11.430000>0.508000}
cylinder{<6.350000,0.038000,13.970000><6.350000,-1.538000,13.970000>0.508000}
cylinder{<6.350000,0.038000,16.510000><6.350000,-1.538000,16.510000>0.508000}
cylinder{<43.180000,0.038000,12.700000><43.180000,-1.538000,12.700000>0.508000}
cylinder{<43.180000,0.038000,15.240000><43.180000,-1.538000,15.240000>0.508000}
cylinder{<43.180000,0.038000,17.780000><43.180000,-1.538000,17.780000>0.508000}
cylinder{<43.180000,0.038000,20.320000><43.180000,-1.538000,20.320000>0.508000}
//Holes(fast)/Vias
//Holes(fast)/Board
texture{col_hls}
}
#if(pcb_silkscreen=on)
//Silk Screen
union{
//C1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,22.479000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,22.733000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<6.350000,0.000000,22.733000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.604000,0.000000,22.733000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,22.733000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.350000,0.000000,22.733000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,22.733000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,22.987000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,90.000000,0> translate<6.350000,0.000000,22.987000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,22.733000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.096000,0.000000,22.733000>}
box{<0,0,-0.076200><0.254000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.096000,0.000000,22.733000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,22.479000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,23.368000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,90.000000,0> translate<7.620000,0.000000,23.368000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,23.368000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,23.368000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<7.620000,0.000000,23.368000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,23.368000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,23.876000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<8.890000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,23.876000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.350000,0.000000,23.876000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,23.876000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,23.368000>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<6.350000,0.000000,23.368000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.350000,0.000000,23.368000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,23.368000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<6.350000,0.000000,23.368000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,25.781000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,90.000000,0> translate<7.620000,0.000000,25.781000> }
difference{
cylinder{<7.620000,0,24.130000><7.620000,0.036000,24.130000>2.616200 translate<0,0.000000,0>}
cylinder{<7.620000,-0.1,24.130000><7.620000,0.135000,24.130000>2.463800 translate<0,0.000000,0>}}
box{<-0.254000,0,-1.270000><0.254000,0.036000,1.270000> rotate<0,-90.000000,0> translate<7.620000,0.000000,24.638000>}
//D1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<17.780000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<17.780000,0.000000,27.051000>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<17.780000,0.000000,27.051000> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<17.780000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<17.780000,0.000000,21.209000>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,90.000000,0> translate<17.780000,0.000000,21.209000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,24.130000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,90.000000,0> translate<17.780000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.415000,0.000000,25.146000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.145000,0.000000,25.146000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.415000,0.000000,25.146000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,24.130000>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,-57.990789,0> translate<17.780000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,25.654000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<17.780000,0.000000,25.654000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,25.146000>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,57.990789,0> translate<17.145000,0.000000,25.146000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.145000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,24.130000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.145000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.780000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.415000,0.000000,24.130000>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.780000,0.000000,24.130000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<17.018000,0.000000,26.162000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.018000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.542000,0.000000,26.416000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.018000,0.000000,26.416000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<18.542000,0.000000,26.162000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<17.018000,0.000000,22.098000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<18.542000,0.000000,22.098000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,22.098000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.796000,0.000000,26.162000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,90.000000,0> translate<18.796000,0.000000,26.162000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.018000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.542000,0.000000,21.844000>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.018000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,22.098000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,26.162000>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,90.000000,0> translate<16.764000,0.000000,26.162000> }
box{<-0.254000,0,-1.016000><0.254000,0.036000,1.016000> rotate<0,-90.000000,0> translate<17.780000,0.000000,22.479000>}
box{<-0.317500,0,-0.254000><0.317500,0.036000,0.254000> rotate<0,-90.000000,0> translate<17.780000,0.000000,26.733500>}
box{<-0.317500,0,-0.254000><0.317500,0.036000,0.254000> rotate<0,-90.000000,0> translate<17.780000,0.000000,21.526500>}
//LED1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.020000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.020000,0.000000,24.765000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,-90.000000,0> translate<33.020000,0.000000,24.765000> }
object{ARC(3.175000,0.254000,216.869898,503.130102,0.036000) translate<35.560000,0.000000,26.670000>}
object{ARC(1.143000,0.152400,270.000000,360.000000,0.036000) translate<35.560000,0.000000,26.670000>}
object{ARC(1.143000,0.152400,90.000000,180.000000,0.036000) translate<35.560000,0.000000,26.670000>}
object{ARC(1.651000,0.152400,270.000000,360.000000,0.036000) translate<35.560000,0.000000,26.670000>}
object{ARC(1.651000,0.152400,90.000000,180.000000,0.036000) translate<35.560000,0.000000,26.670000>}
object{ARC(2.159000,0.152400,270.000000,360.000000,0.036000) translate<35.560000,0.000000,26.670000>}
object{ARC(2.159000,0.152400,90.000000,180.000000,0.036000) translate<35.560000,0.000000,26.670000>}
difference{
cylinder{<35.560000,0,26.670000><35.560000,0.036000,26.670000>2.616200 translate<0,0.000000,0>}
cylinder{<35.560000,-0.1,26.670000><35.560000,0.135000,26.670000>2.463800 translate<0,0.000000,0>}}
//LED2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<37.465000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<33.655000,0.000000,10.160000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,0.000000,0> translate<33.655000,0.000000,10.160000> }
object{ARC(3.175000,0.254000,126.869898,413.130102,0.036000) translate<35.560000,0.000000,7.620000>}
object{ARC(1.143000,0.152400,180.000000,270.000000,0.036000) translate<35.560000,0.000000,7.620000>}
object{ARC(1.143000,0.152400,0.000000,90.000000,0.036000) translate<35.560000,0.000000,7.620000>}
object{ARC(1.651000,0.152400,180.000000,270.000000,0.036000) translate<35.560000,0.000000,7.620000>}
object{ARC(1.651000,0.152400,0.000000,90.000000,0.036000) translate<35.560000,0.000000,7.620000>}
object{ARC(2.159000,0.152400,180.000000,270.000000,0.036000) translate<35.560000,0.000000,7.620000>}
object{ARC(2.159000,0.152400,0.000000,90.000000,0.036000) translate<35.560000,0.000000,7.620000>}
difference{
cylinder{<35.560000,0,7.620000><35.560000,0.036000,7.620000>2.616200 translate<0,0.000000,0>}
cylinder{<35.560000,-0.1,7.620000><35.560000,0.135000,7.620000>2.463800 translate<0,0.000000,0>}}
//Q1 silk screen
object{ARC(2.667000,0.152400,287.146796,398.245791,0.036000) translate<13.970000,0.000000,10.160000>}
object{ARC(2.666900,0.152400,141.752879,252.852571,0.036000) translate<13.969500,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.065000,0.000000,11.811000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.875000,0.000000,11.811000>}
box{<0,0,-0.076200><4.190000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.875000,0.000000,11.811000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.224000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.256000,0.000000,10.414000>}
box{<0,0,-0.076200><1.968000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.256000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.625000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.224000,0.000000,10.414000>}
box{<0,0,-0.076200><0.401000,0.036000,0.076200> rotate<0,0.000000,0> translate<16.224000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.256000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.684000,0.000000,10.414000>}
box{<0,0,-0.076200><0.572000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.684000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.716000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.315000,0.000000,10.414000>}
box{<0,0,-0.076200><0.401000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.315000,0.000000,10.414000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.684000,0.000000,10.414000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.716000,0.000000,10.414000>}
box{<0,0,-0.076200><1.968000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.716000,0.000000,10.414000> }
object{ARC(2.667000,0.152400,252.853204,287.146796,0.036000) translate<13.970000,0.000000,10.160000>}
//Q2 silk screen
object{ARC(2.667000,0.127000,275.462839,308.244104,0.036000) translate<29.210100,0.000000,22.860000>}
object{ARC(2.667000,0.127000,197.146796,275.464977,0.036000) translate<29.210000,0.000000,22.860000>}
object{ARC(2.666900,0.127000,51.752879,162.852571,0.036000) translate<29.210000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<30.861000,0.000000,20.765500>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<30.861000,0.000000,24.954500>}
box{<0,0,-0.063500><4.189000,0.036000,0.063500> rotate<0,90.000000,0> translate<30.861000,0.000000,24.954500> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.464000,0.000000,20.606300>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.464000,0.000000,22.573700>}
box{<0,0,-0.063500><1.967400,0.036000,0.063500> rotate<0,90.000000,0> translate<29.464000,0.000000,22.573700> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.464000,0.000000,20.205100>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.464000,0.000000,20.606300>}
box{<0,0,-0.063500><0.401200,0.036000,0.063500> rotate<0,90.000000,0> translate<29.464000,0.000000,20.606300> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.464000,0.000000,22.573700>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.464000,0.000000,23.146300>}
box{<0,0,-0.063500><0.572600,0.036000,0.063500> rotate<0,90.000000,0> translate<29.464000,0.000000,23.146300> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.464000,0.000000,25.113700>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.464000,0.000000,25.514900>}
box{<0,0,-0.063500><0.401200,0.036000,0.063500> rotate<0,90.000000,0> translate<29.464000,0.000000,25.514900> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.464000,0.000000,23.146300>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.464000,0.000000,25.113700>}
box{<0,0,-0.063500><1.967400,0.036000,0.063500> rotate<0,90.000000,0> translate<29.464000,0.000000,25.113700> }
object{ARC(2.667000,0.127000,162.853204,197.146796,0.036000) translate<29.210000,0.000000,22.860000>}
//R1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<12.700000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<12.700000,0.000000,18.796000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<12.700000,0.000000,18.796000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<12.700000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<12.700000,0.000000,26.924000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<12.700000,0.000000,26.924000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<13.589000,0.000000,25.781000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<11.811000,0.000000,25.781000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<11.811000,0.000000,19.939000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<13.589000,0.000000,19.939000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.811000,0.000000,26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.589000,0.000000,26.035000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.811000,0.000000,26.035000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.843000,0.000000,25.781000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.843000,0.000000,25.400000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<13.843000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,25.273000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.843000,0.000000,25.400000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<13.716000,0.000000,25.273000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.557000,0.000000,25.781000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.557000,0.000000,25.400000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<11.557000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,25.273000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.557000,0.000000,25.400000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<11.557000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,20.447000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.843000,0.000000,20.320000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<13.716000,0.000000,20.447000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,20.447000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.716000,0.000000,25.273000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.716000,0.000000,25.273000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,20.447000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.557000,0.000000,20.320000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<11.557000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,20.447000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.684000,0.000000,25.273000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<11.684000,0.000000,25.273000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.843000,0.000000,19.939000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.843000,0.000000,20.320000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.843000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.557000,0.000000,19.939000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.557000,0.000000,20.320000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<11.557000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.811000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.589000,0.000000,19.685000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.811000,0.000000,19.685000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<12.700000,0.000000,19.253200>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<12.700000,0.000000,26.466800>}
//R2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<21.590000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<20.574000,0.000000,3.810000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<20.574000,0.000000,3.810000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<11.430000,0.000000,3.810000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<12.446000,0.000000,3.810000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<11.430000,0.000000,3.810000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<13.589000,0.000000,4.699000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<13.589000,0.000000,2.921000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<19.431000,0.000000,2.921000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<19.431000,0.000000,4.699000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.335000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.335000,0.000000,4.699000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<13.335000,0.000000,4.699000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.589000,0.000000,4.953000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,4.953000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.589000,0.000000,4.953000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.097000,0.000000,4.826000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,4.953000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<13.970000,0.000000,4.953000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.589000,0.000000,2.667000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,2.667000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.589000,0.000000,2.667000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.097000,0.000000,2.794000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.970000,0.000000,2.667000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<13.970000,0.000000,2.667000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.923000,0.000000,4.826000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.050000,0.000000,4.953000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<18.923000,0.000000,4.826000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.923000,0.000000,4.826000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.097000,0.000000,4.826000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.097000,0.000000,4.826000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.923000,0.000000,2.794000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.050000,0.000000,2.667000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<18.923000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.923000,0.000000,2.794000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.097000,0.000000,2.794000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.097000,0.000000,2.794000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.431000,0.000000,4.953000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.050000,0.000000,4.953000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.050000,0.000000,4.953000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.431000,0.000000,2.667000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.050000,0.000000,2.667000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.050000,0.000000,2.667000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.685000,0.000000,2.921000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.685000,0.000000,4.699000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<19.685000,0.000000,4.699000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<20.116800,0.000000,3.810000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<12.903200,0.000000,3.810000>}
//R3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<33.020000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<33.020000,0.000000,13.716000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<33.020000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<33.020000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<33.020000,0.000000,21.844000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<33.020000,0.000000,21.844000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<33.909000,0.000000,20.701000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<32.131000,0.000000,20.701000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<32.131000,0.000000,14.859000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<33.909000,0.000000,14.859000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.131000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.909000,0.000000,20.955000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.131000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.163000,0.000000,20.701000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.163000,0.000000,20.320000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<34.163000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.036000,0.000000,20.193000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.163000,0.000000,20.320000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<34.036000,0.000000,20.193000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.877000,0.000000,20.701000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.877000,0.000000,20.320000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<31.877000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.004000,0.000000,20.193000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.877000,0.000000,20.320000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<31.877000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.036000,0.000000,15.367000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.163000,0.000000,15.240000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<34.036000,0.000000,15.367000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.036000,0.000000,15.367000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.036000,0.000000,20.193000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<34.036000,0.000000,20.193000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.004000,0.000000,15.367000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.877000,0.000000,15.240000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<31.877000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.004000,0.000000,15.367000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.004000,0.000000,20.193000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<32.004000,0.000000,20.193000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.163000,0.000000,14.859000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.163000,0.000000,15.240000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<34.163000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.877000,0.000000,14.859000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.877000,0.000000,15.240000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<31.877000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.131000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.909000,0.000000,14.605000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.131000,0.000000,14.605000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<33.020000,0.000000,14.173200>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<33.020000,0.000000,21.386800>}
//R4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<26.670000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<25.654000,0.000000,16.510000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<25.654000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<16.510000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<17.526000,0.000000,16.510000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<16.510000,0.000000,16.510000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<18.669000,0.000000,17.399000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<18.669000,0.000000,15.621000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<24.511000,0.000000,15.621000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<24.511000,0.000000,17.399000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.415000,0.000000,15.621000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.415000,0.000000,17.399000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<18.415000,0.000000,17.399000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.669000,0.000000,17.653000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.050000,0.000000,17.653000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<18.669000,0.000000,17.653000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.177000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.050000,0.000000,17.653000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<19.050000,0.000000,17.653000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.669000,0.000000,15.367000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.050000,0.000000,15.367000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<18.669000,0.000000,15.367000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.177000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.050000,0.000000,15.367000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<19.050000,0.000000,15.367000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.003000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.130000,0.000000,17.653000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<24.003000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.003000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.177000,0.000000,17.526000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.177000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.003000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.130000,0.000000,15.367000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<24.003000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.003000,0.000000,15.494000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<19.177000,0.000000,15.494000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<19.177000,0.000000,15.494000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.511000,0.000000,17.653000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.130000,0.000000,17.653000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.130000,0.000000,17.653000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.511000,0.000000,15.367000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.130000,0.000000,15.367000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.130000,0.000000,15.367000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,15.621000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.765000,0.000000,17.399000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<24.765000,0.000000,17.399000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<25.196800,0.000000,16.510000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<17.983200,0.000000,16.510000>}
//R5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<24.130000,0.000000,29.210000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<24.130000,0.000000,28.194000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<24.130000,0.000000,28.194000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<24.130000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<24.130000,0.000000,20.066000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<24.130000,0.000000,20.066000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<23.241000,0.000000,21.209000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<25.019000,0.000000,21.209000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<25.019000,0.000000,27.051000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<23.241000,0.000000,27.051000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.019000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.241000,0.000000,20.955000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.241000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.987000,0.000000,21.209000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.987000,0.000000,21.590000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<22.987000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.114000,0.000000,21.717000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.987000,0.000000,21.590000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<22.987000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.273000,0.000000,21.209000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.273000,0.000000,21.590000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<25.273000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.146000,0.000000,21.717000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.273000,0.000000,21.590000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<25.146000,0.000000,21.717000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.114000,0.000000,26.543000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.987000,0.000000,26.670000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<22.987000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.114000,0.000000,26.543000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.114000,0.000000,21.717000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<23.114000,0.000000,21.717000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.146000,0.000000,26.543000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.273000,0.000000,26.670000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<25.146000,0.000000,26.543000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.146000,0.000000,26.543000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.146000,0.000000,21.717000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<25.146000,0.000000,21.717000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.987000,0.000000,27.051000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.987000,0.000000,26.670000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<22.987000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.273000,0.000000,27.051000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.273000,0.000000,26.670000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<25.273000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.019000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.241000,0.000000,27.305000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<23.241000,0.000000,27.305000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<24.130000,0.000000,27.736800>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<24.130000,0.000000,20.523200>}
//R6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<38.100000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<38.100000,0.000000,13.716000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<38.100000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<38.100000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<38.100000,0.000000,21.844000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<38.100000,0.000000,21.844000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<38.989000,0.000000,20.701000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<37.211000,0.000000,20.701000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<37.211000,0.000000,14.859000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<38.989000,0.000000,14.859000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.211000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.989000,0.000000,20.955000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<37.211000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.243000,0.000000,20.701000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.243000,0.000000,20.320000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<39.243000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.116000,0.000000,20.193000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.243000,0.000000,20.320000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<39.116000,0.000000,20.193000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.957000,0.000000,20.701000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.957000,0.000000,20.320000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<36.957000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.084000,0.000000,20.193000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.957000,0.000000,20.320000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<36.957000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.116000,0.000000,15.367000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.243000,0.000000,15.240000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<39.116000,0.000000,15.367000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.116000,0.000000,15.367000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.116000,0.000000,20.193000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<39.116000,0.000000,20.193000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.084000,0.000000,15.367000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.957000,0.000000,15.240000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<36.957000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.084000,0.000000,15.367000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.084000,0.000000,20.193000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<37.084000,0.000000,20.193000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.243000,0.000000,14.859000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.243000,0.000000,15.240000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<39.243000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.957000,0.000000,14.859000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.957000,0.000000,15.240000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<36.957000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.211000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.989000,0.000000,14.605000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<37.211000,0.000000,14.605000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<38.100000,0.000000,14.173200>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<38.100000,0.000000,21.386800>}
//R7 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<25.400000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<25.400000,0.000000,11.684000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<25.400000,0.000000,11.684000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<25.400000,0.000000,2.540000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<25.400000,0.000000,3.556000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<25.400000,0.000000,3.556000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<24.511000,0.000000,4.699000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<26.289000,0.000000,4.699000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<26.289000,0.000000,10.541000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<24.511000,0.000000,10.541000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.289000,0.000000,4.445000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.511000,0.000000,4.445000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.511000,0.000000,4.445000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.257000,0.000000,4.699000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.257000,0.000000,5.080000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<24.257000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,5.207000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.257000,0.000000,5.080000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<24.257000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.543000,0.000000,4.699000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.543000,0.000000,5.080000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<26.543000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,5.207000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.543000,0.000000,5.080000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<26.416000,0.000000,5.207000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,10.033000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.257000,0.000000,10.160000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<24.257000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,10.033000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.384000,0.000000,5.207000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.384000,0.000000,5.207000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,10.033000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.543000,0.000000,10.160000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<26.416000,0.000000,10.033000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,10.033000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.416000,0.000000,5.207000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<26.416000,0.000000,5.207000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.257000,0.000000,10.541000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.257000,0.000000,10.160000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.257000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.543000,0.000000,10.541000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.543000,0.000000,10.160000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<26.543000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.289000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.511000,0.000000,10.795000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.511000,0.000000,10.795000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<25.400000,0.000000,11.226800>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<25.400000,0.000000,4.013200>}
//SV1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,6.985000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.080000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,7.620000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<5.080000,0.000000,6.985000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,6.985000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<6.985000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,8.255000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<5.080000,0.000000,8.255000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,9.525000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.080000,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,10.160000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<5.080000,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,9.525000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<6.985000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,8.255000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<7.620000,0.000000,8.255000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,7.620000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<6.985000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,5.080000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.715000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,5.715000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,5.080000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<5.080000,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,5.080000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,5.715000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<6.985000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,6.985000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,5.715000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<7.620000,0.000000,5.715000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,10.795000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<5.080000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,12.065000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.080000,0.000000,12.065000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,12.065000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,12.700000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<5.080000,0.000000,12.065000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,12.065000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<6.985000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,12.065000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,10.795000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<7.620000,0.000000,10.795000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,10.160000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<6.985000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,14.605000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.080000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,15.240000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<5.080000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,14.605000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<6.985000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,15.875000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<5.080000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,17.145000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<5.080000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,17.780000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<5.080000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,17.780000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<5.715000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,17.145000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<6.985000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,15.875000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<7.620000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,15.240000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<6.985000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.080000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<5.715000,0.000000,12.700000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<5.080000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<6.985000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,13.335000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<6.985000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<7.620000,0.000000,13.335000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<7.620000,0.000000,13.335000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<6.350000,0.000000,8.890000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<6.350000,0.000000,6.350000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<6.350000,0.000000,11.430000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<6.350000,0.000000,16.510000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<6.350000,0.000000,13.970000>}
//SV2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,12.065000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,13.335000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<41.910000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,13.970000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<41.910000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,13.335000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<43.815000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,14.605000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<41.910000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,15.875000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<41.910000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,16.510000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<41.910000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,15.875000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<43.815000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,14.605000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.450000,0.000000,14.605000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,14.605000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,13.970000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<43.815000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,11.430000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,11.430000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<42.545000,0.000000,11.430000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,12.065000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,11.430000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<41.910000,0.000000,12.065000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,11.430000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,12.065000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<43.815000,0.000000,11.430000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,12.065000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.450000,0.000000,12.065000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,17.145000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<41.910000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,18.415000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<41.910000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,19.050000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<41.910000,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,18.415000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<43.815000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,17.145000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.450000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,16.510000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<43.815000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,20.955000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<41.910000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,21.590000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<41.910000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,21.590000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<42.545000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,20.955000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<43.815000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,19.050000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<41.910000,0.000000,19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,19.685000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<43.815000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,19.685000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.450000,0.000000,19.685000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<43.180000,0.000000,15.240000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<43.180000,0.000000,12.700000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<43.180000,0.000000,17.780000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<43.180000,0.000000,20.320000>}
texture{col_slk}
}
#end
translate<mac_x_ver,mac_y_ver,mac_z_ver>
rotate<mac_x_rot,mac_y_rot,mac_z_rot>
}//End union
#end

#if(use_file_as_inc=off)
object{  RS232TOTTL(-24.765000,0,-16.865600,pcb_rotate_x,pcb_rotate_y,pcb_rotate_z)
#if(pcb_upsidedown=on)
rotate pcb_rotdir*180
#end
}
#end


//Parts not found in 3dpack.dat or 3dusrpac.dat are:
