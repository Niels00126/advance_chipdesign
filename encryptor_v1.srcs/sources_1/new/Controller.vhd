----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.09.2018 09:26:11
-- Design Name: 
-- Module Name: Controller - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Controller is
    Port ( data_in : in STD_LOGIC_VECTOR (127 downto 0);
           enable:            in std_logic;
           ce:            in std_logic;
           clock:            in std_logic;
           reset:            in std_logic;
           
           done:            out std_logic;
           data_out : out STD_LOGIC_VECTOR (127 downto 0));
end Controller;

architecture Behavioral of Controller is

signal counter : unsigned(3 downto 0);

begin

P2:process
type Codes_Of_Operation is (ADD,SUB,MULT,DIV);
variable Code_Variable: Codes_Of_Operation;
begin
  C3: case Code_Variable is
      when ADD | SUB => Operation := 0;
      when MULT | DIV => Operation := 1;
  end case C3;
end process;



end Behavioral;
