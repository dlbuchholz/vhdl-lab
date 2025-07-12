--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:19:35 07/12/2025
-- Design Name:   
-- Module Name:   /home/ise/ise_projects/ISEAufgaben/tb_ripple_adder4.vhd
-- Project Name:  ISEAufgaben
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ripple_adder4
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
 
ENTITY tb_ripple_adder4 IS
END tb_ripple_adder4;
 
ARCHITECTURE behavior OF tb_ripple_adder4 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ripple_adder4
    PORT(
         a : IN  std_logic_vector(3 downto 0);
         b : IN  std_logic_vector(3 downto 0);
         cin : IN  std_logic;
         sum : OUT  std_logic_vector(3 downto 0);
         cout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(3 downto 0) := (others => '0');
   signal b : std_logic_vector(3 downto 0) := (others => '0');
   signal cin : std_logic := '0';

 	--Outputs
   signal sum : std_logic_vector(3 downto 0);
   signal cout : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ripple_adder4 PORT MAP (
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
 

  
   stim_proc: process
        variable a_v, b_v  : std_logic_vector(3 downto 0);
        variable cin_v     : std_logic;
        variable expected_sum  : std_logic_vector(3 downto 0);
        variable expected_cout : std_logic;
        variable i_a, i_b, i_c, total : integer;
    begin
        for i in 0 to 511 loop
            -- Extract values as integers
            i_a := (i / 32) mod 16;
            i_b := (i / 2)  mod 16;
            i_c := i mod 2;

            -- Convert to signals/logic
            a_v := std_logic_vector(to_unsigned(i_a, 4));
            b_v := std_logic_vector(to_unsigned(i_b, 4));
            cin_v := std_logic'val(i_c);

            -- Calculate expected result from integers
            total := i_a + i_b + i_c;
            expected_sum  := std_logic_vector(to_unsigned(total mod 16, 4));
            if (total / 16) mod 2 = 0 then
					 expected_cout := '0';
				else
					 expected_cout := '1';
				end if;

            -- Assign signals *after* calculation
            a   <= a_v;
            b   <= b_v;
            if i_c = 0 then
					 cin <= '0';
				else
					 cin <= '1';
				end if;

            wait for 20 ns;

            -- Assertions
            assert sum = expected_sum
                report "SUM mismatch for i=" & integer'image(i) &
                       " expected=" & integer'image(to_integer(unsigned(expected_sum))) &
                       " actual=" & integer'image(to_integer(unsigned(sum))) severity error;

            assert cout = expected_cout
                report "COUT mismatch for i=" & integer'image(i) &
                       " expected=" & std_logic'image(expected_cout) &
                       " actual=" & std_logic'image(cout) severity error;
        end loop;

        report "All ripple adder test cases passed successfully." severity note;
        wait;
    end process;

END;
