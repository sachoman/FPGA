----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.05.2023 10:19:56
-- Design Name: 
-- Module Name: Banc_de_registres - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Banc_de_registres is
    Port ( EntreeA : in STD_LOGIC_VECTOR (3 downto 0);
           EntreeB : in STD_LOGIC_VECTOR (3 downto 0);
           EntreeW : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           SortieA : out STD_LOGIC_VECTOR (7 downto 0);
           SortieB : out STD_LOGIC_VECTOR (7 downto 0));
end Banc_de_registres;

architecture Behavioral of Banc_de_registres is
  type reg_array is array(0 to 15) of std_logic_vector(7 downto 0);
  signal registers : reg_array := (others => (others => '0')); -- Tableau de registres
begin
  process (CLK)
    begin
      if rising_edge(CLK) then
        if RST = '0' then
          registers <= (others => (others => '0')); -- Remise à zéro des registres
        elsif W = '1' then
          registers(to_integer(unsigned(EntreeW))) <= DATA;
        end if;
      end if;
    end process;
  SortieA <= registers(to_integer(unsigned(EntreeA)));
  SortieB <= registers(to_integer(unsigned(EntreeB)));

end Behavioral;
