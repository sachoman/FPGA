----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.05.2023 11:17:09
-- Design Name: 
-- Module Name: UAL - Behavioral
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
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UAL is
    Port ( EntreeA : in STD_LOGIC_VECTOR (7 downto 0);
           EntreeB : in STD_LOGIC_VECTOR (7 downto 0);
           Sortie : out STD_LOGIC_VECTOR (7 downto 0);
           CTRL : in STD_LOGIC_VECTOR (2 downto 0);
           N : out STD_LOGIC;
           O : out STD_LOGIC;
           Z : out STD_LOGIC;
           C : out STD_LOGIC);
end UAL;

architecture Behavioral of UAL is

signal result : std_logic_vector(15 downto 0);

    begin 
    -- Code des opérations --
    -- 01 addition
    -- 02 soustraction
    -- 03 multiplication
    -- 04 egalité
    -- 05 non-égalité
    -- 06 and
    -- 07 or
    -- 08 lt
    -- 09 gt
    -- 0A le
    -- 0B ge
    -- 0C not
    process (EntreeA, EntreeB, Ctrl)
    begin
        if CTRL = x"01" then
            result(8 downto 0) <= ('0'& EntreeA) + ('0' & EntreeB);
        elsif CTRL = x"02" then
            result(8 downto 0) <= ('0'& EntreeA) - ('0' & EntreeB);
        elsif CTRL = x"03" then
            result(15 downto 0) <= (EntreeA) * (EntreeB);
        elsif CTRL = x"04" then
            if (EntreeA) = (EntreeB) then
                result(15 downto 0) <= x"01" ;
            else result(15 downto 0) <= x"00" ;
            end if;
        elsif CTRL = x"05" then
            if (EntreeA) = (EntreeB) then
                result(15 downto 0) <= x"00" ;
            else result(15 downto 0) <= x"01" ;
            end if;
        elsif CTRL = x"06" then
                if (EntreeA = x"01") and (EntreeB = x"01") then
                    result(15 downto 0) <= x"01" ;
                else result(15 downto 0) <= x"00" ;
                end if;
        elsif CTRL = x"07" then
                if (EntreeA = x"01") or (EntreeB = x"01") then
                    result(15 downto 0) <= x"01" ;
                else result(15 downto 0) <= x"00" ;
                end if;
        elsif CTRL = x"08" then
                if (EntreeA < EntreeB) then
                    result(15 downto 0) <= x"01" ;
                else result(15 downto 0) <= x"00" ;
                end if;
        elsif CTRL = x"09" then
                if (EntreeA > EntreeB) then
                    result(15 downto 0) <= x"01" ;
                else result(15 downto 0) <= x"00" ;
                end if;
        elsif CTRL = x"0A" then
                if (EntreeA <= EntreeB) then
                    result(15 downto 0) <= x"01" ;
                else result(15 downto 0) <= x"00" ;
                end if;
        elsif CTRL = x"0B" then
                if (EntreeA >= EntreeB) then
                    result(15 downto 0) <= x"01" ;
                else result(15 downto 0) <= x"00" ;
                end if;
        elsif CTRL = x"0C" then
                if (EntreeA = x"00") then
                    result(15 downto 0) <= x"01" ;
                else result(15 downto 0) <= x"00" ;
                end if;
        end if;
      end process;

    Z<= '1' when  result(8 downto 0) = "000000000" else '0';
    O <= '1' when result(15 downto 8) /= "00000000"  else '0';
    C <= result(8);
    N <= result(7);
    Sortie <= result(7 downto 0);

end Behavioral;
