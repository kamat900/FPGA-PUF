
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


library ieee;
    use ieee.std_logic_1164.all;

entity dff_sync_reset is
    port (
        data  :in  std_logic; -- Data input
        clk   :in  std_logic; -- Clock input
        q     :out std_logic  -- Q output

    );
end entity;

architecture rtl of dff_sync_reset is

begin
    process (clk) begin
        if (rising_edge(clk)) then
                q <= data;
            end if;
    end process;

end architecture;

--*=======================*=====================
library ieee;
use ieee.std_logic_1164.all;

entity bitStage is
   port( A, B, C, D, E, F, G, H, I, J : in std_logic;
                 P, Q : out std_logic);
end bitStage;
--
architecture Func of  bitStage is

   component Arbiterstage is      
      port( A, B, C  : in std_logic;
            F, G : out std_logic);
   end component;
	
	signal outUp1, outDo1, outUp2, outDo2,outUp3, outDo3, outUp4, outDo4, outUp5, outDo5, outUp6, outDo6, outUp7, outDo7, outUp8, outDo8 : std_logic;



begin
	G7: Arbiterstage   port map(A, B, C, outUp1, outDo1); 
	G8: Arbiterstage   port map(outUp1, outDo1, D, outUp2, outDo2); 
	G9: Arbiterstage   port map(outUp2, outDo2, E, outUp3, outDo3); 
	G10: Arbiterstage   port map(outUp3, outDo3, F, outUp4, outDo4); 
	G11: Arbiterstage   port map(outUp4, outDo4, G, outUp5, outDo5); 
	G12: Arbiterstage   port map(outUp5, outDo5, H, outUp6, outDo6);  
	G13: Arbiterstage   port map(outUp6, outDo6, I, outUp7, outDo7);  
	G14: Arbiterstage   port map(outUp7, outDo7, J, outUp8, outDo8);  
	G15: P<=outUp8;
		Q<=outDo8;
end Func;


--*=======================*=====================
library ieee;
use ieee.std_logic_1164.all;

entity sevenbitStage is
   port( A, B, C, D, E, F, G, H, I : in std_logic;
                 P, Q : out std_logic);
end sevenbitStage;
--
architecture Func of  sevenbitStage is

   component Arbiterstage is      
      port( A, B, C  : in std_logic;
            F, G : out std_logic);
   end component;
	
	signal outUp1, outDo1, outUp2, outDo2,outUp3, outDo3, outUp4, outDo4, outUp5, outDo5, outUp6, outDo6, outUp7, outDo7 : std_logic;



begin
	G7: Arbiterstage   port map(A, B, C, outUp1, outDo1); 
	G8: Arbiterstage   port map(outUp1, outDo1, D, outUp2, outDo2); 
	G9: Arbiterstage   port map(outUp2, outDo2, E, outUp3, outDo3); 
	G10: Arbiterstage   port map(outUp3, outDo3, F, outUp4, outDo4); 
	G11: Arbiterstage   port map(outUp4, outDo4, G, outUp5, outDo5); 
	G12: Arbiterstage   port map(outUp5, outDo5, H, outUp6, outDo6);  
	G13: Arbiterstage   port map(outUp6, outDo6, I, outUp7, outDo7);   
	G15: P<=outUp7;
		Q<=outDo7;
end Func;




--	Now we write the definition for a Multistage Arbiter
library ieee;
use ieee.std_logic_1164.all;

entity MultiArbiter is
   port( DIP1, DIP2, DIP3, DIP4, DIP5, DIP6, DIP7, DIP8, SWITCH1, SWITCH2 : in std_logic;
                 LED1, LED2 : out std_logic);
end MultiArbiter;
--
architecture Behavior of MultiArbiter is

   component  bitStage is      
      port( A, B, C, D, E, F, G, H, I, J  : in std_logic;
            P, Q : out std_logic);
   end component;
   component  sevenbitStage is      
      port( A, B, C, D, E, F, G, H, I  : in std_logic;
            P, Q : out std_logic);
   end component;
	component Arbiterstage is      
      port( A, B, C  : in std_logic;
            F, G : out std_logic);
   end component;
   component dff_sync_reset is
      port( data, clk  : in std_logic;
            q : inout std_logic);
   end component;
	
   signal outUp1, outDo1, outUp2, outDo2, outUp3, outDo3, outUp4, outDo4, outUp5, outDo5, outUp6, outDo6, outUp7, outDo7, outUp8, outDo8, outUp9, outDo9, ret : std_logic;
   signal inUp : std_logic;
	signal inDo : std_logic;

begin
	inUp<= not SWITCH1;
	inDo<= not SWITCH1;
	G16: bitStage   port map(inUp, inDo, DIP1, DIP2, DIP3, DIP4, DIP5, DIP6, DIP7, DIP8, outUp1, outDo1); 
	G17: bitStage   port map(outUp1, outDo1, DIP1, DIP2, DIP3, DIP4, DIP5, DIP6, DIP7, DIP8, outUp2, outDo2);
	G18: bitStage   port map(outUp2, outDo2, DIP1, DIP2, DIP3, DIP4, DIP5, DIP6, DIP7, DIP8, outUp3, outDo3);
	G19: bitStage   port map(outUp3, outDo3, DIP1, DIP2, DIP3, DIP4, DIP5, DIP6, DIP7, DIP8, outUp4, outDo4);
	G20: bitStage   port map(outUp4, outDo4, DIP1, DIP2, DIP3, DIP4, DIP5, DIP6, DIP7, DIP8, outUp5, outDo5);
	G21: bitStage   port map(outUp5, outDo5, DIP1, DIP2, DIP3, DIP4, DIP5, DIP6, DIP7, DIP8, outUp6, outDo6);
	G22: bitStage   port map(outUp6, outDo6, DIP1, DIP2, DIP3, DIP4, DIP5, DIP6, DIP7, DIP8, outUp7, outDo7);
	G23: sevenbitStage   port map(outUp7, outDo7, DIP1, DIP2, DIP3, DIP4, DIP5, DIP6, DIP7, outUp8, outDo8);
	G24: Arbiterstage port map(outUp8, outDo8, SWITCH2, outUp9, outDo9);
	G25: dff_sync_reset	port map(outUp9, outDo9, ret);
	G26:	LED1<=ret;
	LED2<= not ret;
end Behavior;