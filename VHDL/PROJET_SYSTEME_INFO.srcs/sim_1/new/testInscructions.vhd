----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.05.2023 12:37:53
-- Design Name: 
-- Module Name: testInscructions - Behavioral
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

entity testInscructions is
--  Port ( );
end testInscructions;

architecture Behavioral of testInscructions is
COMPONENT Memoire_d_instructions
PORT(
    Adresse : in STD_LOGIC_VECTOR (7 downto 0);
    CLK : in STD_LOGIC;
    Sortie : out STD_LOGIC_VECTOR (7 downto 0)
);
END COMPONENT;
--Inputs
    signal SignalAdresse : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal SignalCLK : STD_LOGIC := '0';
    signal SignalSortie : STD_LOGIC_VECTOR (7 downto 0);
-- Clock period definitions
-- Si 100 MHz
constant Clock_period : time := 10 ns;
begin
-- Instantiate the Unit Under Test (UUT)
Label_uut: Memoire_d_instructions PORT MAP (
    Adresse => SignalAdresse,
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
SignalAdresse <= "00000001" after 1ns, "00000100" after 40 ns, "00000001" after 60ns;
end;