----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.05.2023 13:12:09
-- Design Name: 
-- Module Name: Pipeline - Behavioral
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

entity MicroProcesseur is
--  Port ( );
end MicroProcesseur;

architecture Behavioral of MicroProcesseur is
-------------------------------
--Déclaration des composants --
-------------------------------
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
COMPONENT Memoire_d_instructions
PORT(
    Adresse : in STD_LOGIC_VECTOR (7 downto 0);
    CLK : in STD_LOGIC;
    Sortie : out STD_LOGIC_VECTOR (7 downto 0)
);
END COMPONENT;
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
COMPONENT UAL
    PORT(  EntreeA : in STD_LOGIC_VECTOR (7 downto 0);
           EntreeB : in STD_LOGIC_VECTOR (7 downto 0);
           Sortie : out STD_LOGIC_VECTOR (7 downto 0);
           CTRL : in STD_LOGIC_VECTOR (2 downto 0);
           N : out STD_LOGIC;
           O : out STD_LOGIC;
           Z : out STD_LOGIC;
           C : out STD_LOGIC);
END COMPONENT;
COMPONENT Compteur
    Port ( CLK : in STD_LOGIC;
       RST : in STD_LOGIC;
       LOAD : in STD_LOGIC;
       SENS : in STD_LOGIC;
       EN : in STD_LOGIC;
       Din : in STD_LOGIC_VECTOR (7 downto 0);
       Dout : out STD_LOGIC_VECTOR (7 downto 0));
end Component;
-------------------------------
--      Signaux <=> fils     --
-------------------------------
signal SignalCLK : std_logic := '0';
signal SignalInstruction : std_logic_vector (7 downto 0);
signal SignalSensClock : std_logic := '1';
signal SignalRSTClock : std_logic := '0';
signal SignalLOADJUMP : std_logic := '0';
signal SignalLOADInstruction : std_logic_vector (7 downto 0) := (others => '0');
Signal ClockEN : std_logic := '0';
Signal PC : std_logic_vector (7 downto 0) := (others=>'0'); 

    ---Signaux Pipeline---
    
signal pipLiOP : std_logic_vector (7 downto 0);
signal pipLiA : std_logic_vector (7 downto 0);
signal pipLiB : std_logic_vector (7 downto 0);
signal pipLiC : std_logic_vector (7 downto 0);

signal pipDiOP : std_logic_vector (7 downto 0);
signal pipDiA : std_logic_vector (7 downto 0);
signal pipDiB : std_logic_vector (7 downto 0);
signal pipDiC : std_logic_vector (7 downto 0);

signal pipExOP : std_logic_vector (7 downto 0);
signal pipExA : std_logic_vector (7 downto 0);
signal pipExB : std_logic_vector (7 downto 0);
signal pipExC : std_logic_vector (7 downto 0);

signal pipMemOP : std_logic_vector (7 downto 0);
signal pipMemA : std_logic_vector (7 downto 0);
signal pipMemB : std_logic_vector (7 downto 0);
signal pipMemC : std_logic_vector (7 downto 0);

constant Clock_period : time := 10 ns;
begin

-------------------------------
--    Cablage des fils       --
-------------------------------

Label_instruction: Memoire_d_instructions PORT MAP (
    Adresse => SignalInstruction,
    CLK => SignalCLK,
    Sortie(31 downto 24) => pipLiOP,
    Sortie(23 downto 16) => pipLiA,
    Sortie(15 downto 8) => pipLiB,
    Sortie(7 downto 0) => pipLiC
);

Label_compteur : Compteur PORT MAP (
    CLK=>SignalCLK,
    SENS => SignalSensClock,
    RST=>SignalRSTClock,
    LOAD => SignalLOADJUMP,
    Din => SignalLOADInstruction,
    EN => ClockEN,
    Dout => PC
);

-------------------------------
--Création de la clock       --
-------------------------------
Clock_process : process
begin
SignalCLK <= not(SignalCLK);
wait for Clock_period/2;
end process;

pipeline_process : process
begin

pipDiOP <= pipLiOP;
pipDiA <= pipLiA when;
pipDiB <= pipLiB;
pipDiC <= pipLiC;


pipExOP <= pipDiOP;
pipExA <= pipDiA;
pipExB <= pipDiB;
pipExC <= pipDiC;

pipMemOP <= pipExOP;
pipMemA <= pipExA;
pipMemB <= pipExB;
pipMemC <= pipExC;

end process;

end Behavioral;
