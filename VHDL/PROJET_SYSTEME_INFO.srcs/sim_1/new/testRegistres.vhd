----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.05.2023 09:53:40
-- Design Name: 
-- Module Name: testRegistres - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity testRegistres is
end testRegistres;

architecture Behavioral of testRegistres is
-- Component Declaration for the Unit Under Test (UUT)
COMPONENT Banc_de_registres
PORT(
   EntreeA : in STD_LOGIC_VECTOR (3 downto 0);
   EntreeB : in STD_LOGIC_VECTOR (3 downto 0);
   EntreeW : in STD_LOGIC_VECTOR (3 downto 0);
   W : in STD_LOGIC;
   DATA : in STD_LOGIC_VECTOR (7 downto 0);
   RST : in STD_LOGIC;
   CLK : in STD_LOGIC;
   SortieA : out STD_LOGIC_VECTOR (7 downto 0);
   SortieB : out STD_LOGIC_VECTOR (7 downto 0)
);
END COMPONENT;
--Inputs
    signal SignalEntreeA : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal SignalEntreeB : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal SignalEntreeW : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal SignalW : STD_LOGIC := '1';
    signal SignalDATA : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal SignalRST : STD_LOGIC := '0';
    signal SignalCLK : STD_LOGIC := '0';
    signal SignalSortieA : STD_LOGIC_VECTOR (7 downto 0);
    signal SignalSortieB : STD_LOGIC_VECTOR (7 downto 0);
-- Clock period definitions
-- Si 100 MHz
constant Clock_period : time := 10 ns;
begin
-- Instantiate the Unit Under Test (UUT)
Label_uut: Banc_de_registres PORT MAP (
    EntreeA => SignalEntreeA,
    EntreeB => SignalEntreeB,
    EntreeW => SignalEntreeW,
    W => SignalW,
    DATA => SignalDATA,
    RST => SignalRST,
    CLK => SignalCLK,
    SortieA => SignalSortieA,
    SortieB => SignalSortieB
);
-- Clock process definitions
Clock_process : process
begin
SignalCLK <= not(SignalCLK);
wait for Clock_period/2;
end process;
-- Stimulus process
-- T1 < T2 et T3 < T4
SignalRST <= '1';
SignalEntreeW <= "0101" after 20 ns, "1010" after 40 ns;
SignalW <= '0' after 60 ns;
SignalDATA <= "01010101" after 1 ns, "11111111" after 20 ns;
SignalEntreeA <= "0101" after 1 ns, "1010" after 40 ns, "0101" after 60 ns, "1111" after 80 ns;
SignalEntreeB <= "0000" after 1 ns, "0101" after 20 ns;
end;