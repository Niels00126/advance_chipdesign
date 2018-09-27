----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.09.2018 11:16:03
-- Design Name: 
-- Module Name: AES128 - Behavioral
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

entity AES128 is
    Port ( data_in_tb : in STD_LOGIC_VECTOR (127 downto 0);
           data_out_tb : out STD_LOGIC_VECTOR (127 downto 0);
           clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           ce : in STD_LOGIC;
           key_in_tb : in STD_LOGIC_VECTOR (127 downto 0);
           done : out STD_LOGIC);
end AES128;

architecture Behavioral of AES128 is

signal round_counter: STD_LOGIC_VECTOR(3 downto 0);
signal  multiplex_state: STD_LOGIC_VECTOR(1 downto 0);

component data_path is
    Port ( clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (127 downto 0);
           ce: in STD_LOGIC;
           multiplex_state: in STD_LOGIC_VECTOR(1 downto 0);
           data_out : out STD_LOGIC_VECTOR (127 downto 0);
           round_counter: out STD_LOGIC_VECTOR(3 downto 0);
           key_in : in STD_LOGIC_VECTOR (127 downto 0));
           
end component;

component control_p is
    Port ( 
        reset : in STD_LOGIC;
        clock : in STD_LOGIC;
        multiplex_state: out STD_LOGIC_VECTOR(1 downto 0);
        done: out STD_LOGIC;
        ce: in STD_LOGIC;
         roundcounter_out: out STD_LOGIC_VECTOR(3 downto 0)
       );
end component;


begin

DP: data_path Port map ( clock => clock,
                          reset => reset, 
                          data_in => data_in_tb, 
                          ce => ce, 
                          data_out => data_out_tb, 
                          key_in => key_in_tb,
                          multiplex_state => multiplex_state,
                          round_counter => round_counter);
                          
CP: control_p Port map( reset => reset,
                        clock => clock,
                        multiplex_state => multiplex_state,
                        done => done ,
                        ce => ce ,
                        roundcounter_out => round_counter);


end Behavioral;
