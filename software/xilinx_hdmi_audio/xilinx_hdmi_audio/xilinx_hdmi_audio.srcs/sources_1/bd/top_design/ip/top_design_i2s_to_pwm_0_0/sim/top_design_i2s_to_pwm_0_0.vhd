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

-- IP VLNV: trenz.biz:user:i2s_to_pwm:1.0
-- IP Revision: 8

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY top_design_i2s_to_pwm_0_0 IS
  PORT (
    clk_in : IN STD_LOGIC;
    i2s_bclk : IN STD_LOGIC;
    i2s_lrclk : IN STD_LOGIC;
    i2s_sdata : IN STD_LOGIC;
    pwm_l_out : OUT STD_LOGIC;
    pwm_r_out : OUT STD_LOGIC
  );
END top_design_i2s_to_pwm_0_0;

ARCHITECTURE top_design_i2s_to_pwm_0_0_arch OF top_design_i2s_to_pwm_0_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF top_design_i2s_to_pwm_0_0_arch: ARCHITECTURE IS "yes";
  COMPONENT i2s_to_pwm IS
    GENERIC (
      C_SYS_FREQ : INTEGER;
      C_PWM_FREQ : INTEGER
    );
    PORT (
      clk_in : IN STD_LOGIC;
      i2s_bclk : IN STD_LOGIC;
      i2s_lrclk : IN STD_LOGIC;
      i2s_sdata : IN STD_LOGIC;
      pwm_l_out : OUT STD_LOGIC;
      pwm_r_out : OUT STD_LOGIC
    );
  END COMPONENT i2s_to_pwm;
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER OF clk_in: SIGNAL IS "XIL_INTERFACENAME clk_in, PHASE 0.000, CLK_DOMAIN top_design_processing_system7_0_1_FCLK_CLK0, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF clk_in: SIGNAL IS "xilinx.com:signal:clock:1.0 clk_in CLK";
BEGIN
  U0 : i2s_to_pwm
    GENERIC MAP (
      C_SYS_FREQ => 150000000,
      C_PWM_FREQ => 100000
    )
    PORT MAP (
      clk_in => clk_in,
      i2s_bclk => i2s_bclk,
      i2s_lrclk => i2s_lrclk,
      i2s_sdata => i2s_sdata,
      pwm_l_out => pwm_l_out,
      pwm_r_out => pwm_r_out
    );
END top_design_i2s_to_pwm_0_0_arch;
