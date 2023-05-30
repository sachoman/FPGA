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
       Dout : out STD_LOGIC_VECTOR (7 downto 0);
       NOPE : out STD_LOGIC);
end Component;

COMPONENT Banc_sp
    Port (  W : in STD_LOGIC;
          DATA : in STD_LOGIC_VECTOR (7 downto 0);
          RST : in STD_LOGIC;
          CLK : in STD_LOGIC;
          SortieSP : out STD_LOGIC_VECTOR (7 downto 0));
end Component;
-------------------------------
--      Signaux <=> fils     --
-------------------------------
signal SignalNope : std_logic := '0';
signal SignalCLK : std_logic := '0';
signal SignalSensClock : std_logic := '1';
signal SignalRSTClock : std_logic := '0';
signal SignalLOADJUMP : std_logic := '0';
signal SignalLOADInstruction : std_logic_vector (7 downto 0) := (others => '0');
Signal ClockEN : std_logic := '0';
Signal PC : std_logic_vector (7 downto 0) := (others=>'0'); 

    ---Signaux Pipeline---
signal pipOP : std_logic_vector (7 downto 0);
    
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

signal ResetSP : std_logic := '0';
signal outSP : std_logic_vector(7 downto 0);

signal ResetRegistres : std_logic := '0';
signal rega : std_logic_vector (7 downto 0);
signal regb : STD_LOGIC_VECTOR (7 downto 0);

signal outalu : std_logic_vector (7 downto 0);
signal flago : std_logic := '0';
signal flagc : std_logic := '0';
signal flagn : std_logic := '0';
signal flagz : std_logic := '0';

signal resetdonnees : std_logic :='0';
signal outdonnees : std_logic_vector (7 downto 0);

signal outmux0 : std_logic_vector (7 downto 0);
signal outmux1 : std_logic_vector (7 downto 0);
signal outmux2 : std_logic_vector (7 downto 0);
signal outMUX3 : STD_LOGIC_VECTOR (7 downto 0);
signal outMUX4 : STD_LOGIC_VECTOR (7 downto 0);
signal outMUX5 : STD_LOGIC_VECTOR (7 downto 0);
signal outMUX6 : STD_LOGIC_VECTOR (7 downto 0);
signal outMUX7 : STD_LOGIC_VECTOR (7 downto 0);
signal outMUX8 : STD_LOGIC;
signal outLC1 :  std_logic := '0';
signal outLC2 : std_logic_vector (7 downto 0);
signal outLc3 : std_logic :='1';
signal outlc4 : std_logic := '0';

constant Clock_period : time := 10 ns;
begin

-------------------------------
--    Cablage des fils       --
-------------------------------

Label_instruction: Memoire_d_instructions PORT MAP (
    Adresse => PC,
    CLK => SignalCLK,
    Sortie(31 downto 24) => pipOP,
    Sortie(23 downto 16) => pipLiA,
    Sortie(15 downto 8) => pipLiB,
    Sortie(7 downto 0) => pipLiC
);

Label_banc_sp : Banc_sp PORT MAP (
     W => outLC1,
         DATA => outMUX7,
         RST => ResetSP,
         CLK => SignalCLK,
         SortieSP=> outSP
);

Label_compteur : Compteur PORT MAP (
    CLK=>SignalCLK,
    SENS => SignalSensClock,
    RST=>SignalRSTClock,
    LOAD => outmux8,
    Din => pipDiB,
    EN => ClockEN,
    Dout => PC,
    NOPE => SignalNope
);
Label_registres : Banc_de_registres PORT MAP (
   EntreeA => pipLiB,
   EntreeB => pipliC,
   EntreeW => pipmemA,
   W => outlc4,
   DATA => pipmemb,
   RST => resetregistres,
   CLK => signalclk,
   SortieA => rega,
   SortieB => regb
);
Label_alu : UAL PORT MAP (
     EntreeA => pipdib,
      EntreeB => outmux3,
      Sortie => outalu,
      CTRL => outlc2,
      N => flagn,
      O=>flago,
      Z => flagz,
      C => flagc
);
-------------------------------
Label_donness : Memoire_de_donneees PORT MAP(
    Adresse => pipexb,
    Entree => pipexc,
    RW => outlc3,
    RST => resetdonnees,
    CLK => signalclk,
    Sortie => outdonnees
);
-------------------------------
--Création de la clock       --
-------------------------------
Clock_process : process
begin
SignalCLK <= not(SignalCLK);
wait for Clock_period/2;
end process;

--MUX0
outmux0 <= x"00" when SignalNOPE = '1' else pipOP;
pipLiOP <= outmux0;

---------------
--etage LI / DI
---------------

pipDiOP <= pipLiOP;
pipDiA <= pipLiA;
    --MUX 1
     outmux1 <= rega when pipliop = x"01" or pipliop = x"02" or pipliop = x"03" or pipliop = x"04" or pipliop = x"05" or pipliop = x"06" or pipliop = x"07" or pipliop = x"08" or pipliop = x"09" or pipliop = x"0A" or pipliop = x"0B" or pipliop = x"0C";
     outmux1 <= piplib when pipliop = x"12" or pipliop = x"11" or  pipliop = x"17" or pipliop = x"14" or pipliop = x"15" or pipliop = x"16";
     outmux1 <= outSP when pipliop = x"0F" or pipliop = x"13" or pipliop = x"0D" or pipliop =x"0E" or pipliop = x"10";
   
   --MUX 2
    outmux2 <= regb when pipliop = x"15" or pipliop = x"16" or pipliop = x"11" or  pipliop = x"17"  or pipliop = x"01" or pipliop = x"02" or pipliop = x"03" or pipliop = x"04" or pipliop = x"05" or pipliop = x"06" or pipliop = x"07" or pipliop = x"08" or pipliop = x"09" or pipliop = x"0A" or pipliop = x"0B" or pipliop = x"0C";
    outmux2 <= outSP when pipliop = x"12" or pipliop = x"10";
    outmux2 <= regA when pipliop = x"0F" or pipliop = x"13";
    outmux2 <= piplib when pipliop =x"0E";

pipDIb <= outmux1;
pipdic <= outmux2;


-------------
--etage DI/EX
-------------

pipexa <= pipdia;
pipexop <= pipdiop;

    --MUX8
    outmux8 <= '1' when pipdiop = x"14" or (pipdiop = x"15" and pipdic = x"01") or (pipdiop=x"16" and pipdic = x"00") else '0';
    
    --MUX3
    outmux3 <= pipdic when pipdiop = x"11" or pipdiop = x"17" or pipdiop = x"12" or pipdiop = x"01" or pipdiop = x"02" or pipdiop = x"03" or pipdiop = x"04" or pipdiop = x"05" or pipdiop = x"06" or pipdiop = x"07" or pipdiop = x"08" or pipdiop = x"09" or pipdiop = x"0A" or pipdiop = x"0B" or pipdiop = x"0C";
    outmux3 <= x"01" when pipdiop = x"0F" or pipdiop = x"0d" or pipdiop = x"0e" or pipdiop=x"10";
    outmux3 <= pipdia when pipdiop = x"13";
    
    --LC2
    outlc2 <= pipdiop when pipdiop = x"01" or pipdiop = x"02" or pipdiop = x"03" or pipdiop = x"04" or pipdiop = x"05" or pipdiop = x"06" or pipdiop = x"07" or pipdiop = x"08" or pipdiop = x"09" or pipdiop = x"0A" or pipdiop = x"0B" or pipdiop = x"0C";
    outlc2 <= x"02" when pipdiop = x"12" or pipdiop = x"0d" or pipdiop = x"13" or pipdiop = x"11" or pipdiop = x"17";
    outlc2 <= x"01" when pipdiop = x"0f" or pipdiop = x"0e" or pipdiop = x"10";
    
    --MUX4
    outmux4 <= outalu when pipdiop = x"0e" or pipdiop = x"10" or pipdiop = x"11" or pipdiop = x"17" or pipdiop = x"12" or pipdiop = x"0f" or pipdiop = x"13" or pipdiop = x"01" or pipdiop = x"02" or pipdiop = x"03" or pipdiop = x"04" or pipdiop = x"05" or pipdiop = x"06" or pipdiop = x"07" or pipdiop = x"08" or pipdiop = x"09" or pipdiop = x"0A" or pipdiop = x"0B" or pipdiop = x"0C";
    outmux4 <= pipdib when pipdiop = x"0d";
    
pipexb <= outmux4;

    --MUX5
    outmux5 <= pipdic when pipdiop = x"0f" or pipdiop =x"13" or pipdiop = x"0e" or pipdiop=x"10";
    outmux5 <= outalu when pipdiop = x"0d";
    
pipexc <= outmux5;   

 -------------
--etage EX/MEM
--------------

pipmema <= pipexa;
pipmemop <= pipexop;
pipmemc <=pipexc;

    --LC3
    outlc3 <= '0' when pipexop = x"0f" or pipexop = x"13" or pipexop = x"0e" or pipexop = x"10" else '1';
    
    --MUX6
    outmux6 <= pipexb when pipexop =x"10" or pipexop = x"0e" or pipexop = x"0f" or pipexop = x"01" or pipexop = x"02" or pipexop = x"03" or pipexop = x"04" or pipexop = x"05" or pipexop = x"06" or pipexop = x"07" or pipexop = x"08" or pipexop = x"09" or pipexop = x"0A" or pipexop = x"0B" or pipexop = x"0C";
    outmux6 <= outdonnees when pipexop = x"12" or pipexop = x"0d" or pipexop = x"11" or pipexop = x"17" ;

pipmemb <= outmux6;

--------------
--etage MEM/LI
--------------

    --LC1
    outlc1 <= '1' when pipmemop = x"0f" or pipmemop = x"0d" or pipmemop = x"0e" or pipmemop =x"10" or pipmemop = x"17" else '0';
    
    --LC4
    outlc4 <= '0' when pipmemop = x"0f" or pipmemop = x"13" or pipmemop = x"0e" or pipmemop = x"10" or pipmemop = x"14" or pipmemop=x"15" or pipmemop=x"16" or pipmemop = x"17" else '1';

    --MUX7
    outmux7 <= pipmemb when pipmemop = x"0f" or pipmemop = x"0e" or pipmemop = x"10" or pipmemop=x"17" else pipmemc;
 
end Behavioral;
