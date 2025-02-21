----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.10.2024 19:43:46
-- Design Name: 
-- Module Name: fsm101 - Behavioral
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

entity fsm101 is
  Port ( 
    x: in std_logic;
    clk: in std_logic;
    rst: in std_logic;
    patronReconocido: out std_logic
  
  );
end fsm101;

architecture Behavioral of fsm101 is

    type state_type is(S0,S1,S2,S3);
    signal current_state, next_state: state_type;
begin

    process(clk,rst)
    begin   
        if rst='1' then 
            current_state <= S0;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;
    
    process(current_state, x)
    begin
        next_state <= current_state;
        
        case current_state is
             when S0 =>
             patronReconocido<='0';
                if x='1' then
                    next_state <= S1;
                else --si es un 0
                    next_state <= S0;
                 end if;
                 
             when S1 =>
             patronReconocido<='0';
                if x='1' then
                    next_state <= S1;
                else
                    next_state <= S2;
                end if;
                
              when S2 =>
              patronReconocido<='0';
                if x='1' then
                    next_state <= S3;
                else 
                    next_state <= S0;
                end if;
                  
               when S3 =>
                    patronReconocido<='1';
                    if x='1' then
                        next_state<=S1;
                    else
                        next_state<=S2;
                    end if;
               when others =>
                    next_state<=S0;
                end case;
                
               end process;

end Behavioral;
