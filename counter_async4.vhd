----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:52:25 07/12/2025 
-- Design Name: 
-- Module Name:    counter_async4 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter_async4 is
  Port (
    clk    : in  std_logic;
    reset  : in  std_logic;         -- nullaktiv
    count  : out std_logic_vector(3 downto 0)
  );
end counter_async4;

architecture Behavioral of counter_async4 is
  signal counter : unsigned(3 downto 0) := (others => '0');
begin
  process(clk, reset)
  begin
    if reset = '0' then -- Reset sofort, unabhängig von der Taktflanke
      counter <= (others => '0');
    elsif rising_edge(clk) then
      counter <= counter + 1;
    end if;
  end process;

  count <= std_logic_vector(counter);
end Behavioral;

