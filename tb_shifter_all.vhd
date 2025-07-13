--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:31:52 07/13/2025
-- Design Name:   
-- Module Name:   /home/ise/ise_projects/ISEAufgaben/tb_shifter_all.vhd
-- Project Name:  ISEAufgaben
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: shifter_concurrent4
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
 
entity tb_shifter_all is
end entity;

architecture behavior of tb_shifter_all is
  -- Eingangssignale
  signal X : std_logic_vector(3 downto 0) := "0000";
  signal C : std_logic_vector(1 downto 0) := "00";

  -- Ausgangssignale aller Varianten
  signal y_when_else      : std_logic_vector(3 downto 0) := (others => '0');
  signal y_if_then_else   : std_logic_vector(3 downto 0) := (others => '0');
  signal y_with_select    : std_logic_vector(3 downto 0) := (others => '0');
  signal y_case           : std_logic_vector(3 downto 0) := (others => '0');

  -- Erwarteter Output
  signal Y_expected 		  : std_logic_vector(3 downto 0):= (others => '0');

begin

  -- Komponente: when else
  uut_when_else: entity work.shifter_concurrent4
    port map (X => X, C => C, Y => Y_when_else);

  -- Komponente: if then else
  uut_if_then_else: entity work.shifter_sequential4
    port map (X => X, C => C, Y => Y_if_then_else);

  -- Komponente: with select when
  uut_with_select: entity work.shifter_concurrent_select4
    port map (X => X, C => C, Y => Y_with_select);

  -- Komponente: case
  uut_case: entity work.shifter_sequential_case4
    port map (X => X, C => C, Y => Y_case);

  -- Stimuli-Prozess
  stim_proc: process
  begin
	 wait for 100 ns;
    for i in 0 to 15 loop
      X <= std_logic_vector(to_unsigned(i, 4));
      for ctrl in 0 to 3 loop
        C <= std_logic_vector(to_unsigned(ctrl, 2));
		  
		  wait for 1ns;
        -- Erwarteten Output setzen
        case C is
        when "01" => -- Shift left
          Y_expected <= X(2 downto 0) & '0';
        when "10" => -- Shift right
          Y_expected <= '0' & X(3 downto 1);
        when others =>
          Y_expected <= X;
		  end case;

        wait for 10 ns;

        -- Vergleiche alle Varianten mit expected
        assert Y_when_else = Y_expected
          report "Mismatch in WHEN ELSE for X=" & integer'image(i) & " C=" & integer'image(ctrl)
          severity error;

        assert Y_if_then_else = Y_expected
          report "Mismatch in IF THEN ELSE for X=" & integer'image(i) & " C=" & integer'image(ctrl)
          severity error;

        assert Y_with_select = Y_expected
          report "Mismatch in WITH SELECT for X=" & integer'image(i) & " C=" & integer'image(ctrl)
          severity error;

        assert Y_case = Y_expected
          report "Mismatch in CASE for X=" & integer'image(i) & " C=" & integer'image(ctrl)
          severity error;
      end loop;
    end loop;

    wait;
  end process;

END;
