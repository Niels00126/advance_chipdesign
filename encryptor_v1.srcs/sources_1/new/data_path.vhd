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
          multiplex_state: in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (127 downto 0);
           round_counter: in STD_LOGIC_VECTOR(3 downto 0);
           key_in : in STD_LOGIC_VECTOR (127 downto 0));
           
end data_path;

architecture Behavioral of data_path is


signal key_ex ,data_round_in :  STD_LOGIC_VECTOR (127 downto 0);

signal data_after_round1, data_after_round2, data_after_round3 ,data_after_round4 ,data_after_round5, :STD_LOGIC_VECTOR (127 downto 0);
signal data_after_round6, data_after_round7 ,data_after_round8, data_after_round9, data_after_round10, :STD_LOGIC_VECTOR (127 downto 0);

component round is
    Port ( round_in : in STD_LOGIC_VECTOR (127 downto 0);
           key_in: in STD_LOGIC_VECTOR (127 downto 0);
           enable: in STD_LOGIC;
           reset: in STD_LOGIC;
            clock : in STD_LOGIC;
           round_out : out STD_LOGIC_VECTOR (127 downto 0));
end component;

component round_last is
      Port ( last_round_in : in STD_LOGIC_VECTOR (127 downto 0);
           key_in: in STD_LOGIC_VECTOR (127 downto 0);
           enable: in STD_LOGIC;
           reset: in STD_LOGIC;
            clock : in STD_LOGIC;
           last_round_out : out STD_LOGIC_VECTOR (127 downto 0));
end component;


begin
  
  data_doorvoer: process (clock)
      begin
           if rising_edge(clock)and multiplex_state = '1' then 
                 data_round_in <= data_after_round;
               elsif rising_edge(clock)and multiplex_state = '0' then
                 data_round_in <= data_in;
               else
               end if;
  end process;
  
Rd1: round port map (data_in, key_in, ce, reset, clock, data_after_round1);
Rd2: round port map (data_after_round1, key_in, ce, reset, clock, data_after_round2);
Rd3: round port map (data_after_round2, key_in, ce, reset, clock, data_after_round3);

Rd4: round port map (data_after_round3, key_in, ce, reset, clock, data_after_round4);
Rd5: round port map (data_after_round4, key_in, ce, reset, clock, data_after_round5);
Rd6: round port map (data_after_round5, key_in, ce, reset, clock, data_after_round6);

Rd7: round port map (data_after_round6, key_in, ce, reset, clock, data_after_round7);
Rd8: round port map (data_after_round7, key_in, ce, reset, clock, data_after_round8);
Rd9: round port map (data_after_round8, key_in, ce, reset, clock, data_after_round9);

RL: round_last port map (data_after_round9, key_in, ce, reset, clock, data_out);



  
--  FSM_switchstate: process (clock)
--    begin
--           if rising_edge(clock) and round_counter > "0000" and round_counter < "1010" then 
          
--           Rd: round port map ( round_in => data_round_in,
--                                                  key_in => key_in ,
--                                                  enable => ce,
--                                                  reset => reset,
--                                                   clock => clock ,
--                                                  round_out => data_after_round);
              
                   
--        else
--          data_out <= data_in;
--        end if;
--    end process;
  


end Behavioral;
