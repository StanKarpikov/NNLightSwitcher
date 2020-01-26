----------------------------------------------------------------------------------
-- Company: Trenz Electronic GmbH
-- Engineer: Oleksandr Kiyenko
----------------------------------------------------------------------------------
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
----------------------------------------------------------------------------------
entity axis_audio_pwm_v1_0 is
generic (
	C_SYS_FREQ			: INTEGER := 150000000;
	C_PWM_FREQ			: INTEGER := 100000		-- Usually from 50 to 100 kHz
);
port (
	-- PWM Outs
	pwm_l_out			: out STD_LOGIC;
	pwm_r_out			: out STD_LOGIC;
	-- Ports of Axi Slave Bus Interface S00_AXIS
	s00_axis_aclk		: in  STD_LOGIC;
	s00_axis_tready		: out STD_LOGIC;
	s00_axis_tdata		: in  STD_LOGIC_VECTOR(31 downto 0);
	s00_axis_tvalid		: in  STD_LOGIC
);
end axis_audio_pwm_v1_0;
----------------------------------------------------------------------------------
architecture arch_imp of axis_audio_pwm_v1_0 is
----------------------------------------------------------------------------------
constant C_CNT_MAX			: INTEGER := 32767;
constant C_CNT_MIN			: INTEGER := -32767;
constant C_STEP				: INTEGER := 131072 / (C_SYS_FREQ/C_PWM_FREQ);
----------------------------------------------------------------------------------
signal left_ch_val			: SIGNED(15 downto 0);	-- Data latches
signal right_ch_val			: SIGNED(15 downto 0);
signal pwm_cnt				: SIGNED(15 downto 0);	-- Reference signal
signal pwm_cnt_dir			: STD_LOGIC;			-- Saw direction
----------------------------------------------------------------------------------
begin
----------------------------------------------------------------------------------
s00_axis_tready				<= '1';	-- Always ready
-- Data latch
process(s00_axis_aclk)
begin
	if(s00_axis_aclk = '1' and s00_axis_aclk'event)then
		if(s00_axis_tvalid = '1')then
			left_ch_val		<= SIGNED(s00_axis_tdata(15 downto  0));
			right_ch_val	<= SIGNED(s00_axis_tdata(31 downto 16));
		end if;
	end if;
end process;

-- PWM Coding
process(s00_axis_aclk)
begin
	if(s00_axis_aclk = '1' and s00_axis_aclk'event)then
		-- Triangle reference signal
		if(pwm_cnt_dir = '0')then	-- Up count
			if(pwm_cnt >= TO_SIGNED((C_CNT_MAX - C_STEP),16))then
				pwm_cnt_dir		<= '1';
				pwm_cnt			<= pwm_cnt - C_STEP;
			else
				pwm_cnt			<= pwm_cnt + C_STEP;
			end if;
		else						-- Down count
			if(pwm_cnt <= TO_SIGNED((C_CNT_MIN + C_STEP),16))then
				pwm_cnt_dir		<= '0';
				pwm_cnt			<= pwm_cnt + C_STEP;
			else
				pwm_cnt			<= pwm_cnt - C_STEP;
			end if;
		end if;
		-- Comparators
		if(left_ch_val > pwm_cnt)then
			pwm_l_out			<= '1';
		else
			pwm_l_out			<= '0';
		end if;
		if(right_ch_val > pwm_cnt)then
			pwm_r_out			<= '1';
		else
			pwm_r_out			<= '0';
		end if;
	end if;
end process;
----------------------------------------------------------------------------------
end arch_imp;
