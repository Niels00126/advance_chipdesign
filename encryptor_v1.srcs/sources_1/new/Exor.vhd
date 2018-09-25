----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.09.2018 09:16:41
-- Design Name: 
-- Module Name: Exor - Behavioral
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

entity Exor is 
    Port ( exor_in : in STD_LOGIC_VECTOR (127 downto 0);
           key_in : in STD_LOGIC_VECTOR (127 downto 0);
           exor_out : out STD_LOGIC_VECTOR (127 downto 0));
end Exor;

architecture Behavioral of Exor is

begin
    process(key_in, exor_in)
        begin
            exor_out <= exor_in xor key_in;
        end process;    
         

end Behavioral;
