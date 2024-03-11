#importing the design
source myscripts/importdesign2

set_io_flow_flag 0 #why

#specify Floorplan
create_floorplan -site CoreSite -die_size 8157.38 8154.0 120 120 120 120

#Placing Hard Macros
  #Matrix1
  #Select ram0 for relative floorplan with core boundary
select_obj [get_db insts *ram0/ram0]
create_relative_floorplan -place coreinst/ks_core1/amba_dsp1/ram2p_78kx32/ram0/ram0 -ref_type core_boundary -horizontal_edge_separate {2  -30  2} -vertical_edge_separate {2  -30  2}
delete_relative_floorplan -all
  #Relative Floorplan.
source amMaker.tcl

  #Matrix2
select_obj [get_db insts *ram0/ram0]
create_relative_floorplan -place coreinst/ks_core2/amba_dsp1/ram2p_78kx32/ram0/ram0 -ref_type core_boundary -horizontal_edge_separate {2  -3850  2} -vertical_edge_separate {2  -30  2}
delete_relative_floorplan -all

source amMaker2.tcl 

#core1
# Place block coreinst/ks_core1/periph1_PH
place_inst coreinst/ks_core1/periph1_PH 787 4700.45 r0
# Place block coreinst/ks_core1/leon1
place_inst coreinst/ks_core1/leon1 {4546 4449} r0 -fixed

#core2
place_inst coreinst/ks_core2/periph1_PH 787 884 r0
place_inst coreinst/ks_core2/leon1 {4546 705} r0 -fixed
# Place remaining blocks
#core1
place_inst coreinst/ks_core1/amba_dsp1/mcore0/proc0/cmem0/itags0/u0/id0 {787 4463.27} r0 -fixed
place_inst coreinst/ks_core1/amba_dsp1/mcore0/proc0/cmem0/ddata0/u0/id0 {787 4318.27} r0 -fixed
place_inst coreinst/ks_core1/amba_dsp1/mcore0/proc0/cmem0/idata0/u0/id0 {1244 4463.27} r0 -fixed
place_inst coreinst/ks_core1/amba_dsp1/mcore0/proc0/cmem0/dtags0/u0/id0 {1244 4318.27} r0 -fixed
place_inst coreinst/ks_core1/amba_dsp1/mcore0/proc0/rf0/u0/u1 {1697 4318.27} r0 -fixed
place_inst coreinst/ks_core1/amba_dsp1/mcore0/proc0/rf0/u0/u0 {2138 4318.27} r0 -fixed
place_inst coreinst/ks_core1/amba_dsp1/rom2p_2kx32/ram0 {2600 4318.27} r0 -fixed
place_inst coreinst/ks_core1/amba_dsp1/ram2p_78kx32/ram0/ram19 {2904.99 5386.15} r0 -fixed
#CORE2
place_inst coreinst/ks_core2/amba_dsp1/mcore0/proc0/cmem0/itags0/u0/id0 {787 646.27} r0 -fixed
place_inst coreinst/ks_core2/amba_dsp1/mcore0/proc0/cmem0/ddata0/u0/id0 {787 501.27} r0 -fixed
place_inst coreinst/ks_core2/amba_dsp1/mcore0/proc0/cmem0/idata0/u0/id0 {1244 646.27} r0 -fixed
place_inst coreinst/ks_core2/amba_dsp1/mcore0/proc0/cmem0/dtags0/u0/id0 {1244 501.27} r0 -fixed
place_inst coreinst/ks_core2/amba_dsp1/mcore0/proc0/rf0/u0/u1 {1697 501.27} r0 -fixed
place_inst coreinst/ks_core2/amba_dsp1/mcore0/proc0/rf0/u0/u0 {2138 501.27} r0 -fixed
place_inst coreinst/ks_core2/amba_dsp1/rom2p_2kx32/ram0 {2600 501.27} r0 -fixed
place_inst coreinst/ks_core2/amba_dsp1/ram2p_78kx32/ram0/ram19 {2904.99 1572.675} r0 -fixed


write_db DBS/blocks.enc

check_floorplan -report_density

#resizing_fp
set_resize_line -clear_all
set_resize_line -direction V (502.1285 276.726) (502.1285 7915.8485) -width -500
set_resize_line -clear_all
set_db resize_floorplan_io_relative true
set_db resize_floorplan_honor_halo true
set_db resize_floorplan_shrink_fence false
set_db resize_floorplan_snap_to_track true
set_db resize_floorplan_shift_based true
set_resize_line -direction V (502.1285 276.726) (502.1285 7915.8485) -width -500
resize_floorplan -x_size -500

#Placing Halo around blocks
create_place_halo -halo_deltas {5 5 5 5} -all_blocks

#Using placement blockage
#core1
create_place_blockage -area 4036.10350 4803.59350 7410.20850 4975.75550 -type hard
create_place_blockage -area 2086.79900 5113.00050 2675.21850 5608.35400 -type hard
##n tem certeza
set_db finish_floorplan_active_objs {core macro soft_blockage} ; set_db finish_floorplan_drc_region_objs {macro macro_halo hard_blockage min_gap core_spacing} ; set_db finish_floorplan_add_blockage_direction xy ; set_db finish_floorplan_override false

#core2
create_place_blockage -area 4036.26400 940.07050 7409.32000 1174.71800 -type hard
create_place_blockage -area 2084.83200 1294.92850 2699.80350 1810.17500 -type hard
##n tem certeza
set_db finish_floorplan_active_objs {core macro soft_blockage} ; set_db finish_floorplan_drc_region_objs {macro macro_halo hard_blockage min_gap core_spacing} ; set_db finish_floorplan_add_blockage_direction xy ; set_db finish_floorplan_override false

#Automatic Floorplan- Finish Floorplan
finish_floorplan -fill_place_blockage soft 40

write_db DBS/floorplan.enc

#Module3
#Connecting global nets

connect_global_net VDD -type pg_pin -pin_base_name VDD -all
connect_global_net VSS -type pg_pin -pin_base_name VSS -all
connect_global_net VSS -type tie_lo
connect_global_net VDD -type tie_hi

#Adding Power Rings

set_db add_rings_target default ; set_db add_rings_extend_over_row 0 ; set_db add_rings_ignore_rows 0 ; set_db add_rings_avoid_short 0 ; set_db add_rings_skip_shared_inner_ring none ; set_db add_rings_stacked_via_top_layer Metal9 ; set_db add_rings_stacked_via_bottom_layer Metal1 ; set_db add_rings_via_using_exact_crossover_size 1 ; set_db add_rings_orthogonal_only true ; set_db add_rings_skip_via_on_pin {  standardcell } ; set_db add_rings_skip_via_on_wire_shape {  noshape }
add_rings -nets {} -type core_rings -follow core -layer {top Metal9 bottom Metal9 left Metal8 right Metal8} -width {top 5 bottom 5 left 5 right 5} -spacing {top 1.25 bottom 1.25 left 1.25 right 1.25} -offset {top 5 bottom 5 left 5 right 5} -center 0 -extend_corners {} -threshold 0 -jog_distance 0 -snap_wire_center_to_grid none

set_db add_rings_target default ; set_db add_rings_extend_over_row 0 ; set_db add_rings_ignore_rows 0 ; set_db add_rings_avoid_short 0 ; set_db add_rings_skip_shared_inner_ring none ; set_db add_rings_stacked_via_top_layer Metal9 ; set_db add_rings_stacked_via_bottom_layer Metal1 ; set_db add_rings_via_using_exact_crossover_size 1 ; set_db add_rings_orthogonal_only true ; set_db add_rings_skip_via_on_pin {  standardcell } ; set_db add_rings_skip_via_on_wire_shape {  noshape }
add_rings -nets {VDD VSS} -type core_rings -follow core -layer {top Metal9 bottom Metal9 left Metal8 right Metal8} -width {top 5 bottom 5 left 5 right 5} -spacing {top 1.25 bottom 1.25 left 1.25 right 1.25} -offset {top 5 bottom 5 left 5 right 5} -center 0 -extend_corners {} -threshold 0 -jog_distance 0 -snap_wire_center_to_grid none

