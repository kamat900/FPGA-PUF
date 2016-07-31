
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




--	Now we write the definition for a Multistage Arbiter
library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;

entity MultiArbiter is
   port( bitArray   : in std_logic_vector(63 downto 0);
                 retSig : out std_logic);
end MultiArbiter;
--
architecture Behavior of MultiArbiter is

   component  bitStage is      
      port( A, B, C, D, E, F, G, H, I, J  : in std_logic;
            P, Q : out std_logic);
   end component;

   component dff_sync_reset is
      port( data, clk  : in std_logic;
            q : inout std_logic);
   end component;
	
   signal outUp1, outDo1, outUp2, outDo2, outUp3, outDo3, outUp4, outDo4, outUp5, outDo5, outUp6, outDo6, outUp7, outDo7, outUp8, outDo8, outUp9, outDo9, ret : std_logic;
   signal inUp : std_logic;
	signal inDo : std_logic;

begin
	inUp<= '1';
	inDo<= '1';
	
	G16: bitStage   port map(inUp, inDo, bitArray(0), bitArray(1), bitArray(2), bitArray(3), bitArray(4), bitArray(5), bitArray(6), bitArray(7), outUp1, outDo1); 
	G17: bitStage   port map(outUp1, outDo1, bitArray(8), bitArray(9), bitArray(10), bitArray(11), bitArray(12), bitArray(13), bitArray(14), bitArray(15), outUp2, outDo2);
	G18: bitStage   port map(outUp2, outDo2, bitArray(16), bitArray(17), bitArray(18), bitArray(19), bitArray(20), bitArray(21), bitArray(22), bitArray(23), outUp3, outDo3);
	G19: bitStage   port map(outUp3, outDo3, bitArray(24), bitArray(25), bitArray(26), bitArray(27), bitArray(28), bitArray(29), bitArray(30), bitArray(31), outUp4, outDo4);
	G20: bitStage   port map(outUp4, outDo4, bitArray(32), bitArray(33), bitArray(34), bitArray(35), bitArray(36), bitArray(37), bitArray(38), bitArray(39), outUp5, outDo5);
	G21: bitStage   port map(outUp5, outDo5, bitArray(40), bitArray(41), bitArray(42), bitArray(43), bitArray(44), bitArray(45), bitArray(46), bitArray(47), outUp6, outDo6);
	G22: bitStage   port map(outUp6, outDo6, bitArray(48), bitArray(49), bitArray(50), bitArray(51), bitArray(52), bitArray(53), bitArray(54), bitArray(55), outUp7, outDo7);
	G23: bitStage   port map(outUp7, outDo7, bitArray(56), bitArray(57), bitArray(58), bitArray(59), bitArray(60), bitArray(61), bitArray(62), bitArray(63), outUp8, outDo8);
	--G24: Arbiterstage port map(outUp8, outDo8, SWITCH2, outUp9, outDo9);
	G25: dff_sync_reset	port map(outUp8, outDo8, ret);
	G26:	retSig<=ret;
end Behavior;




