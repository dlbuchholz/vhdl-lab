----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:31:00 08/20/2025 
-- Design Name: 
-- Module Name:    fifo_sc - Behavioral 
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
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;


entity fifo_sc is
  generic (
    WIDTH : positive := 8;
    DEPTH : positive := 16       -- muss Potenz von 2 für einfache Modulo-Logik sein
  );
  port (
    clk    : in  std_logic;
    rst_n  : in  std_logic;

    -- Write side
    wr_en  : in  std_logic;
    din    : in  std_logic_vector(WIDTH-1 downto 0);
    full   : out std_logic;

    -- Read side
    rd_en  : in  std_logic;
    dout   : out std_logic_vector(WIDTH-1 downto 0);
    empty  : out std_logic;

    -- Belegung
    count  : out unsigned(integer(ceil(log2(real(DEPTH)))) downto 0)
  );
end entity;

architecture Behavioural of fifo_sc is
  -- Abgeleitete Konstanten
  function clog2(n : positive) return natural is
    variable i : natural := 0;
    variable v : natural := 1;
  begin
    while v < n loop
      v := v * 2;
      i := i + 1;
    end loop;
    return i;
  end;

  constant AW : natural := clog2(DEPTH);

  type mem_t is array (0 to DEPTH-1) of std_logic_vector(WIDTH-1 downto 0);
  signal mem  : mem_t;

  signal wptr : unsigned(AW-1 downto 0) := (others => '0');
  signal rptr : unsigned(AW-1 downto 0) := (others => '0');

  signal full_i, empty_i : std_logic;
  signal count_i         : unsigned(AW downto 0) := (others => '0');

  signal rd_fire, wr_fire : std_logic;
begin
  -- Handshake
  wr_fire <= '1' when (wr_en = '1' and full_i = '0') else '0';
  rd_fire <= '1' when (rd_en = '1' and empty_i = '0') else '0';

  -- Speicher schreiben
  process(clk)
  begin
    if rising_edge(clk) then
      if wr_fire = '1' then
        mem(to_integer(wptr)) <= din;
      end if;
    end if;
  end process;

  -- Datenausgabe registriert
  process(clk)
  begin
    if rising_edge(clk) then
      if rd_fire = '1' then
        dout <= mem(to_integer(rptr));
      end if;
    end if;
  end process;

  -- Zeiger und Zähler
  process(clk)
  begin
    if rising_edge(clk) then
      if rst_n = '0' then
        wptr    <= (others => '0');
        rptr    <= (others => '0');
        count_i <= (others => '0');
      else
        if wr_fire = '1' then
          wptr <= wptr + 1;
        end if;
        if rd_fire = '1' then
          rptr <= rptr + 1;
        end if;

        if wr_fire = '1' and rd_fire = '0' then
			 count_i <= count_i + 1;
		  elsif rd_fire = '1' and wr_fire = '0' then
			 count_i <= count_i - 1;
		  end if;
      end if;
    end if;
  end process;

  -- Status
  empty_i <= '1' when count_i = 0 else '0';
  full_i  <= '1' when count_i = DEPTH-1 else '0'; -- One-slot-empty
  empty   <= empty_i;
  full    <= full_i;
  count   <= count_i;
end architecture;

