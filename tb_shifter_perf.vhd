--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:54:23 07/13/2025
-- Design Name:   
-- Module Name:   /home/ise/ise_projects/ISEAufgaben/tb_shifter_perf.vhd
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
use ieee.std_logic_unsigned.all;
 
entity tb_shifter_perf is
end tb_shifter_perf;

architecture behavior of tb_shifter_perf is

  -- Signale für shifter_concurrent4
  signal x1, y1 : std_logic_vector(3 downto 0);
  signal c1     : std_logic_vector(1 downto 0);

  -- Signale für shifter_concurrent_select4
  signal x2, y2 : std_logic_vector(3 downto 0);
  signal c2     : std_logic_vector(1 downto 0);

  -- Signale für shifter_sequential4
  signal x3, y3 : std_logic_vector(3 downto 0);
  signal c3     : std_logic_vector(1 downto 0);

  -- Signale für shifter_sequential_case4
  signal x4, y4 : std_logic_vector(3 downto 0);
  signal c4     : std_logic_vector(1 downto 0);

  signal start_time, end_time : time;

  -- Komponenten
  component shifter_concurrent4
    port (
      x : in  std_logic_vector(3 downto 0);
      c : in  std_logic_vector(1 downto 0);
      y : out std_logic_vector(3 downto 0)
    );
  end component;

  component shifter_concurrent_select4
    port (
      x : in  std_logic_vector(3 downto 0);
      c : in  std_logic_vector(1 downto 0);
      y : out std_logic_vector(3 downto 0)
    );
  end component;

  component shifter_sequential4
    port (
      x : in  std_logic_vector(3 downto 0);
      c : in  std_logic_vector(1 downto 0);
      y : out std_logic_vector(3 downto 0)
    );
  end component;

  component shifter_sequential_case4
    port (
      x : in  std_logic_vector(3 downto 0);
      c : in  std_logic_vector(1 downto 0);
      y : out std_logic_vector(3 downto 0)
    );
  end component;

begin

  -- Instanziierung aller vier Shifter
  uut1: shifter_concurrent4 port map(x1, c1, y1);
  uut2: shifter_concurrent_select4 port map(x2, c2, y2);
  uut3: shifter_sequential4 port map(x3, c3, y3);
  uut4: shifter_sequential_case4 port map(x4, c4, y4);

  -- Hauptprozess
  process
	  variable start_time : time;
	  variable end_time   : time;
  begin
    -- ==== SHIFTER 1 ====
    start_time := now;
    for i in 0 to 15 loop
      for j in 0 to 3 loop
        x1 <= std_logic_vector(to_unsigned(i, 4));
        c1 <= std_logic_vector(to_unsigned(j, 2));
        wait for 1 ns;
      end loop;
    end loop;
    end_time := now;
    report "shifter_concurrent4 (when else): " & time'image(end_time - start_time);

    -- ==== SHIFTER 2 ====
    x1 <= (others => '0'); c1 <= (others => '0'); wait for 10 ns;
    start_time := now;
    for i in 0 to 15 loop
      for j in 0 to 3 loop
        x2 <= std_logic_vector(to_unsigned(i, 4));
        c2 <= std_logic_vector(to_unsigned(j, 2));
        wait for 1 ns;
      end loop;
    end loop;
    end_time := now;
    report "shifter_concurrent_select4 (with select): " & time'image(end_time - start_time);

    -- ==== SHIFTER 3 ====
    x2 <= (others => '0'); c2 <= (others => '0'); wait for 10 ns;
    start_time := now;
    for i in 0 to 15 loop
      for j in 0 to 3 loop
        x3 <= std_logic_vector(to_unsigned(i, 4));
        c3 <= std_logic_vector(to_unsigned(j, 2));
        wait for 1 ns;
      end loop;
    end loop;
    end_time := now;
    report "shifter_sequential4 (if then else): " & time'image(end_time - start_time);

    -- ==== SHIFTER 4 ====
    x3 <= (others => '0'); c3 <= (others => '0'); wait for 10 ns;
    start_time := now;
    for i in 0 to 15 loop
      for j in 0 to 3 loop
        x4 <= std_logic_vector(to_unsigned(i, 4));
        c4 <= std_logic_vector(to_unsigned(j, 2));
        wait for 1 ns;
      end loop;
    end loop;
    end_time := now;
    report "shifter_sequential_case4 (case): " & time'image(end_time - start_time);

    wait;
  end process;


END;
