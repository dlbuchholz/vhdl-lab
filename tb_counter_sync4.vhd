--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:59:15 07/12/2025
-- Design Name:   
-- Module Name:   /home/ise/ise_projects/ISEAufgaben/tb_counter_sync4.vhd
-- Project Name:  ISEAufgaben
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: counter_sync4
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY tb_counter_sync4 IS
END tb_counter_sync4;
 
ARCHITECTURE behavior OF tb_counter_sync4 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT counter_sync4
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         count : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '1';

 	--Outputs
   signal count : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: counter_sync4 PORT MAP (
          clk => clk,
          reset => reset,
          count => count
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin
		-- Initial reset
      -- hold reset state for 100 ns.
		reset <= '0';
      wait for 100 ns;	
      wait for clk_period*10;
		reset <= '1';

      -- Count from 0 to 15, verify each value
        for i in 0 to 15 loop
            wait until rising_edge(clk);
            assert count = std_logic_vector(to_unsigned(i, 4))
            report "SYNC: Count mismatch at i=" & integer'image(i)
            severity error;
        end loop;

        -- Wrap around to 0
        wait until rising_edge(clk);
        assert count = "0000"
        report "SYNC: Counter did not wrap correctly to 0"
        severity error;

        -- Test reset again
        reset <= '0';
        wait for clk_period * 10;
        reset <= '1';
        wait until rising_edge(clk);
        assert count = "0000"
        report "SYNC: Counter did not reset correctly after second reset"
        severity error;
		  
		  report "All SYNC COUNTER tests passed." severity note;

        wait;
    end process;

END;
