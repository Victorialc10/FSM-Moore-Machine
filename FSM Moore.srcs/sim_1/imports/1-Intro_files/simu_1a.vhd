-- Libraries needed 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_textio.ALL;
USE std.textio.ALL;

-- Entity declaration
ENTITY simfsm101 IS
END simfsm101;

-- Architecture definition
ARCHITECTURE behavior OF simfsm101 IS 

    -- Declaration of the component (FSM)
    COMPONENT fsm101
    PORT(
         x : IN  std_logic;
         clk : IN  std_logic;
         rst : IN  std_logic;
         patronReconocido : OUT std_logic
        );
    END COMPONENT;

    -- Inputs
    signal x : std_logic := '0';
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';

    -- Outputs
    signal patronReconocido : std_logic;

    -- Clock period definition
    constant clk_period : time := 50 ns;

BEGIN

    -- Instantiation of the unit under test (UUT)
    uut: fsm101 PORT MAP (
          x => x,
          clk => clk,
          rst => rst,
          patronReconocido => patronReconocido
        );

    -- Clock process
    reloj_process : process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    -- Stimuli process to test the FSM
    stim_proc: process
    begin		
        -- Reset is set to '1' for 45 ns
        rst <= '1';
        x <= '0';  -- Initial input
        wait for 45 ns;

        -- Release reset and start applying input sequences
        rst <= '0';
        wait for 50 ns;

        -- Case 1: Test pattern "101" (simple, no overlap)
        x <= '1';  -- First bit of "101"
        wait for clk_period;
        x <= '0';  -- Second bit
        wait for clk_period;
        x <= '1';  -- Third bit, here it should detect "101"
        wait for clk_period;

        -- Extra input after detecting pattern
        x <= '0';  
        wait for clk_period;

        -- Case 2: Test with overlapping pattern "101" (101101)
        x <= '1';  -- First bit of "101"
        wait for clk_period;
        x <= '0';  -- Second bit
        wait for clk_period;
        x <= '1';  -- Third bit, "101" should be detected
        wait for clk_period;
        x <= '1';  -- Start of new overlapping pattern
        wait for clk_period;
        x <= '0';  -- Middle of overlapping pattern
        wait for clk_period;
        x <= '1';  -- End of overlapping pattern, "101" detected again
        wait for clk_period;

        -- Case 3: Random sequence that doesn't match "101"
        x <= '0';  
        wait for clk_period;
        x <= '0';
        wait for clk_period;
        x <= '1';
        wait for clk_period;
        x <= '0';
        wait for clk_period;

        -- Case 4: Another sequence with multiple overlaps
        x <= '1';  -- First bit of "101"
        wait for clk_period;
        x <= '0';  -- Second bit
        wait for clk_period;
        x <= '1';  -- Third bit, "101" detected
        wait for clk_period;
        x <= '0';  -- Extra bit
        wait for clk_period;
        x <= '1';  -- Start of new "101"
        wait for clk_period;
        x <= '0';
        wait for clk_period;
        x <= '1';  -- "101" detected again
        wait for clk_period;

        -- Continue as needed
        wait;
    end process;

END behavior;
