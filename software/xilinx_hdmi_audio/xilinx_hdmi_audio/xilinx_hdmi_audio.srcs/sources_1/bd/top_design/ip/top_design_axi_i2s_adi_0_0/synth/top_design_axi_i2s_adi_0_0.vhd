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

-- IP VLNV: digilentinc.com:user:axi_i2s_adi:1.2
-- IP Revision: 1

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY xil_defaultlib;
USE xil_defaultlib.axi_i2s_adi_v1_2;

ENTITY top_design_axi_i2s_adi_0_0 IS
  PORT (
    DATA_CLK_I : IN STD_LOGIC;
    BCLK_O : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    LRCLK_O : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    SDATA_O : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    SDATA_I : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    MUTEN_O : OUT STD_LOGIC;
    DMA_REQ_TX_ACLK : IN STD_LOGIC;
    DMA_REQ_TX_RSTN : IN STD_LOGIC;
    DMA_REQ_TX_DAVALID : IN STD_LOGIC;
    DMA_REQ_TX_DATYPE : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    DMA_REQ_TX_DAREADY : OUT STD_LOGIC;
    DMA_REQ_TX_DRVALID : OUT STD_LOGIC;
    DMA_REQ_TX_DRTYPE : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    DMA_REQ_TX_DRLAST : OUT STD_LOGIC;
    DMA_REQ_TX_DRREADY : IN STD_LOGIC;
    DMA_REQ_RX_ACLK : IN STD_LOGIC;
    DMA_REQ_RX_RSTN : IN STD_LOGIC;
    DMA_REQ_RX_DAVALID : IN STD_LOGIC;
    DMA_REQ_RX_DATYPE : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    DMA_REQ_RX_DAREADY : OUT STD_LOGIC;
    DMA_REQ_RX_DRVALID : OUT STD_LOGIC;
    DMA_REQ_RX_DRTYPE : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    DMA_REQ_RX_DRLAST : OUT STD_LOGIC;
    DMA_REQ_RX_DRREADY : IN STD_LOGIC;
    s00_axi_awaddr : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    s00_axi_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s00_axi_awvalid : IN STD_LOGIC;
    s00_axi_awready : OUT STD_LOGIC;
    s00_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s00_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s00_axi_wvalid : IN STD_LOGIC;
    s00_axi_wready : OUT STD_LOGIC;
    s00_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s00_axi_bvalid : OUT STD_LOGIC;
    s00_axi_bready : IN STD_LOGIC;
    s00_axi_araddr : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    s00_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s00_axi_arvalid : IN STD_LOGIC;
    s00_axi_arready : OUT STD_LOGIC;
    s00_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s00_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s00_axi_rvalid : OUT STD_LOGIC;
    s00_axi_rready : IN STD_LOGIC;
    s00_axi_aclk : IN STD_LOGIC;
    s00_axi_aresetn : IN STD_LOGIC
  );
END top_design_axi_i2s_adi_0_0;

ARCHITECTURE top_design_axi_i2s_adi_0_0_arch OF top_design_axi_i2s_adi_0_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF top_design_axi_i2s_adi_0_0_arch: ARCHITECTURE IS "yes";
  COMPONENT axi_i2s_adi_v1_2 IS
    GENERIC (
      C_S00_AXI_DATA_WIDTH : INTEGER; -- Width of S_AXI data bus
      C_S00_AXI_ADDR_WIDTH : INTEGER; -- Width of S_AXI address bus
      C_SLOT_WIDTH : INTEGER;
      C_LRCLK_POL : INTEGER;
      C_BCLK_POL : INTEGER;
      C_DMA_TYPE : INTEGER;
      C_NUM_CH : INTEGER;
      C_HAS_TX : INTEGER;
      C_HAS_RX : INTEGER
    );
    PORT (
      DATA_CLK_I : IN STD_LOGIC;
      BCLK_O : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      LRCLK_O : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      SDATA_O : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      SDATA_I : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      MUTEN_O : OUT STD_LOGIC;
      S_AXIS_ACLK : IN STD_LOGIC;
      S_AXIS_TREADY : OUT STD_LOGIC;
      S_AXIS_TDATA : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      S_AXIS_TLAST : IN STD_LOGIC;
      S_AXIS_TVALID : IN STD_LOGIC;
      M_AXIS_ACLK : IN STD_LOGIC;
      M_AXIS_TREADY : IN STD_LOGIC;
      M_AXIS_TDATA : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      M_AXIS_TLAST : OUT STD_LOGIC;
      M_AXIS_TVALID : OUT STD_LOGIC;
      M_AXIS_TKEEP : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      DMA_REQ_TX_ACLK : IN STD_LOGIC;
      DMA_REQ_TX_RSTN : IN STD_LOGIC;
      DMA_REQ_TX_DAVALID : IN STD_LOGIC;
      DMA_REQ_TX_DATYPE : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      DMA_REQ_TX_DAREADY : OUT STD_LOGIC;
      DMA_REQ_TX_DRVALID : OUT STD_LOGIC;
      DMA_REQ_TX_DRTYPE : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      DMA_REQ_TX_DRLAST : OUT STD_LOGIC;
      DMA_REQ_TX_DRREADY : IN STD_LOGIC;
      DMA_REQ_RX_ACLK : IN STD_LOGIC;
      DMA_REQ_RX_RSTN : IN STD_LOGIC;
      DMA_REQ_RX_DAVALID : IN STD_LOGIC;
      DMA_REQ_RX_DATYPE : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      DMA_REQ_RX_DAREADY : OUT STD_LOGIC;
      DMA_REQ_RX_DRVALID : OUT STD_LOGIC;
      DMA_REQ_RX_DRTYPE : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      DMA_REQ_RX_DRLAST : OUT STD_LOGIC;
      DMA_REQ_RX_DRREADY : IN STD_LOGIC;
      s00_axi_awaddr : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
      s00_axi_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      s00_axi_awvalid : IN STD_LOGIC;
      s00_axi_awready : OUT STD_LOGIC;
      s00_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      s00_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      s00_axi_wvalid : IN STD_LOGIC;
      s00_axi_wready : OUT STD_LOGIC;
      s00_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      s00_axi_bvalid : OUT STD_LOGIC;
      s00_axi_bready : IN STD_LOGIC;
      s00_axi_araddr : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
      s00_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      s00_axi_arvalid : IN STD_LOGIC;
      s00_axi_arready : OUT STD_LOGIC;
      s00_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      s00_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      s00_axi_rvalid : OUT STD_LOGIC;
      s00_axi_rready : IN STD_LOGIC;
      s00_axi_aclk : IN STD_LOGIC;
      s00_axi_aresetn : IN STD_LOGIC
    );
  END COMPONENT axi_i2s_adi_v1_2;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF top_design_axi_i2s_adi_0_0_arch: ARCHITECTURE IS "axi_i2s_adi_v1_2,Vivado 2019.1";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF top_design_axi_i2s_adi_0_0_arch : ARCHITECTURE IS "top_design_axi_i2s_adi_0_0,axi_i2s_adi_v1_2,{}";
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER OF s00_axi_aresetn: SIGNAL IS "XIL_INTERFACENAME S00_AXI_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_aresetn: SIGNAL IS "xilinx.com:signal:reset:1.0 S00_AXI_RST RST";
  ATTRIBUTE X_INTERFACE_PARAMETER OF s00_axi_aclk: SIGNAL IS "XIL_INTERFACENAME S00_AXI_CLK, ASSOCIATED_BUSIF S00_AXI, ASSOCIATED_RESET s00_axi_aresetn, FREQ_HZ 159999985, PHASE 0.000, CLK_DOMAIN top_design_processing_system7_0_1_FCLK_CLK0, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_aclk: SIGNAL IS "xilinx.com:signal:clock:1.0 S00_AXI_CLK CLK";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_rready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI RREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_rvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI RVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_rresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI RRESP";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_rdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI RDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_arready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI ARREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_arvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI ARVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_arprot: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI ARPROT";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_araddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI ARADDR";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_bready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI BREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_bvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI BVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_bresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI BRESP";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_wready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI WREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_wvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI WVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_wstrb: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI WSTRB";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_wdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI WDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_awready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI AWREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_awvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI AWVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_awprot: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI AWPROT";
  ATTRIBUTE X_INTERFACE_PARAMETER OF s00_axi_awaddr: SIGNAL IS "XIL_INTERFACENAME S00_AXI, WIZ.DATA_WIDTH 32, WIZ.NUM_REG 12, SUPPORTS_NARROW_BURST 0, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 159999985, ID_WIDTH 0, ADDR_WIDTH 6, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, NUM_READ_OUTSTANDING 8, NUM_WRITE_OUTSTANDING 8, MAX_BURST_LENGTH 1, PHASE 0.000, CLK_DOMAIN top_design_processing_" & 
"system7_0_1_FCLK_CLK0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_awaddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI AWADDR";
  ATTRIBUTE X_INTERFACE_INFO OF DMA_REQ_RX_DRREADY: SIGNAL IS "xilinx.com:interface:axis:1.0 DMA_RX_REQ TREADY";
  ATTRIBUTE X_INTERFACE_INFO OF DMA_REQ_RX_DRLAST: SIGNAL IS "xilinx.com:interface:axis:1.0 DMA_RX_REQ TLAST";
  ATTRIBUTE X_INTERFACE_INFO OF DMA_REQ_RX_DRTYPE: SIGNAL IS "xilinx.com:interface:axis:1.0 DMA_RX_REQ TUSER";
  ATTRIBUTE X_INTERFACE_PARAMETER OF DMA_REQ_RX_DRVALID: SIGNAL IS "XIL_INTERFACENAME DMA_RX_REQ, TDATA_NUM_BYTES 0, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 2, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 159999985, PHASE 0.000, CLK_DOMAIN top_design_processing_system7_0_1_FCLK_CLK0, LAYERED_METADATA undef, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF DMA_REQ_RX_DRVALID: SIGNAL IS "xilinx.com:interface:axis:1.0 DMA_RX_REQ TVALID";
  ATTRIBUTE X_INTERFACE_INFO OF DMA_REQ_RX_DAREADY: SIGNAL IS "xilinx.com:interface:axis:1.0 DMA_RX_ACK TREADY";
  ATTRIBUTE X_INTERFACE_INFO OF DMA_REQ_RX_DATYPE: SIGNAL IS "xilinx.com:interface:axis:1.0 DMA_RX_ACK TUSER";
  ATTRIBUTE X_INTERFACE_PARAMETER OF DMA_REQ_RX_DAVALID: SIGNAL IS "XIL_INTERFACENAME DMA_RX_ACK, TDATA_NUM_BYTES 0, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 2, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 159999985, PHASE 0.000, CLK_DOMAIN top_design_processing_system7_0_1_FCLK_CLK0, LAYERED_METADATA undef, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF DMA_REQ_RX_DAVALID: SIGNAL IS "xilinx.com:interface:axis:1.0 DMA_RX_ACK TVALID";
  ATTRIBUTE X_INTERFACE_PARAMETER OF DMA_REQ_RX_RSTN: SIGNAL IS "XIL_INTERFACENAME DMA_RX_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF DMA_REQ_RX_RSTN: SIGNAL IS "xilinx.com:signal:reset:1.0 DMA_RX_RST RST";
  ATTRIBUTE X_INTERFACE_PARAMETER OF DMA_REQ_RX_ACLK: SIGNAL IS "XIL_INTERFACENAME DMA_RX_CLK, ASSOCIATED_BUSIF DMA_RX_REQ:DMA_RX_ACK, ASSOCIATED_RESET DMA_REQ_RX_RSTN, FREQ_HZ 159999985, PHASE 0.000, CLK_DOMAIN top_design_processing_system7_0_1_FCLK_CLK0, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF DMA_REQ_RX_ACLK: SIGNAL IS "xilinx.com:signal:clock:1.0 DMA_RX_CLK CLK";
  ATTRIBUTE X_INTERFACE_INFO OF DMA_REQ_TX_DRREADY: SIGNAL IS "xilinx.com:interface:axis:1.0 DMA_TX_REQ TREADY";
  ATTRIBUTE X_INTERFACE_INFO OF DMA_REQ_TX_DRLAST: SIGNAL IS "xilinx.com:interface:axis:1.0 DMA_TX_REQ TLAST";
  ATTRIBUTE X_INTERFACE_INFO OF DMA_REQ_TX_DRTYPE: SIGNAL IS "xilinx.com:interface:axis:1.0 DMA_TX_REQ TUSER";
  ATTRIBUTE X_INTERFACE_PARAMETER OF DMA_REQ_TX_DRVALID: SIGNAL IS "XIL_INTERFACENAME DMA_TX_REQ, TDATA_NUM_BYTES 0, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 2, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 159999985, PHASE 0.000, CLK_DOMAIN top_design_processing_system7_0_1_FCLK_CLK0, LAYERED_METADATA undef, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF DMA_REQ_TX_DRVALID: SIGNAL IS "xilinx.com:interface:axis:1.0 DMA_TX_REQ TVALID";
  ATTRIBUTE X_INTERFACE_INFO OF DMA_REQ_TX_DAREADY: SIGNAL IS "xilinx.com:interface:axis:1.0 DMA_TX_ACK TREADY";
  ATTRIBUTE X_INTERFACE_INFO OF DMA_REQ_TX_DATYPE: SIGNAL IS "xilinx.com:interface:axis:1.0 DMA_TX_ACK TUSER";
  ATTRIBUTE X_INTERFACE_PARAMETER OF DMA_REQ_TX_DAVALID: SIGNAL IS "XIL_INTERFACENAME DMA_TX_ACK, TDATA_NUM_BYTES 0, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 2, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 159999985, PHASE 0.000, CLK_DOMAIN top_design_processing_system7_0_1_FCLK_CLK0, LAYERED_METADATA undef, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF DMA_REQ_TX_DAVALID: SIGNAL IS "xilinx.com:interface:axis:1.0 DMA_TX_ACK TVALID";
  ATTRIBUTE X_INTERFACE_PARAMETER OF DMA_REQ_TX_RSTN: SIGNAL IS "XIL_INTERFACENAME DMA_TX_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF DMA_REQ_TX_RSTN: SIGNAL IS "xilinx.com:signal:reset:1.0 DMA_TX_RST RST";
  ATTRIBUTE X_INTERFACE_PARAMETER OF DMA_REQ_TX_ACLK: SIGNAL IS "XIL_INTERFACENAME DMA_TX_CLK, ASSOCIATED_BUSIF DMA_TX_REQ:DMA_TX_ACK, ASSOCIATED_RESET DMA_REQ_TX_RSTN, FREQ_HZ 159999985, PHASE 0.000, CLK_DOMAIN top_design_processing_system7_0_1_FCLK_CLK0, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF DMA_REQ_TX_ACLK: SIGNAL IS "xilinx.com:signal:clock:1.0 DMA_TX_CLK CLK";
BEGIN
  U0 : axi_i2s_adi_v1_2
    GENERIC MAP (
      C_S00_AXI_DATA_WIDTH => 32,
      C_S00_AXI_ADDR_WIDTH => 6,
      C_SLOT_WIDTH => 24,
      C_LRCLK_POL => 0,
      C_BCLK_POL => 0,
      C_DMA_TYPE => 1,
      C_NUM_CH => 1,
      C_HAS_TX => 1,
      C_HAS_RX => 1
    )
    PORT MAP (
      DATA_CLK_I => DATA_CLK_I,
      BCLK_O => BCLK_O,
      LRCLK_O => LRCLK_O,
      SDATA_O => SDATA_O,
      SDATA_I => SDATA_I,
      MUTEN_O => MUTEN_O,
      S_AXIS_ACLK => '0',
      S_AXIS_TDATA => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      S_AXIS_TLAST => '0',
      S_AXIS_TVALID => '0',
      M_AXIS_ACLK => '0',
      M_AXIS_TREADY => '0',
      DMA_REQ_TX_ACLK => DMA_REQ_TX_ACLK,
      DMA_REQ_TX_RSTN => DMA_REQ_TX_RSTN,
      DMA_REQ_TX_DAVALID => DMA_REQ_TX_DAVALID,
      DMA_REQ_TX_DATYPE => DMA_REQ_TX_DATYPE,
      DMA_REQ_TX_DAREADY => DMA_REQ_TX_DAREADY,
      DMA_REQ_TX_DRVALID => DMA_REQ_TX_DRVALID,
      DMA_REQ_TX_DRTYPE => DMA_REQ_TX_DRTYPE,
      DMA_REQ_TX_DRLAST => DMA_REQ_TX_DRLAST,
      DMA_REQ_TX_DRREADY => DMA_REQ_TX_DRREADY,
      DMA_REQ_RX_ACLK => DMA_REQ_RX_ACLK,
      DMA_REQ_RX_RSTN => DMA_REQ_RX_RSTN,
      DMA_REQ_RX_DAVALID => DMA_REQ_RX_DAVALID,
      DMA_REQ_RX_DATYPE => DMA_REQ_RX_DATYPE,
      DMA_REQ_RX_DAREADY => DMA_REQ_RX_DAREADY,
      DMA_REQ_RX_DRVALID => DMA_REQ_RX_DRVALID,
      DMA_REQ_RX_DRTYPE => DMA_REQ_RX_DRTYPE,
      DMA_REQ_RX_DRLAST => DMA_REQ_RX_DRLAST,
      DMA_REQ_RX_DRREADY => DMA_REQ_RX_DRREADY,
      s00_axi_awaddr => s00_axi_awaddr,
      s00_axi_awprot => s00_axi_awprot,
      s00_axi_awvalid => s00_axi_awvalid,
      s00_axi_awready => s00_axi_awready,
      s00_axi_wdata => s00_axi_wdata,
      s00_axi_wstrb => s00_axi_wstrb,
      s00_axi_wvalid => s00_axi_wvalid,
      s00_axi_wready => s00_axi_wready,
      s00_axi_bresp => s00_axi_bresp,
      s00_axi_bvalid => s00_axi_bvalid,
      s00_axi_bready => s00_axi_bready,
      s00_axi_araddr => s00_axi_araddr,
      s00_axi_arprot => s00_axi_arprot,
      s00_axi_arvalid => s00_axi_arvalid,
      s00_axi_arready => s00_axi_arready,
      s00_axi_rdata => s00_axi_rdata,
      s00_axi_rresp => s00_axi_rresp,
      s00_axi_rvalid => s00_axi_rvalid,
      s00_axi_rready => s00_axi_rready,
      s00_axi_aclk => s00_axi_aclk,
      s00_axi_aresetn => s00_axi_aresetn
    );
END top_design_axi_i2s_adi_0_0_arch;
