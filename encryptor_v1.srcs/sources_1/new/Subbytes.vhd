----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.09.2018 15:11:57
-- Design Name: 
-- Module Name: Subbytes - Behavioral
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

entity Subbytes is
    Port ( sub_in : in STD_LOGIC_VECTOR (127 downto 0);
           sub_out : out STD_LOGIC_VECTOR (127 downto 0));
end Subbytes;

architecture Behavioral of Subbytes is

    component ByteSub is
   port( BS_in :in std_logic_vector( 7 downto 0 );
         BS_out :out std_logic_vector( 7 downto 0 )
   );
end component;

begin

q1 : ByteSub port map (sub_in(127 downto 120),sub_out(127 downto 120)); 
q2 : ByteSub port map (sub_in(119 downto 112),sub_out(119 downto 112)); 
q3 : ByteSub port map (sub_in(111 downto 104),sub_out(111 downto 104)); 
q4 : ByteSub port map (sub_in(103 downto 96),sub_out(103 downto 96)); 
q5 : ByteSub port map (sub_in(95 downto 88),sub_out(95 downto 88)); 
q6 : ByteSub port map (sub_in(87 downto 80),sub_out(87 downto 80)); 
q7 : ByteSub port map (sub_in(79 downto 72),sub_out(79 downto 72)); 
q8 : ByteSub port map (sub_in(71 downto 64),sub_out(71 downto 64)); 
q9 : ByteSub port map (sub_in(63 downto 56),sub_out(63 downto 56)); 
q10 : ByteSub port map (sub_in(55 downto 48),sub_out(55 downto 48)); 
q11 : ByteSub port map (sub_in(47 downto 40),sub_out(47 downto 40)); 
q12 : ByteSub port map (sub_in(39 downto 32),sub_out(39 downto 32)); 
q13 : ByteSub port map (sub_in(31 downto 24),sub_out(31 downto 24)); 
q14 : ByteSub port map (sub_in(23 downto 16),sub_out(23 downto 16)); 
q15 : ByteSub port map (sub_in(15 downto 8),sub_out(15 downto 8)); 
q16 : ByteSub port map (sub_in(7 downto 0),sub_out(7 downto 0)); 



end Behavioral;
