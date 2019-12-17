connect -url tcp:127.0.0.1:3121
source E:/REPO_GitHub/NNLightSwitcher/Software/Xilinx_pr1/Zynq10_pr1/Zynq10_pr1.sdk/top_design_wrapper_hw_platform_0/ps7_init.tcl
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Platform Cable USB 00001a2b284401"} -index 0
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Platform Cable USB 00001a2b284401" && level==0} -index 1
fpga -file E:/REPO_GitHub/NNLightSwitcher/Software/Xilinx_pr1/Zynq10_pr1/Zynq10_pr1.sdk/top_design_wrapper_hw_platform_0/top_design_wrapper.bit
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Platform Cable USB 00001a2b284401"} -index 0
loadhw -hw E:/REPO_GitHub/NNLightSwitcher/Software/Xilinx_pr1/Zynq10_pr1/Zynq10_pr1.sdk/top_design_wrapper_hw_platform_0/system.hdf -mem-ranges [list {0x40000000 0xbfffffff}]
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Platform Cable USB 00001a2b284401"} -index 0
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Platform Cable USB 00001a2b284401"} -index 0
dow E:/REPO_GitHub/NNLightSwitcher/Software/Xilinx_pr1/Zynq10_pr1/Zynq10_pr1.sdk/custom_fsbl/Debug/custom_fsbl.elf
configparams force-mem-access 0
bpadd -addr &main
