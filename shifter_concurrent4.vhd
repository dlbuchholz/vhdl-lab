----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:22:58 07/13/2025 
-- Design Name: 
-- Module Name:    shifter_concurrent4 - Behavioral 
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
-- Concurrent version using 'when else'
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

entity shifter_concurrent4 is
port (
    X : in  std_logic_vector(3 downto 0);
    C : in  std_logic_vector(1 downto 0);
    Y : out std_logic_vector(3 downto 0)
  );
end shifter_concurrent4;

architecture Behavioral of shifter_concurrent4 is
begin
  Y <= X(2 downto 0) & '0' when C = "01" else -- Shift left
       '0' & X(3 downto 1) when C = "10" else -- Shift right
       X;                                    -- No shift
end Behavioral;

