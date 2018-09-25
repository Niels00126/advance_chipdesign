library ieee;
use ieee.std_logic_1164.all;

entity FSM_example_VHDL is
  port(
    reset : in STD_LOGIC;
    clock : in STD_LOGIC;
    timers : in STD_LOGIC_VECTOR(2 downto 0);
    RED_on : out STD_LOGIC;
    ORANGE_on : out STD_LOGIC;
    GREEN_on : out STD_LOGIC
  );
end FSM_example_VHDL;

architecture Behavioural of FSM_example_VHDL is


  type tStates is (sRed, sOrangeAfterRed, sOrangeAfterGreen, sGreen);
  signal curState, nxtState : tStates;

  signal timer0, timer1, timer2 : STD_LOGIC;

begin

  timer0 <= timers(0);
  timer1 <= timers(1);
  timer2 <= timers(2);

  -------------------------------------------------------------------------------
  -- STATE REGISTER
  -------------------------------------------------------------------------------
  FSM_switchstate : process (reset, clock)
  begin
    if reset = '1' then 
      curState <= sRed;
    elsif rising_edge(clock) then 
      curState <= nxtState; 
    end if;
  end process;
  
  -------------------------------------------------------------------------------
  -- NEXT STATE FUNCTION
  -------------------------------------------------------------------------------
  FSM_nextstate : process (curState, timer0, timer1, timer2)
  begin
    case curState is
      when sRed =>
        if timer0 = '1' then 
          nxtState <= sOrangeAfterRed;
        else
          nxtState <= sRed;
        end if;

      when sGreen =>
        if timer1 = '1' then 
          nxtState <= sOrangeAfterGreen;
        else
          nxtState <= sGreen;
        end if;
		  
      when sOrangeAfterGreen =>
        if timer2 = '1' then 
          nxtState <= sRed;
        else
          nxtState <= sOrangeAfterGreen;
        end if;
		  
      when sOrangeAfterRed =>
        if timer2 = '1' then 
          nxtState <= sGreen;
        else
          nxtState <= sOrangeAfterRed;
        end if;

      when others =>
        nxtState <= sRed;
    end case;
  end process;

  -------------------------------------------------------------------------------
  -- OUTPUT FUNCTION
  -------------------------------------------------------------------------------
  FSM_output : process (curState)
  begin
    case curState is
        when R=> RED_on <= '0'; ORANGE_on <= '0'; GREEN_on <= '1'; 
      when sGreen => RED_on <= '0'; ORANGE_on <= '0'; GREEN_on <= '1'; 
		when sOrangeAfterGreen | sOrangeAfterRed => RED_on <= '0'; ORANGE_on <= '1'; GREEN_on <= '0'; 
      when others => RED_on <= '1'; ORANGE_on <= '1'; GREEN_on <= '1'; 
    end case;
  end process;

end Behavioural;
