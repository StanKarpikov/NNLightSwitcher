-- (c) Copyright 1995-2020 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: trenz.biz:user:Video_IO_2_HDMI_TMDS:1.0
-- IP Revision: 27

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY top_design_Video_IO_2_HDMI_TMDS_0_0 IS
  PORT (
    video_clk_in : IN STD_LOGIC;
    video_clk5x_in : IN STD_LOGIC;
    lock_in : IN STD_LOGIC;
    vid_data : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
    vid_active_video : IN STD_LOGIC;
    vid_hblank : IN STD_LOGIC;
    vid_vblank : IN STD_LOGIC;
    vid_hsync : IN STD_LOGIC;
    vid_vsync : IN STD_LOGIC;
    hdmi_data_p : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    hdmi_data_n : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    hdmi_clk_p : OUT STD_LOGIC;
    hdmi_clk_n : OUT STD_LOGIC
  );
END top_design_Video_IO_2_HDMI_TMDS_0_0;

ARCHITECTURE top_design_Video_IO_2_HDMI_TMDS_0_0_arch OF top_design_Video_IO_2_HDMI_TMDS_0_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF top_design_Video_IO_2_HDMI_TMDS_0_0_arch: ARCHITECTURE IS "yes";
  COMPONENT Video_IO_2_HDMI_TMDS_v1_0 IS
    GENERIC (
      C_CLK_SWAP : BOOLEAN;
      C_D0_SWAP : BOOLEAN;
      C_D1_SWAP : BOOLEAN;
      C_D2_SWAP : BOOLEAN;
      C_INT_CLOCKING : BOOLEAN;
      C_VIDEO_MODE : INTEGER
    );
    PORT (
      video_clk_in : IN STD_LOGIC;
      video_clk5x_in : IN STD_LOGIC;
      lock_in : IN STD_LOGIC;
      vid_data : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
      vid_active_video : IN STD_LOGIC;
      vid_hblank : IN STD_LOGIC;
      vid_vblank : IN STD_LOGIC;
      vid_hsync : IN STD_LOGIC;
      vid_vsync : IN STD_LOGIC;
      hdmi_data_p : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      hdmi_data_n : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      hdmi_clk_p : OUT STD_LOGIC;
      hdmi_clk_n : OUT STD_LOGIC
    );
  END COMPONENT Video_IO_2_HDMI_TMDS_v1_0;
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER : STRING;
  ATTRIBUTE X_INTERFACE_INFO OF vid_vsync: SIGNAL IS "xilinx.com:interface:vid_io:1.0 vid_io_in VSYNC";
  ATTRIBUTE X_INTERFACE_INFO OF vid_hsync: SIGNAL IS "xilinx.com:interface:vid_io:1.0 vid_io_in HSYNC";
  ATTRIBUTE X_INTERFACE_INFO OF vid_vblank: SIGNAL IS "xilinx.com:interface:vid_io:1.0 vid_io_in VBLANK";
  ATTRIBUTE X_INTERFACE_INFO OF vid_hblank: SIGNAL IS "xilinx.com:interface:vid_io:1.0 vid_io_in HBLANK";
  ATTRIBUTE X_INTERFACE_INFO OF vid_active_video: SIGNAL IS "xilinx.com:interface:vid_io:1.0 vid_io_in ACTIVE_VIDEO";
  ATTRIBUTE X_INTERFACE_INFO OF vid_data: SIGNAL IS "xilinx.com:interface:vid_io:1.0 vid_io_in DATA";
  ATTRIBUTE X_INTERFACE_PARAMETER OF video_clk5x_in: SIGNAL IS "XIL_INTERFACENAME video_clk5x_in, PHASE 0.0, CLK_DOMAIN /video_out/clk_wiz_1_clk_out1, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF video_clk5x_in: SIGNAL IS "xilinx.com:signal:clock:1.0 video_clk5x_in CLK";
  ATTRIBUTE X_INTERFACE_PARAMETER OF video_clk_in: SIGNAL IS "XIL_INTERFACENAME video_clk_in, PHASE 0.0, CLK_DOMAIN /video_out/clk_wiz_1_clk_out1, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF video_clk_in: SIGNAL IS "xilinx.com:signal:clock:1.0 video_clk_in CLK";
BEGIN
  U0 : Video_IO_2_HDMI_TMDS_v1_0
    GENERIC MAP (
      C_CLK_SWAP => true,
      C_D0_SWAP => true,
      C_D1_SWAP => false,
      C_D2_SWAP => false,
      C_INT_CLOCKING => false,
      C_VIDEO_MODE => 0
    )
    PORT MAP (
      video_clk_in => video_clk_in,
      video_clk5x_in => video_clk5x_in,
      lock_in => lock_in,
      vid_data => vid_data,
      vid_active_video => vid_active_video,
      vid_hblank => vid_hblank,
      vid_vblank => vid_vblank,
      vid_hsync => vid_hsync,
      vid_vsync => vid_vsync,
      hdmi_data_p => hdmi_data_p,
      hdmi_data_n => hdmi_data_n,
      hdmi_clk_p => hdmi_clk_p,
      hdmi_clk_n => hdmi_clk_n
    );
END top_design_Video_IO_2_HDMI_TMDS_0_0_arch;
