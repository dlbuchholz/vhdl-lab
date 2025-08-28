-- Testbench für fifo_sc
-- Dennis L. Buchholz
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_fifo_sc is
end entity;

architecture sim of tb_fifo_sc is
  constant WIDTH : positive := 8;
  constant DEPTH : positive := 16;

  signal clk   : std_logic := '0';
  signal rst_n : std_logic := '0';

  signal wr_en : std_logic := '0';
  signal din   : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
  signal full  : std_logic;

  signal rd_en : std_logic := '0';
  signal dout  : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
  signal empty : std_logic;

  signal count : unsigned(4 downto 0); -- reicht für DEPTH<=16

  -- Referenzmodell (einfacher Ringpuffer)
  type vec_array is array (0 to DEPTH*8-1) of std_logic_vector(WIDTH-1 downto 0);
  signal model_mem   : vec_array := (others => (others => '0'));
  signal model_head  : natural := 0;  -- nächster zum Lesen
  signal model_tail  : natural := 0;  -- nächster zum Schreiben
  signal model_count : natural := 0;

  -- Erwartungs-Pipeline für registrierte FIFO-Ausgabe
  signal exp_valid_d    : std_logic := '0';
  signal exp_value_d    : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
  signal exp_valid_next : std_logic := '0';
  signal exp_value_next : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
begin
  -- DUT
  dut: entity work.fifo_sc
    generic map (WIDTH => WIDTH, DEPTH => DEPTH)
    port map (
      clk   => clk,
      rst_n => rst_n,
      wr_en => wr_en,
      din   => din,
      full  => full,
      rd_en => rd_en,
      dout  => dout,
      empty => empty,
      count => count
    );

  -- 100 MHz Takt
  clk <= not clk after 5 ns;

  -- Reset
  process
  begin
    rst_n <= '0';
    wait for 25 ns;
    wait until rising_edge(clk);
    rst_n <= '1';
    wait;
  end process;

  -- Erwartungs-Pipeline um 1 Takt verzögert, da FIFO registriert ausliest
  process(clk)
  begin
    if rising_edge(clk) then
      exp_valid_d <= exp_valid_next;
      exp_value_d <= exp_value_next;
    end if;
  end process;

  -- Vergleich der Daten, wenn in der Vorperiode ein Read-Handshake stattgefunden hat
  process(clk)
  begin
    if rising_edge(clk) then
      if exp_valid_d = '1' then
        assert dout = exp_value_d
          report "Datenfehler: erwartet " &
                 integer'image(to_integer(unsigned(exp_value_d))) &
                 ", erhalten " &
                 integer'image(to_integer(unsigned(dout)))
          severity error;
      end if;
    end if;
  end process;

  -- Stimulus deterministisch
  stimulus: process
    variable wdata : std_logic_vector(WIDTH-1 downto 0);
    variable val   : unsigned(WIDTH-1 downto 0) := (others => '0');
    variable i     : integer;
  begin
    -- auf Resetende warten
    wait until rst_n = '1';
    wait until rising_edge(clk);

    ----------------------------------------------------------------
    -- Phase 1: Füllen bis full mit Werten 0 .. DEPTH-2
    ----------------------------------------------------------------
    wr_en <= '0'; rd_en <= '0';
    while full = '0' loop
      wait until rising_edge(clk);
      if full = '0' then
        wdata := std_logic_vector(val);
        wr_en <= '1';
        din   <= wdata;

        -- Referenzmodell synchron aktualisieren
        model_mem(model_tail) <= wdata;
        model_tail  <= model_tail + 1;
        model_count <= model_count + 1;

        val := val + 1;
      else
        wr_en <= '0';
      end if;
      exp_valid_next <= '0'; -- in dieser Phase nicht lesen
    end loop;
    wait until rising_edge(clk);
    wr_en <= '0';
    assert full  = '1' report "full sollte nach Füllen = '1' sein" severity error;
    assert empty = '0' report "empty sollte nach Füllen = '0' sein" severity error;

    ----------------------------------------------------------------
    -- Phase 2: Leeren bis empty, Reihenfolge prüfen
    ----------------------------------------------------------------
    while empty = '0' loop
      wait until rising_edge(clk);
      rd_en <= '1';

      if empty = '0' then
        exp_value_next <= model_mem(model_head);
        exp_valid_next <= '1';
        model_head     <= model_head + 1;
        model_count    <= model_count - 1;
      else
        exp_valid_next <= '0';
      end if;
      wr_en <= '0';
    end loop;
    wait until rising_edge(clk);
    rd_en <= '0';
    exp_valid_next <= '0';
    assert empty = '1' report "empty sollte nach Leeren = '1' sein" severity error;
    assert full  = '0' report "full sollte nach Leeren = '0' sein" severity error;

    ----------------------------------------------------------------
    -- Phase 3: Gleichzeitiges Lesen und Schreiben über 3*DEPTH Takte
    -- Schreibwerte fortlaufend, Lesen sobald nicht leer
    -- Testet Wrap-Around der Zeiger
    ----------------------------------------------------------------
    for t in 0 to 3*DEPTH-1 loop
      wait until rising_edge(clk);

      -- Schreiben, wenn nicht voll
      if full = '0' then
        wdata := std_logic_vector(val);
        wr_en <= '1';
        din   <= wdata;

        model_mem(model_tail) <= wdata;
        model_tail  <= model_tail + 1;
        model_count <= model_count + 1;

        val := val + 1;
      else
        wr_en <= '0';
      end if;

      -- Lesen, wenn nicht leer
      if empty = '0' then
        rd_en <= '1';
        exp_value_next <= model_mem(model_head);
        exp_valid_next <= '1';
        model_head     <= model_head + 1;
        model_count    <= model_count - 1;
      else
        rd_en <= '0';
        exp_valid_next <= '0';
      end if;

      -- Flag-Konsistenz gegen Modell prüfen
      assert (full = '1')  = boolean(model_count = DEPTH-1)
        report "Flag full inkonsistent mit Modell"
        severity error;
      assert (empty = '1') = boolean(model_count = 0)
        report "Flag empty inkonsistent mit Modell"
        severity error;
    end loop;

    ----------------------------------------------------------------
    -- Phase 4: Rest leeren, am Ende empty
    ----------------------------------------------------------------
    wr_en <= '0';
    while empty = '0' loop
      wait until rising_edge(clk);
      rd_en <= '1';
      exp_value_next <= model_mem(model_head);
      exp_valid_next <= '1';
      model_head     <= model_head + 1;
      model_count    <= model_count - 1;
    end loop;
    wait until rising_edge(clk);
    rd_en <= '0';
    exp_valid_next <= '0';

    assert empty = '1' report "FIFO am Ende nicht leer" severity error;

    report "Test abgeschlossen ohne Fehler" severity note;
    wait;  -- Simulation anhalten
  end process;
end architecture;
