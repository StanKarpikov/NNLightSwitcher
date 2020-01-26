----------------------------------------------------------------------------------
-- Company: Trenz Electronic GmbH
-- Engineer: Oleksandr Kiyenko
----------------------------------------------------------------------------------
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
----------------------------------------------------------------------------------
entity axis_video_resize_v1_0 is
generic (
		C_IN_TYPE			: integer range 1 to 4	:= 1;
		C_HORISONTAL_RES	: integer	:= 1280;
		C_VERTICAL_RES		: integer	:= 720
);
port (
		axis_aclk		: in  STD_LOGIC;
		axis_aresetn	: in  STD_LOGIC;
		-- Ports of Axi Slave Bus Interface S_AXIS
		s_axis_tready	: out STD_LOGIC;
		s_axis_tdata	: in  STD_LOGIC_VECTOR(C_IN_TYPE*32-1 downto 0);
		s_axis_tuser	: in  STD_LOGIC;
		s_axis_tlast	: in  STD_LOGIC;
		s_axis_tvalid	: in  STD_LOGIC;

		-- Ports of Axi Master Bus Interface M_AXIS
		m_axis_tvalid	: out STD_LOGIC;
		m_axis_tdata	: out STD_LOGIC_VECTOR(C_IN_TYPE*32-1 downto 0);
		m_axis_tuser	: out STD_LOGIC;
		m_axis_tlast	: out STD_LOGIC;
		m_axis_tready	: in  STD_LOGIC
	);
end axis_video_resize_v1_0;
----------------------------------------------------------------------------------
architecture arch_imp of axis_video_resize_v1_0 is
----------------------------------------------------------------------------------
signal hor_cnt		: UNSIGNED(15 downto 0);
signal ver_cnt		: UNSIGNED(15 downto 0);
type sm_state_type is (ST_IDLE, ST_HOR_LINE, ST_HOR_CROP);
signal sm_state		: sm_state_type	:= ST_IDLE;
signal vert_pass	: STD_LOGIC;
----------------------------------------------------------------------------------
begin
----------------------------------------------------------------------------------
s_axis_tready		<= m_axis_tready;
m_axis_tdata		<= s_axis_tdata;
m_axis_tuser		<= s_axis_tuser;
process(axis_aclk)
begin
	if(axis_aclk = '1' and axis_aclk'event)then
		case sm_state is
			when ST_IDLE =>		-- Wait for start of frame
				vert_pass		<= '1';
				ver_cnt			<= TO_UNSIGNED(0,16);
				hor_cnt			<= TO_UNSIGNED(C_IN_TYPE,16);
				if((s_axis_tvalid = '1') and (m_axis_tready = '1') and (s_axis_tuser = '1'))then
					sm_state	<= ST_HOR_LINE;
				end if;
			when ST_HOR_LINE =>
				if((s_axis_tvalid = '1') and (m_axis_tready = '1'))then
					if(s_axis_tuser = '1')then
						ver_cnt			<= TO_UNSIGNED(0,16);
						vert_pass		<= '1';
					elsif(s_axis_tlast = '1')then
						if(ver_cnt >= TO_UNSIGNED((C_VERTICAL_RES-1),16))then
							vert_pass	<= '0';
						end if;
						ver_cnt			<= ver_cnt + 1;
					end if;
				
					if(s_axis_tlast = '1')then
						hor_cnt		<= TO_UNSIGNED(0,16);
					else
						if(hor_cnt >= TO_UNSIGNED((C_HORISONTAL_RES - C_IN_TYPE),16))then
							sm_state	<= ST_HOR_CROP;
						end if;
						hor_cnt		<= hor_cnt + TO_UNSIGNED(C_IN_TYPE, 16);
					end if;
				end if;
			when ST_HOR_CROP => 
				if((s_axis_tvalid = '1') and (m_axis_tready = '1') and (s_axis_tlast = '1'))then
					hor_cnt		<= TO_UNSIGNED(0,16);
					sm_state	<= ST_HOR_LINE;
					if(ver_cnt >= TO_UNSIGNED((C_VERTICAL_RES-1),16))then
						vert_pass	<= '0';
					end if;
					ver_cnt		<= ver_cnt + 1;
				end if;
		end case;
	end if;
end process;

process(sm_state, s_axis_tvalid, s_axis_tuser, vert_pass)
begin
	case sm_state is
		when ST_IDLE 		=> m_axis_tvalid	<= s_axis_tvalid and s_axis_tuser;
		when ST_HOR_LINE	=> m_axis_tvalid	<= s_axis_tvalid and (vert_pass or s_axis_tuser);
		when ST_HOR_CROP	=> m_axis_tvalid	<= '0';
	end case;
end process;

process(sm_state, hor_cnt)
begin
	case sm_state is
		when ST_IDLE 		=> m_axis_tlast	<= '0';
		when ST_HOR_LINE	=> 
			if(hor_cnt >= TO_UNSIGNED((C_HORISONTAL_RES - C_IN_TYPE),16))then
				m_axis_tlast	<= '1';
			else
				m_axis_tlast	<= '0';
			end if;
		when ST_HOR_CROP	=> m_axis_tlast	<= '0';
	end case;
end process;
----------------------------------------------------------------------------------
end arch_imp;
