
                        --	This is the AND gate
library ieee;
use ieee.std_logic_1164.all;

entity andGate is	
   port( A, B : in std_logic;
            F : out std_logic);
end andGate;

architecture func of andGate is 
begin
   F <= A and B; 
end func;
--*============================
                        --	This is the OR gate
library ieee;
use ieee.std_logic_1164.all;

entity orGate is 
   port( A, B : in std_logic;
            F : out std_logic);
end orGate;

architecture func of orGate is 
begin
   F <= A or B; 
end func;
--*============================
                        --	This is the NOT gate
library ieee;
use ieee.std_logic_1164.all;

entity notGate is	
   port( inPort : in std_logic;
        outPort : out std_logic);
end notGate;
--
architecture func of notGate is 
begin
  outPort <= not inPort; 
end func;
--*=======================*=====================

--	Now we write the definition for the 2-to-1 Mux
library ieee;
use ieee.std_logic_1164.all;

entity Mux_2_to_1 is
   port( A, B, C : in std_logic;
                 F : out std_logic);
end Mux_2_to_1;
--
architecture Func of Mux_2_to_1 is

   component andGate is          --import AND Gate entity
      port( A, B : in std_logic;
               F : out std_logic);
   end component;
 
   component orGate is           --import OR Gate entity
      port(	A, B : in std_logic;
               F : out std_logic);
   end component;

   component notGate is         --import NOT Gate entity
      port( inPort  : in std_logic;
            outPort : out std_logic);
   end component;

   signal andOut1, andOut2, invOut: std_logic;

begin
    -- Just like the real circuit, there 
    -- are four components: G1 to G4
   G1: notGate  port map(C, invOut);
   G2: andGate  port map(invOut, A, andOut1);
   G3: andGate  port map(C, B, andOut2);
   G4: orGate   port map(andOut1, andOut2, F); -- F
end Func;

--*=======================*=====================

--	Now we write the definition for a single Arbiter Stage: 2 Mux
library ieee;
use ieee.std_logic_1164.all;

entity Arbiterstage is
   port( A, B, C : in std_logic;
                 F, G : out std_logic);
end Arbiterstage;
--
architecture Func of Arbiterstage is

   component Mux_2_to_1 is         --import NOT Gate entity
      port( A, B, C  : in std_logic;
            F : out std_logic);
   end component;


begin
				G5: Mux_2_to_1   port map(A, B, C, F); 
				G6: Mux_2_to_1   port map(B, A, C, G); 
end Func;


--*=======================*=====================

--	Now we write the definition SR-Latch

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity S_R_latch_top is
    Port ( A : in    STD_LOGIC;
           B : in    STD_LOGIC;
           F : inout STD_LOGIC); -- changed out to inout
end S_R_latch_top;

architecture Behavioral of S_R_latch_top is
signal notQ : STD_LOGIC;
begin

F    <= B nor notQ;
notQ <= A nor F;

end Behavioral;



--*=======================*=====================

--	Now we write the definition for a Multistage Arbiter
library ieee;
use ieee.std_logic_1164.all;

entity MultiArbiter is
   port( DIP1, DIP2, DIP3, DIP4, DIP5, DIP6, DIP7, DIP8 : in std_logic;
                 LED1 : out std_logic);
end MultiArbiter;
--
architecture Behavior of MultiArbiter is

   component Arbiterstage is      
      port( A, B, C  : in std_logic;
            F, G : out std_logic);
   end component;
	
   component S_R_latch_top is       
      port( A, B  : in std_logic;
            F : inout std_logic);
   end component;
	
   signal outUp1, outDo1, outUp2, outDo2,outUp3, outDo3, outUp4, outDo4, outUp5, outDo5, outUp6, outDo6, ret : std_logic;
   signal inUp : std_logic;
	signal inDo : std_logic;

begin
	inUp<='1';
	inDo<='1';
	G7: Arbiterstage   port map(inUp, inDo, DIP3, outUp1, outDo1); 
	G8: Arbiterstage   port map(outUp1, outDo1, DIP4, outUp2, outDo2); 
	G9: Arbiterstage   port map(outUp2, outDo2, DIP5, outUp3, outDo3); 
	G10: Arbiterstage   port map(outUp3, outDo3, DIP6, outUp4, outDo4); 
	G11: Arbiterstage   port map(outUp4, outDo4, DIP7, outUp5, outDo5); 
	G12: Arbiterstage   port map(outUp5, outDo5, DIP8, outUp6, outDo6);  
	G13: S_R_latch_top	port map(outUp6, outDo6, ret);
	G14: LED1<=ret;
end Behavior;