----------------------------------------------------------------------------------
-- Company: Trenz Electronic GmbH
-- Engineer: Oleksandr Kiyenko
----------------------------------------------------------------------------------
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
----------------------------------------------------------------------------------
entity i2s_to_pwm is
generic (
	C_SYS_FREQ			: INTEGER := 150000000;
	C_PWM_FREQ			: INTEGER := 100000		-- Usually from 50 to 100 kHz
);
port (
	-- General
	clk_in				: in  STD_LOGIC;
	-- I2S Signals
	i2s_bclk			: in  STD_LOGIC;
	i2s_lrclk			: in  STD_LOGIC;
	i2s_sdata			: in  STD_LOGIC;
	-- PWM Outs
	pwm_l_out			: out STD_LOGIC;
	pwm_r_out			: out STD_LOGIC
);
end i2s_to_pwm;
----------------------------------------------------------------------------------
architecture arch_imp of i2s_to_pwm is
----------------------------------------------------------------------------------
-- For 16 bit sound
constant C_S_CNT_MAX		: INTEGER := 32767;
constant C_S_CNT_MIN		: INTEGER := -32767;
constant C_STEP				: INTEGER := 131072 / (C_SYS_FREQ/C_PWM_FREQ);
----------------------------------------------------------------------------------
signal left_s_ch_val		: SIGNED(15 downto 0);	-- Data latches
signal right_s_ch_val		: SIGNED(15 downto 0);
signal pwm_s_cnt			: SIGNED(15 downto 0);	-- Reference signal
signal pwm_s_cnt_dir		: STD_LOGIC;			-- Saw direction
----------------------------------------------------------------------------------
signal bclk_sr				: STD_LOGIC_VECTOR(1 downto 0);
signal lrclk_sr				: STD_LOGIC_VECTOR(1 downto 0);
signal sdata				: STD_LOGIC;
----------------------------------------------------------------------------------
signal bit_addr				: INTEGER range 0 to 31;
signal data_reg				: STD_LOGIC_VECTOR(31 downto 0);
signal lsb_left				: STD_LOGIC;
signal lsb_right			: STD_LOGIC;
signal update_left			: STD_LOGIC;
signal update_right			: STD_LOGIC;
----------------------------------------------------------------------------------
begin
----------------------------------------------------------------------------------
-- I2S Decode
process(clk_in)
begin
	if(clk_in = '1' and clk_in'event)then
		bclk_sr					<= bclk_sr(0) & i2s_bclk;
		lrclk_sr				<= lrclk_sr(0) & i2s_lrclk;
		sdata					<= i2s_sdata;
		if(lrclk_sr = "01")then		-- End of left
			lsb_left			<= '1';
		elsif(bclk_sr = "01")then	-- Rising edge
			lsb_left			<= '0';
		end if;
		if(lrclk_sr = "10")then	-- End of rigth
			lsb_right			<= '1';
		elsif(bclk_sr = "01")then	-- Rising edge
			lsb_right			<= '0';
		end if;
			
		if(bclk_sr = "01")then	-- Rising edge
			if((lsb_left = '1') or (lsb_right = '1'))then
				bit_addr		<= 31;
			elsif(bit_addr /= 0)then
				bit_addr		<= bit_addr - 1;
			end if;
			data_reg(bit_addr)	<= sdata;
			update_left			<= lsb_left;
			update_right		<= lsb_right;
		else
			update_left			<= '0';
			update_right		<= '0';
		end if;
		
		if(update_left = '1')then
			left_s_ch_val		<= SIGNED(data_reg(31 downto 16));
		end if;
		if(update_right = '1')then
			right_s_ch_val		<= SIGNED(data_reg(31 downto 16));
		end if;
	end if;
end process;

-- PWM Coding
process(clk_in)
begin
	if(clk_in = '1' and clk_in'event)then
		-- Triangle reference signal
		if(pwm_s_cnt_dir = '0')then	-- Up count
			if(pwm_s_cnt >= TO_SIGNED((C_S_CNT_MAX - C_STEP),16))then
				pwm_s_cnt_dir		<= '1';
				pwm_s_cnt		<= pwm_s_cnt - C_STEP;
			else
				pwm_s_cnt		<= pwm_s_cnt + C_STEP;
			end if;
		else						-- Down count
			if(pwm_s_cnt <= TO_SIGNED((C_S_CNT_MIN + C_STEP),16))then
				pwm_s_cnt_dir		<= '0';
				pwm_s_cnt		<= pwm_s_cnt + C_STEP;
			else
				pwm_s_cnt		<= pwm_s_cnt - C_STEP;
			end if;
		end if;
	end if;
end process;

process(clk_in)
begin
	if(clk_in = '1' and clk_in'event)then
		-- Comparators
		if(left_s_ch_val > pwm_s_cnt)then
			pwm_l_out			<= '1';
		else
			pwm_l_out			<= '0';
		end if;
		if(right_s_ch_val > pwm_s_cnt)then
			pwm_r_out			<= '1';
		else
			pwm_r_out			<= '0';
		end if;
	end if;
end process;
----------------------------------------------------------------------------------
end arch_imp;
