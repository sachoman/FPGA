----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.05.2023 10:24:09
-- Design Name: 
-- Module Name: Memoire_de_donneees - Behavioral
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

entity Memoire_de_donneees is
    Port ( Adresse : in STD_LOGIC_VECTOR (7 downto 0);
           Entree : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           Sortie : out STD_LOGIC_VECTOR (7 downto 0));
end Memoire_de_donneees;

architecture Behavioral of Memoire_de_donneees is
    type mem_array is array(0 to 255) of std_logic_vector(7 downto 0);
    signal memory : mem_array := (others => (others => '0'));
begin
process (CLK)
    begin
        if rising_edge(CLK) then
            if RST = '0' then
                memory <= (others => (others => '0'));
            elsif RW = '0' then
                memory(to_integer(unsigned(Adresse))) <= Entree;
            end if;
        end if;
    end process;
    Sortie <= memory(to_integer(unsigned(Adresse)));

end Behavioral;
