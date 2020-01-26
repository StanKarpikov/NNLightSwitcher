----------------------------------------------------------------------------------
-- Company: Trenz Electronic GmbH
-- Engineer: Oleksandr Kiyenko
----------------------------------------------------------------------------------
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
----------------------------------------------------------------------------------
entity axis_video_dwidth_converter_v1_0 is
generic (
	C_DATA_WIDTH	: integer 				:= 32;
	C_IN_TYPE		: integer range 1 to 4	:= 4;
	C_OUT_TYPE		: integer range 1 to 4	:= 1
);
port (
	axis_aclk		: in  STD_LOGIC;
	axis_aresetn	: in  STD_LOGIC;
	-- Ports of Axi Slave Bus Interface S_AXIS
	s_axis_tready	: out STD_LOGIC;
	s_axis_tdata	: in  STD_LOGIC_VECTOR(C_IN_TYPE*C_DATA_WIDTH-1 downto 0);
	s_axis_tuser	: in  STD_LOGIC;
	s_axis_tlast	: in  STD_LOGIC;
	s_axis_tvalid	: in  STD_LOGIC;
	-- Ports of Axi Master Bus Interface M_AXIS
	m_axis_tvalid	: out STD_LOGIC;
	m_axis_tdata	: out STD_LOGIC_VECTOR(C_OUT_TYPE*C_DATA_WIDTH-1 downto 0);
	m_axis_tuser	: out STD_LOGIC;
	m_axis_tlast	: out STD_LOGIC;
	m_axis_tready	: in  STD_LOGIC
);
end axis_video_dwidth_converter_v1_0;
----------------------------------------------------------------------------------
architecture arch_imp of axis_video_dwidth_converter_v1_0 is
----------------------------------------------------------------------------------
type sm_state_type is (ST_IDLE, ST_1W, ST_2W, ST_3W);
signal sm_state			: sm_state_type	:= ST_IDLE;
signal tdata_buffer		: STD_LOGIC_VECTOR((C_IN_TYPE-C_OUT_TYPE)*C_DATA_WIDTH-1 downto 0);
signal tlast_buffer		: STD_LOGIC;
----------------------------------------------------------------------------------
begin
----------------------------------------------------------------------------------
bypass_gen: if ((C_IN_TYPE = 1) and (C_OUT_TYPE = 1))generate
begin
	m_axis_tvalid	<= s_axis_tvalid;
	m_axis_tdata	<= s_axis_tdata;
	m_axis_tuser	<= s_axis_tuser;
	m_axis_tlast	<= s_axis_tlast;
	s_axis_tready	<= m_axis_tready;
end generate;
----------------------------------------------------------------------------------
repack_gen: if ((C_IN_TYPE /= 1) or (C_OUT_TYPE /= 1)) generate
begin
	process(sm_state, s_axis_tvalid)
	begin
		case sm_state is
			when ST_IDLE 	=> m_axis_tvalid <= s_axis_tvalid;
			when ST_1W		=> m_axis_tvalid <= '1';
			when ST_2W		=> m_axis_tvalid <= '1';
			when ST_3W		=> m_axis_tvalid <= '1';
		end case;
	end process;

	process(sm_state, s_axis_tuser)
	begin
		case sm_state is
			when ST_IDLE 	=> m_axis_tuser <= s_axis_tuser;
			when ST_1W		=> m_axis_tuser <= '0';
			when ST_2W		=> m_axis_tuser <= '0';
			when ST_3W		=> m_axis_tuser <= '0';
		end case;
	end process;

	process(sm_state, s_axis_tuser)
	begin
		case sm_state is
			when ST_IDLE 	=> m_axis_tlast <= '0';
			when ST_1W		=> 
				if(C_OUT_TYPE = 2)then
					m_axis_tlast <= tlast_buffer;
				else
					m_axis_tlast <= '0';
				end if;
			when ST_2W		=> m_axis_tlast <= '0';
			when ST_3W		=> m_axis_tlast <= tlast_buffer;
		end case;
	end process;

	out_1p_gen: if C_OUT_TYPE = 1 generate
	begin
		process(sm_state, s_axis_tdata, tdata_buffer)
		begin
			case sm_state is
				when ST_IDLE 	=> m_axis_tdata <= s_axis_tdata(C_OUT_TYPE*C_DATA_WIDTH-1 downto 0);
				when ST_1W		=> m_axis_tdata <= tdata_buffer(C_OUT_TYPE*C_DATA_WIDTH-1 downto 0);
				when ST_2W		=> m_axis_tdata <= tdata_buffer(C_OUT_TYPE*C_DATA_WIDTH*2-1 downto C_OUT_TYPE*C_DATA_WIDTH*1);
				when ST_3W		=> m_axis_tdata <= tdata_buffer(C_OUT_TYPE*C_DATA_WIDTH*3-1 downto C_OUT_TYPE*C_DATA_WIDTH*2);
			end case;
		end process;
	end generate;

	out_2p_gen: if C_OUT_TYPE = 2 generate
	begin
		process(sm_state, s_axis_tdata, tdata_buffer)
		begin
			case sm_state is
				when ST_IDLE 	=> m_axis_tdata <= s_axis_tdata(C_OUT_TYPE*C_DATA_WIDTH-1 downto 0);
				when ST_1W		=> m_axis_tdata <= tdata_buffer(C_OUT_TYPE*C_DATA_WIDTH-1 downto 0);
				when others		=> null;
			end case;
		end process;
	end generate;

	process(axis_aclk)
	begin
		if(axis_aclk = '1' and axis_aclk'event)then
			case sm_state is
				when ST_IDLE 	=>
					if((s_axis_tvalid = '1') and (m_axis_tready = '1'))then
						tdata_buffer	<= s_axis_tdata(s_axis_tdata'left downto C_OUT_TYPE*C_DATA_WIDTH);
						tlast_buffer	<= s_axis_tlast;
						sm_state		<= ST_1W;
					end if;
				when ST_1W	=>
					if(m_axis_tready = '1')then
						if(C_OUT_TYPE = 2)then
							sm_state	<= ST_IDLE;
						else
							sm_state	<= ST_2W;
						end if;
					end if;
				when ST_2W	=>
					if(m_axis_tready = '1')then
						sm_state		<= ST_3W;
					end if;
				when ST_3W	=>
					if(m_axis_tready = '1')then
						sm_state		<= ST_IDLE;
					end if;
			end case;
		end if;
	end process;

	s_axis_tready	<= m_axis_tready when sm_state = ST_IDLE else '0';
end generate;
----------------------------------------------------------------------------------
end arch_imp;
