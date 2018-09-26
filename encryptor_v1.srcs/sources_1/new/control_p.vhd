----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.09.2018 10:44:06
-- Design Name: 
-- Module Name: control_p - Behavioral
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

entity control_p is
    Port ( 
        reset : in STD_LOGIC;
        clock : in STD_LOGIC;
        multiplex_state: out STD_LOGIC;
        done: out STD_LOGIC;
        ce: in STD_LOGIC;
         roundcounter_out: out STD_LOGIC_VECTOR(3 downto 0)
       );
end control_p;

architecture Behavioral of control_p is

  type tStates is (idle, round_till_nine, round_last, after_encrypt);
  signal curState, nxtState : tStates;
  signal roundcounter: STD_LOGIC_VECTOR(3 downto 0);  
  signal timer0, timer1, timer2 : STD_LOGIC;


begin


  FSM_switchstate : process (reset, clock)
  begin
    if reset = '1' then 
      curState <= idle;
      roundcounter <= "0000";
    elsif rising_edge(clock)and ce = '1' then 
      curState <= nxtState; 
    end if;
  end process;




FSM_nextstate : process (curState, clock )
  begin
  case curState is
      
        when idle =>
          if rising_edge(clock) and ce = '1' then 
            nxtState <= round_till_nine;
          else
            nxtState <= idle;
          end if;
  
              
        when round_till_nine =>
            if rising_edge(clock) and roundcounter = "1001" then 
              nxtState <= round_last;
            elsif rising_edge(clock) and roundcounter < "1001" then
             nxtState <= round_till_nine;
             roundcounter <= roundcounter and "0001";
            else
              nxtState <= round_till_nine;
            end if;
            
   
          when round_last =>
            if rising_edge(clock) then 
                nxtState <= after_encrypt ;
                roundcounter <= "1010";
            else
                  nxtState <= after_encrypt;
            end if;
      
      when after_encrypt =>
          if rising_edge(clock) then 
              nxtState <=  idle;
          else
                nxtState <= after_encrypt;
                roundcounter <= "1011";
          end if;
         
      when others =>
            nxtState <= idle;
    end case;
      
      
  end process;
  
  
  
  FSM_output : process (curState)
    begin
      case curState is
      
        when after_encrypt => roundcounter_out <= roundcounter; done <= '1'; multiplex_state <= '1';
        when round_till_nine => roundcounter_out <= roundcounter; done <= '0';  multiplex_state <= '1';
        when others => roundcounter_out <= roundcounter; done <= '0'; multiplex_state <= '0'; 
        
      end case;
    end process;
  
  
  end Behavioral;
