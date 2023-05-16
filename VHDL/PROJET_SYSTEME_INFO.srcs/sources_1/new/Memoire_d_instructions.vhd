----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.05.2023 10:56:38
-- Design Name: 
-- Module Name: Memoire_d_instructions - Behavioral
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

entity Memoire_d_instructions is
    Port ( Adresse : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           Sortie : out STD_LOGIC_VECTOR (31 downto 0));
end Memoire_d_instructions;

architecture Behavioral of Memoire_d_instructions is
    type mem_array is array(0 to 255) of std_logic_vector(31 downto 0);
    signal memory : mem_array := (others => (others => '0'));
begin
    Sortie <= memory(to_integer(unsigned(Adresse)));

end Behavioral;
