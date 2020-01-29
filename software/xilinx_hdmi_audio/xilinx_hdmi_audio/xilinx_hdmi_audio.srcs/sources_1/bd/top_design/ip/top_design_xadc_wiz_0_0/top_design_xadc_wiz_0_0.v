
// file: top_design_xadc_wiz_0_0.v
// (c) Copyright 2009 - 2013 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
`timescale 1ns / 1 ps

(* CORE_GENERATION_INFO = "top_design_xadc_wiz_0_0,xadc_wiz_v3_3_6,{component_name=top_design_xadc_wiz_0_0,enable_axi=false,enable_axi4stream=true,dclk_frequency=150,enable_busy=true,enable_convst=false,enable_convstclk=false,enable_dclk=true,enable_drp=false,enable_eoc=true,enable_eos=true,enable_vbram_alaram=false,enable_vccddro_alaram=false,enable_Vccint_Alaram=false,enable_Vccaux_alaram=false,enable_vccpaux_alaram=false,enable_vccpint_alaram=false,ot_alaram=false,user_temp_alaram=false,timing_mode=continuous,channel_averaging=None,sequencer_mode=off,startup_channel_selection=single_channel}" *)


module top_design_xadc_wiz_0_0
   (
  // axi4stream master signals 
    input s_axis_aclk,
    input m_axis_aclk,
    input m_axis_resetn,
    output [15 : 0] m_axis_tdata,
    output m_axis_tvalid,
    output [4 : 0] m_axis_tid,
    input m_axis_tready,
    input vauxp8,                                              
    input vauxn8,                                              
    output [4:0] channel_out,
    output busy_out,        
    output eoc_out, 
    output eos_out,
    output alarm_out ,                                          
    input vp_in,                                               
    input vn_in
);

          wire [7:0]  alm_int;
          assign alarm_out = alm_int[7];

    top_design_xadc_wiz_0_0_axi_xadc 
    inst 
    (
    .s_axis_aclk     (s_axis_aclk),
    .m_axis_aclk     (m_axis_aclk),
    .m_axis_resetn   (m_axis_resetn),
              
    .m_axis_tdata    (m_axis_tdata),
    .m_axis_tvalid   (m_axis_tvalid),
    .m_axis_tid      (m_axis_tid),
    .m_axis_tready   (m_axis_tready),
    .vauxp8 (vauxp8),
    .vauxn8 (vauxn8),
    .channel_out(channel_out),
    .busy_out(busy_out), 
    .eoc_out(eoc_out), 
    .eos_out(eos_out),
    .alarm_out  (alm_int),
    .vp_in (vp_in),
    .vn_in (vn_in)

          );


endmodule
