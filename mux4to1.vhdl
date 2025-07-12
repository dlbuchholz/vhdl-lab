----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:45:50 07/11/2025 
-- Design Name: 
-- Module Name:    mux4to1 - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux4to1 is
	Port (
		sel : in STD_LOGIC_VECTOR(1 downto 0);
		a, b, c, d : STD_LOGIC;
		y : out STD_LOGIC
		);
end mux4to1;

architecture Behavioral of mux4to1 is
	begin
		process(sel, a, b, c, d)
		begin
			case sel is
				when "00" => y <= a;
				when "01" => y <= b;
				when "10" => y <= c;
				when "11" => y <= d;
				when others => y <= 'X';
			end case;
		end process;
end Behavioral;

