set lef_path "libs/lef"
 
set lef_list [list \
     $lef_path/gsclib045.fixed2.lef \
     $lef_path/MEM1_1024X32.lef \
     $lef_path/MEM1_256X32.lef \
     $lef_path/MEM1_4096X32.lef \
     $lef_path/MEM2_1024X32.lef \
     $lef_path/MEM2_128X16.lef \
     $lef_path/MEM2_128X32.lef \
     $lef_path/MEM2_136X32.lef \
     $lef_path/MEM2_2048X32.lef \
     $lef_path/MEM2_4096X32.lef \
     $lef_path/MEM2_512X32.lef \
     $lef_path/pdkIO.lef \
     DATA/periph1.partition.lef \
     DATA/leon.partition.lef]
read_mmmc DATA/view_definition.tcl
read_physical -lef $lef_list
read_netlist DATA/asic_entity_increased.v

#add vdd e vss
set_db init_power_nets {VDD}
set_db init_ground_nets {VSS}
 
init_design

