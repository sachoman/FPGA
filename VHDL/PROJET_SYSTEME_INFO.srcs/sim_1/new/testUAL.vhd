library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity testUAL is
end testUAL;
architecture Behavioral of testUAL is
-- Component Declaration for the Unit Under Test (UUT)
COMPONENT UAL
    PORT(  EntreeA : in STD_LOGIC_VECTOR (7 downto 0);
           EntreeB : in STD_LOGIC_VECTOR (7 downto 0);
           Sortie : out STD_LOGIC_VECTOR (7 downto 0);
           CTRL : in STD_LOGIC_VECTOR (2 downto 0);
           N : out STD_LOGIC;
           O : out STD_LOGIC;
           Z : out STD_LOGIC;
           C : out STD_LOGIC);
END COMPONENT;
--Inputs
signal SignalA: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
signal SignalB:  STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
signal SignalCTRL : STD_LOGIC_VECTOR (2 downto 0) := "000";
--Outputs
signal SignalSortie : STD_LOGIC_VECTOR (7 downto 0);
signal SignalN : STD_LOGIC;
signal SignalZ: STD_LOGIC;
signal SignalO : STD_LOGIC;
signal SignalC : STD_LOGIC;

begin
-- Instantiate the Unit Under Test (UUT)
Label_uut: UAL PORT MAP (
    EntreeA => SignalA,
    EntreeB => SignalB,
    CTRL => SignalCTRL,
    Sortie => SignalSortie,
    N => SignalN,
    O => SignalO,
    Z => SignalZ,
    C => SignalC
    );

-- Stimulus process
-- T1 < T2 et T3 < T4
SignalA <= "00001000" after 100 ns, "00010000" after 200 ns, "00001000" after 300 ns, "00001000" after 400 ns;
SignalB <= "00001000" after 100 ns, "00010000" after 200 ns, "00001000" after 300 ns, "00001000" after 400 ns;
SignalCTRL <= "000" after 100 ns, "001" after 200 ns;
end;
