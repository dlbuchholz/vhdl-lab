----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:26:23 07/13/2025 
-- Design Name: 
-- Module Name:    shifter_sequential_case4 - Behavioral 
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
-- Sequential version with case
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity shifter_sequential_case4 is
  port (
    X : in  std_logic_vector(3 downto 0);
    C : in  std_logic_vector(1 downto 0);
    Y : out std_logic_vector(3 downto 0)
  );
end shifter_sequential_case4;

architecture Behavioral of shifter_sequential_case4 is
begin
  process (X, C)
  begin
    case C is
      when "01" => -- Left shift
        Y <= X(2 downto 0) & '0';
      when "10" => -- Right shift
        Y <= '0' & X(3 downto 1);
      when others =>
        Y <= X;
    end case;
  end process;
end Behavioral;

