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

entity Banc_sp is
    Port ( 
           W : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           SortieSP : out STD_LOGIC_VECTOR (7 downto 0));
end Banc_sp;

architecture Behavioral of Banc_sp is
  signal registerSP : STD_logic_vector(7 downto 0) := (others => '0'); -- Tableau de registres
begin
  process (CLK)
    begin
      if rising_edge(CLK) then
        if RST = '0' then
          registerSP <= (others => '0'); -- Remise à zéro des registres
        elsif W = '1' then
          registerSP <= DATA;
        end if;
      end if;
    end process;
  SortieSP <= registerSP;
end Behavioral;
