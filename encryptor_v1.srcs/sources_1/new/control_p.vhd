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
        ce: in STD_LOGIC
       );
end control_p;

architecture Behavioral of control_p is

  type tStates is (idle, round1 , round2 , round3 , round4 , round5 , round6 , round7 , round8 , round9 , round10, after_encrypt);
  signal curState, nxtState : tStates;

  signal timer0, timer1, timer2 : STD_LOGIC;


begin


  FSM_switchstate : process (reset, clock)
  begin
    if reset = '1' then 
      curState <= idle;
    elsif rising_edge(clock)and ce = '1' then 
      curState <= nxtState; 
    end if;
  end process;




FSM_nextstate : process (curState, clock )
  begin
  case curState is
      
        when idle =>
          if rising_edge(clock) and ce = '1' then 
            nxtState <= round1;
          else
            nxtState <= idle;
          end if;
  
        when round1 =>
          if rising_edge(clock) then 
            nxtState <= round2;
          else
            nxtState <= round1;
          end if;
          
        when round2 =>
            if rising_edge(clock) then 
              nxtState <= round3;
            else
              nxtState <= round2;
            end if;
            
      when round3 =>
          if rising_edge(clock) then 
            nxtState <= round4;
          else
            nxtState <= round3;
          end if;
       
         when round4 =>
            if rising_edge(clock) then 
              nxtState <= round5;
            else
              nxtState <= round4;
            end if;
                
          when round5 =>
              if rising_edge(clock) then 
                nxtState <= round6;
              else
                nxtState <= round5;
              end if;
                  
            when round6 =>
                if rising_edge(clock) then 
                  nxtState <= round7;
                else
                  nxtState <= round6;
                end if;
              
              
            when round7 =>
              if rising_edge(clock) then 
                nxtState <= round8;
              else
                nxtState <= round7;
              end if;      
                  
          when round8 =>
                if rising_edge(clock) then 
                  nxtState <= round9;
                else
                  nxtState <= round8;
                end if;
                        
          when round9 =>
              if rising_edge(clock) then 
                    nxtState <= round10;
                  else
                    nxtState <= round9;
                  end if;
                          
          when round10 =>
            if rising_edge(clock) then 
                nxtState <= after_encrypt ;
            else
                  nxtState <= round10;
            end if;
      
      when after_encrypt =>
          if rising_edge(clock) then 
              nxtState <=  idle;
          else
                nxtState <= after_encrypt;
          end if;
         
      when others =>
            nxtState <= idle;
    end case;
      
      
  end process;
  
  
  
  FSM_output : process (curState)
    begin
      case curState is
        when after_encrypt => done <= '1'; multiplex_state <= '0';
        
        when round1 => multiplex_state <= '1'; done <= '0';
        when round2 => multiplex_state <= '1'; done <= '0';
        when round3 => multiplex_state <= '1'; done <= '0';
        when round4 => multiplex_state <= '1'; done <= '0';
        when round5 => multiplex_state <= '1'; done <= '0';
        when round6 => multiplex_state <= '1'; done <= '0';
        when round7 => multiplex_state <= '1'; done <= '0';
        when round8 => multiplex_state <= '1'; done <= '0';
        when round9 => multiplex_state <= '1'; done <= '0';
        when round10 => multiplex_state <= '1'; done <= '0';
        
        
        when others => done <= '0'; multiplex_state <= '0'; 
      end case;
    end process;
  
  
  end Behavioral;
