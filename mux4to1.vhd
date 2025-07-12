--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:53:53 07/11/2025
-- Design Name:   
-- Module Name:   /media/F533-8DAD/VHDL_Aufgaben/ISEAufgaben/mux4to1.vhd
-- Project Name:  ISEAufgaben
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mux4to1
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
 
ENTITY tb_mux4to1 IS
END tb_mux4to1;
 
ARCHITECTURE behavior OF tb_mux4to1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux4to1
    PORT(
         sel : IN  std_logic_vector(1 downto 0);
         a : IN  std_logic;
         b : IN  std_logic;
         c : IN  std_logic;
         d : IN  std_logic;
         y : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal sel : std_logic_vector(1 downto 0) := (others => '0');
   signal a : std_logic := '0';
   signal b : std_logic := '0';
   signal c : std_logic := '0';
   signal d : std_logic := '0';

 	--Outputs
   signal y : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mux4to1 PORT MAP (
          sel => sel,
          a => a,
          b => b,
          c => c,
          d => d,
          y => y
        );

   -- Clock process definitions
   --<clock>_process :process
   --begin
	--	<clock> <= '0';
	--	wait for <clock>_period/2;
	--	<clock> <= '1';
	--	wait for <clock>_period/2;
   --end process;
 

   -- Stimulus process
   stim_proc: process
   begin
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      --wait for <clock>_period*10;
		
      -- insert stimulus here 
		a <= '0';
		b <= '1';
		c <= '0';
		d <= '1';
		sel <= "00"; wait for 10 ns;
		sel <= "01"; wait for 10 ns;
		sel <= "10"; wait for 10 ns;
		sel <= "11"; wait for 10 ns;
      wait;
   end process;

END;
