----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:50:48 07/12/2025 
-- Design Name: 
-- Module Name:    counter_sync4 - Behavioral 
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

entity counter_sync4 is
  Port (
    clk    : in  std_logic;
    reset  : in  std_logic;         -- nullaktiv
    count  : out std_logic_vector(3 downto 0)
  );
end counter_sync4;

architecture Behavioral of counter_sync4 is
	signal counter : unsigned(3 downto 0) := (others => '0');
begin
  process(clk)
  begin
    if rising_edge(clk) then -- Reset wird nur bei Taktflanke wirksam
      if reset = '0' then
        counter <= (others => '0');
      else
        counter <= counter + 1;
      end if;
    end if;
  end process;

  count <= std_logic_vector(counter);
end Behavioral;

