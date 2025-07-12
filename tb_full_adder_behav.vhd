--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:40:18 07/11/2025
-- Design Name:   
-- Module Name:   /home/ise/ise_projects/ISEAufgaben/tb_full_adder_behav.vhd
-- Project Name:  ISEAufgaben
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: full_adder_behav
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
--USE ieee.numeric_std.ALL;
 
ENTITY tb_full_adder_behav IS
END tb_full_adder_behav;
 
ARCHITECTURE behavior OF tb_full_adder_behav IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT full_adder_behav
    PORT(
         a : IN  std_logic;
         b : IN  std_logic;
         cin : IN  std_logic;
         sum : OUT  std_logic;
         cout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic := '0';
   signal b : std_logic := '0';
   signal cin : std_logic := '0';
   signal sum : std_logic := '0';
   signal cout : std_logic := '0';
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
	
	 -- Expected outputs
    type logic_array is array (0 to 7) of std_logic;
    constant inputs_a : logic_array := ('0', '0', '0', '0', '1', '1', '1', '1');
	 constant inputs_b : logic_array := ('0', '0', '1', '1', '0', '0', '1', '1');
	 constant inputs_cin : logic_array := ('0', '1', '0', '1', '0', '1', '0', '1');
	 constant expected_sum : logic_array := ('0', '1', '1', '0', '1', '0', '0', '1');
	 constant expected_cout : logic_array := ('0', '0', '0', '1', '0', '1', '1', '1');
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: full_adder_behav PORT MAP (
          a => a,
          b => b,
          cin => cin,
          sum => sum,
          cout => cout
        );

   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
		for i in 0 to 7 loop
            a   <= inputs_a(i);
            b   <= inputs_b(i);
            cin <= inputs_cin(i);

            wait for 20 ns;

            assert sum = expected_sum(i)
                report "SUM wrong at test " & integer'image(i) severity error;
            assert cout = expected_cout(i)
                report "COUT wrong at test " & integer'image(i) severity error;
        end loop;

        report "All behavioral full adder tests passed." severity note;
      wait;
   end process;

END;
