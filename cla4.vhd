----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:38:59 07/12/2025 
-- Design Name: 
-- Module Name:    cla_adder4 - Behavioral 
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

entity cla_adder4 is
	Port (
			  a    : in  std_logic_vector(3 downto 0);
			  b    : in  std_logic_vector(3 downto 0);
			  cin  : in  std_logic;
			  sum  : out std_logic_vector(3 downto 0);
			  cout : out std_logic
		 );
end cla_adder4;

architecture Behavioral of cla_adder4 is
	signal g, p : std_logic_vector(3 downto 0);
   signal c    : std_logic_vector(4 downto 0);
begin
	 c(0) <= cin;

    gen_and_prop: for i in 0 to 3 generate
        g(i) <= a(i) and b(i);
        p(i) <= a(i) xor b(i);
    end generate;

    c(1) <= g(0) or (p(0) and c(0));
    c(2) <= g(1) or (p(1) and g(0)) or (p(1) and p(0) and c(0));
    c(3) <= g(2) or (p(2) and g(1)) or (p(2) and p(1) and g(0)) or (p(2) and p(1) and p(0) and c(0));
    c(4) <= g(3) or (p(3) and g(2)) or (p(3) and p(2) and g(1)) or
                 (p(3) and p(2) and p(1) and g(0)) or
                 (p(3) and p(2) and p(1) and p(0) and c(0));

    sum(0) <= p(0) xor c(0);
    sum(1) <= p(1) xor c(1);
    sum(2) <= p(2) xor c(2);
    sum(3) <= p(3) xor c(3);
    cout   <= c(4);
end Behavioral;

