----------------------------------------------------------------------------------
-- Company:
-- Engineer:
-- 
-- Create Date: 21.03.2023 15:58:50
-- Design Name:
-- Module Name: compteur8bits - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;
 
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
 
entity Compteur is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           LOAD : in STD_LOGIC;
           SENS : in STD_LOGIC;
           EN : in STD_LOGIC;
           Din : in STD_LOGIC_VECTOR (7 downto 0);
           Dout : out STD_LOGIC_VECTOR (7 downto 0));
end Compteur;
 
architecture Behavioral of Compteur is
signal aux : std_logic_vector (7 downto 0) := x"00";
 
begin
    process
        begin
            wait until CLK'event and CLK='1';
            if RST = '1' then aux <= x"00";
                elsif LOAD='1' then aux<=Din;
                    elsif EN='0' then  
                        if SENS = '0' then aux<= aux+x"01"; elsif SENS='1' then aux<=aux-x"01"; end if;
            end if;  
    end process;
    Dout <= aux;
end Behavioral;