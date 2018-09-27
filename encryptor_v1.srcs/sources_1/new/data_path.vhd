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
           multiplex_state: in STD_LOGIC_VECTOR(1 downto 0);
           data_out : out STD_LOGIC_VECTOR (127 downto 0);
           round_counter: in STD_LOGIC_VECTOR(3 downto 0);
           key_in : in STD_LOGIC_VECTOR (127 downto 0));
           
end data_path;

architecture Behavioral of data_path is


signal key_ex ,data_round_in :  STD_LOGIC_VECTOR (127 downto 0);

signal data_after_round,data_round_tussen :STD_LOGIC_VECTOR (127 downto 0);
signal multiplex_state2: STD_LOGIC_VECTOR(1 downto 0);

component round is
    Port ( round_in : in STD_LOGIC_VECTOR (127 downto 0);
           key_in: in STD_LOGIC_VECTOR (127 downto 0);
           enable: in STD_LOGIC;
           reset: in STD_LOGIC;
            clock : in STD_LOGIC;
            round_counter: in STD_LOGIC_VECTOR (3 downto 0);
             round_tussen: out STD_LOGIC_VECTOR (127 downto 0); 
           round_out : out STD_LOGIC_VECTOR (127 downto 0));
end component;



begin
  
  data_doorvoer: process (multiplex_state,data_after_round,data_in)
      begin
           if  multiplex_state = "01" then 
                 data_round_in <= data_after_round;
               elsif  multiplex_state = "00" then
                 data_round_in <= data_in;
               elsif  multiplex_state = "11" then   
                 data_out <= data_round_tussen;
               else
               end if;
      end process;
  
  --Rd1: round port map (data_round_in, key_in, ce, reset, clock, data_after_round);
    --RL: round_last port map (data_round_in, key_in, ce, reset, clock, data_out);

 Rd1: round port map (data_round_in, key_in, ce, reset, clock,round_counter,data_round_tussen, data_after_round);
 

 

           
   

end Behavioral;
