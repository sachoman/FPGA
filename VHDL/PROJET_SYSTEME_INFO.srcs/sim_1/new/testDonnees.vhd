----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.05.2023 10:16:03
-- Design Name: 
-- Module Name: testDonnees - Behavioral
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

entity testDonnees is
--  Port ( );
end testDonnees;

architecture Behavioral of testDonnees is
COMPONENT Memoire_de_donneees
PORT(
    Adresse : in STD_LOGIC_VECTOR (7 downto 0);
    Entree : in STD_LOGIC_VECTOR (7 downto 0);
    RW : in STD_LOGIC;
    RST : in STD_LOGIC;
    CLK : in STD_LOGIC;
    Sortie : out STD_LOGIC_VECTOR (7 downto 0)
);
END COMPONENT;
--Inputs
    signal SignalAdresse : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal SignalEntree : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal SignalRW : STD_LOGIC := '0';
    signal SignalRST : STD_LOGIC := '0';
    signal SignalCLK : STD_LOGIC := '0';
    signal SignalSortie : STD_LOGIC_VECTOR (7 downto 0);
-- Clock period definitions
-- Si 100 MHz
constant Clock_period : time := 10 ns;
begin
-- Instantiate the Unit Under Test (UUT)
Label_uut: Memoire_de_donneees PORT MAP (
    Adresse => SignalAdresse,
    Entree => SignalEntree,
    RW => SignalRW,
    RST => SignalRST,
    CLK => SignalCLK,
    Sortie => SignalSortie
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
SignalAdresse <="00000001" after 1ns, "00000100" after 40 ns, "00000001" after 60ns;
SignalEntree <= "00000101" after 20 ns, "00001010" after 40 ns;
SignalRW <= '0' after 20ns, '1' after 30ns, '0' after 40ns, '1' after 50ns;
end;