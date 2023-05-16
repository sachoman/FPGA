----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.05.2023 14:29:08
-- Design Name: 
-- Module Name: PipelineLIDI - Behavioral
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

entity PipelineLIDI is
--  Port ( );
    Port ( EntreeA : in STD_LOGIC_VECTOR (3 downto 0);
           EntreeB : in STD_LOGIC_VECTOR (3 downto 0);
           EntreeW : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           SortieA : out STD_LOGIC_VECTOR (7 downto 0);
           SortieB : out STD_LOGIC_VECTOR (7 downto 0));
end PipelineLIDI;

architecture Behavioral of PipelineLIDI is



begin


end Behavioral;
