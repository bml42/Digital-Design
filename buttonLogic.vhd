LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_logic_unsigned.ALL;

ENTITY buttonLogic IS

GENERIC
(
	DEVICENUM 	: 	INTEGER := 6;
	HEXNUM		: 	INTEGER := 4
);

PORT
(
	clk,reset			:	IN STD_LOGIC;
	push_button 		: 	IN STD_LOGIC_VECTOR(DEVICENUM - 1 DOWNTO 0);
	LED 					: 	IN STD_LOGIC_VECTOR(DEVICENUM - 1 DOWNTO 0);
	points				:	OUT INTEGER; --points achieved this cycle at most 02
);

END buttonLogic;

ARCHITECTURE behavior of buttonLogic IS

SIGNAL clkCnt		: STD_LOGIC_VECTOR(2 DOWNTO 0);  --clkcnt = timeslice    3 bits - counts to 4 at most 
SIGNAL i				: STD_LOGIC_VECTOR(3 DOWNTO 0);  --4 bits = 15, only needs to count to 5


BEGIN
clkCnt <= '0';

PROCESS(clk,reset,push_button)
	BEGIN
	buzzer <= '0';
	
	IF(reset = '0') THEN
		clkCnt <= '0';
		points <= (OTHERS => '0');
		
	ELSE
		IF(rising_edge(clk)) THEN
			clkCnt <= clkCnt + '1';
			IF(clkCnt = '4') THEN-- 1 = 2pts, 2 = 1pts, 3 = 0pts, next clk combo will change 
				clkCnt = '0';
			End IF;
		END IF;
		IF(clkCnt > 0)
			BUTTONPUSH: FOR i IN 0 TO DEVICENUM-1 
				IF(LED[i] AND push_button[i])
					IF(clkCnt = '1')
						points <= '2';						--t = 2 ->score+=2
					END IF;
					IF(clkCnt = '2')
						points <= '1';
					END IF;
				ELSIF(push_button[i] = 1 AND LED[i] = 0)
					buzzer <= 1; 							--set for lenth of time and then =0
				END IF;
			END LOOP BUTTONPUSH;
		END IF;
	END IF;
END behavior;