LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_logic_unsigned.ALL;

ENTITY ledCombo IS 

GENERIC
	(
	DEVICENUM 	: 	INTEGER := 6
	);

PORT
(
	clk,reset	:		IN 	STD_LOGIC;
	ledCombination : 	OUT 	STD_LOGIC_VECTOR(DEVICENUM-1 DOWNTO 0)
);


END ledCombo;

ARCHITECTURE behavior OF ledCombo IS

SIGNAL found		: STD_LOGIC; -- found = if search loop is complete
SIGNAL clkCnt		: STD_LOGIC_VECTOR(2 DOWNTO 0)  --clkcnt = timeslice    3 bits - counts to 4 at most 
SIGNAL i				: STD_LOGIC_VECTOR(3 DOWNTO 0); --4 bits = 15, only needs to count to 5

BEGIN

ledCombination <= "100000";
clkCnt <= '0';

PROCESS(reset, clk)

	IF(reset = '0') THEN
		ledCombination <= "100000";
		clkCnt <= '0';	
	END IF;
	
	IF(rising_edge(clk) AND reset = '1') THEN
		clkCnt <= clkCnt + '1';	
		IF(clkCnt = '4') THEN-- 1 = 2pts, 2 = 1pts, 3 = 0pts, next clk combo will change 
			clkCnt = '0';
			LEDUPDATE: FOR i IN 0 TO DEVICENUM-1 	
					IF(ledCombination[i] = '1' AND i+1 = DEVICENUM AND found = '0') THEN
							ledCombination <= "100000";  											--last element in led array, [0] = 1
							found = '1';
					ELSIF(ledCombination[i] = '1' AND i+1 != DEVICENUM AND found = '0')
							ledCombination[i] = '0';
							ledCombination[i+1] = '1';
							found = '1';
					END IF;		
			END LOOP LEDUPDATE;
		END IF;
	END IF;

END PROCESS;
END behavior;