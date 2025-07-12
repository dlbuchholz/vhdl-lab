----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:36:36 07/11/2025 
-- Design Name: 
-- Module Name:    full_adder_behav - Behavioral 
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

entity full_adder_behav is
	Port (
		a		:	in std_logic;
		b		:	in std_logic;
		cin	:	in std_logic;
		sum	:	out std_logic;
		cout	:	out std_logic
	);
end full_adder_behav;

architecture Behavioral of full_adder_behav is
begin
	process(a, b, cin)
	begin
		sum  <= a xor b xor cin;
		cout <= (a and b) or (a and cin) or (b and cin);
	end process;
end Behavioral;

