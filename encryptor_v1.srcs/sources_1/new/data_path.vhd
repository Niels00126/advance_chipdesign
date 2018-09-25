----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.09.2018 12:03:05
-- Design Name: 
-- Module Name: data_path - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity data_path is
    Port ( clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (127 downto 0);
           ce: in STD_LOGIC;
          
           data_out : out STD_LOGIC_VECTOR (127 downto 0);
           key_in : in STD_LOGIC_VECTOR (127 downto 0));
           
end data_path;

architecture Behavioral of data_path is

signal data1, data2,data3,data4,data_mul : std_logic_vector(127 to 0);
signal key_ex :  STD_LOGIC_VECTOR (127 downto 0);

component Exor is 
    Port ( exor_in : in STD_LOGIC_VECTOR (127 downto 0);
           key_in : in STD_LOGIC_VECTOR (127 downto 0);
           exor_out : out STD_LOGIC_VECTOR (127 downto 0));
end component;

component ByteSub is
   port( BS_in :in std_logic_vector( 7 downto 0 );
         BS_out :out std_logic_vector( 7 downto 0 )
);
end component;

component ShiftRow is 
  port (  shiftrow_in : in std_logic_vector(127 downto 0);
          shiftrow_out : out std_logic_vector(127 downto 0));
end component;


component MixColumn is 
	port (	MC_in : in std_logic_vector (127 downto 0);
			MC_out : out std_logic_vector(127 downto 0)
			);
end component;

component Keyscheduler is 
	port( roundcounter:	 	in STD_LOGIC_VECTOR(3 downto 0);
			clock:            in std_logic; 
			reset:            in std_logic;
			ce:            in std_logic;
			key:    	 			in std_logic_vector(127 downto 0);
			key_out:				out std_logic_vector(127 downto 0)
	);
end component;


component control_p is
    Port ( 
    reset : in STD_LOGIC;
        clock : in STD_LOGIC;
        timers : in STD_LOGIC_VECTOR(2 downto 0);
        
        multiplex_state: out STD_LOGIC;
        done: out STD_LOGIC;
        ce: in STD_LOGIC
       );
end component;

begin

EX1: Exor port map( exor_in => data_mul, key_in => key_ex, exor_out => data1);
BS: Bytesub port map (BS_in => data1, BS_out => data2);
SR: ShiftRow port map (shiftrow_in => data2, shiftrow_out => data3);
MC: mixColumn port map(MC_in => data3, MC_out => data4);
KS: Keyscheduler port map ( roundcounter => data1, clock => clock, reset => reset, ce => ce, key => key_in, key_out => key_ex);

process (rising_edge(clock),multiplex_state)
    begin
         if rising_edge(clock) and multiplex_state = '0' then 
               data_mul = data_in;
             else
               data_mul = data4;
             end if;
    end process

--roundcounter => data1 NOG AANPASSEN!
        



end Behavioral;
