----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:14:47 07/12/2025 
-- Design Name: 
-- Module Name:    ripple_adder4 - Structural 
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

entity ripple_adder4 is
    Port (
        a     : in  std_logic_vector(3 downto 0); -- 4bit
        b     : in  std_logic_vector(3 downto 0);
        cin   : in  std_logic;
        sum   : out std_logic_vector(3 downto 0);
        cout  : out std_logic
    );
end ripple_adder4;

architecture Structural of ripple_adder4 is

    component full_adder_struct
        Port (
            a, b, cin : in  std_logic;
            sum, cout : out std_logic
        );
    end component;

    signal c : std_logic_vector(4 downto 0); -- Carry chain

begin
    c(0) <= cin;

    FA0: full_adder_struct port map(a => a(0), b => b(0), cin => c(0), sum => sum(0), cout => c(1));
    FA1: full_adder_struct port map(a => a(1), b => b(1), cin => c(1), sum => sum(1), cout => c(2));
    FA2: full_adder_struct port map(a => a(2), b => b(2), cin => c(2), sum => sum(2), cout => c(3));
    FA3: full_adder_struct port map(a => a(3), b => b(3), cin => c(3), sum => sum(3), cout => c(4));

    cout <= c(4);

end Structural;

