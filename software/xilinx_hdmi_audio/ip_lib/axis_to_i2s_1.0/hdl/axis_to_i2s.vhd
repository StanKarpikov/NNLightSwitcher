----------------------------------------------------------------------------------
-- Company: Trenz Electronic GmbH
-- Engineer: Oleksandr Kiyenko
----------------------------------------------------------------------------------
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
----------------------------------------------------------------------------------
entity axis_to_i2s is
port (
	-- Ports of Axi Slave Bus Interface S_AXIS
	s_axis_aclk			: in  STD_LOGIC;
	s_axis_aresetn		: in  STD_LOGIC;
	s_axis_tready		: out STD_LOGIC;
	s_axis_tdata		: in  STD_LOGIC_VECTOR(15 downto 0);
	s_axis_tvalid		: in  STD_LOGIC;
	-- I2S Signals
	i2s_bclk			: in  STD_LOGIC;
	i2s_lrclk			: in  STD_LOGIC;
	i2s_sdata			: out STD_LOGIC
);
end axis_to_i2s;
----------------------------------------------------------------------------------
architecture arch_imp of axis_to_i2s is
----------------------------------------------------------------------------------
signal input_data			: STD_LOGIC_VECTOR(15 downto 0);
signal bclk_sr				: STD_LOGIC_VECTOR( 1 downto 0);
signal lrclk_sr				: STD_LOGIC_VECTOR( 1 downto 0);
signal data_sr				: STD_LOGIC_VECTOR(31 downto 0);
signal load_flag			: STD_LOGIC;
signal channel_flag			: STD_LOGIC;
----------------------------------------------------------------------------------
begin
----------------------------------------------------------------------------------
s_axis_tready	<= '1';
process(s_axis_aclk)
begin
	if(s_axis_aclk = '1' and s_axis_aclk'event)then
		bclk_sr			<= bclk_sr(0) & i2s_bclk;
		lrclk_sr		<= lrclk_sr(0) & i2s_lrclk;
		if(s_axis_tvalid = '1')then
			input_data	<= s_axis_tdata;
		end if;
		
		if((lrclk_sr = "10") or (lrclk_sr = "01"))then	-- LR Edge
			channel_flag	<= '1';
		elsif(bclk_sr = "01")then	-- Rising edge
			channel_flag	<= '0';
		end if;
		
		if(bclk_sr = "01")then	-- Rising edge
			load_flag		<= channel_flag;
		end if;
		
		if(bclk_sr = "10")then	-- Falling edge
			if(load_flag = '1')then
				data_sr		<= input_data & x"0000";
			else
				data_sr		<= data_sr(30 downto 0) & '0';
			end if;
		end if;
	end if;
end process;
i2s_sdata	<= data_sr(31);
----------------------------------------------------------------------------------
end arch_imp;
