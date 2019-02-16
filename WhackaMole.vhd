LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_logic_unsigned.ALL;
 
ENTITY WhackaMole IS -- create a seperate component to collect led combination  ports: input ->clk , changes value at clkHIGH = 2, reset 
							
	GENERIC
	(
	DEVICENUM 	: 	INTEGER := 6;
	HEXNUM		: 	INTEGER := 4
	
	);
	
	PORT
	(
	--INPUT
	push_button 		: 	IN STD_LOGIC_VECTOR(DEVICENUM - 1 DOWNTO 0);
	clk,reset,start	:	IN STD_LOGIC;
	
	--OUTPUT
	buzzer		: 	OUT STD_LOGIC;
	LED 			: 	OUT STD_LOGIC_VECTOR(DEVICENUM - 1 DOWNTO 0);
	seven_seg0	:	OUT STD_LOGIC_VECTOR(0 TO 6); --least sig score
	seven_seg1	:	OUT STD_LOGIC_VECTOR(0 TO 6);	-- most sig score
	seven_seg2	:	OUT STD_LOGIC_VECTOR(0 TO 6); --least sig points
	seven_seg3	:	OUT STD_LOGIC_VECTOR(0 TO 6) 	-- most sig points
	);
	
	END WhackaMole;
	
	ARCHITECTURE logic OF WhackaMole IS
		COMPONENT seven_seg_hex IS
		PORT 
		(
			bin	: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			leds	: OUT STD_LOGIC_VECTOR(0 to 6)
		);
		END COMPONENT;
		
		Component ledCombo IS 
		PORT
		(
			clk,reset	:		IN 	STD_LOGIC;
			ledCombination : 	OUT 	STD_LOGIC_VECTOR(DEVICENUM-1 DOWNTO 0)
		);
		END COMPONENT;
		
		COMPONENT buttonLogic IS
		PORT
		(
			clk,reset			:	IN STD_LOGIC;
			push_button 		: 	IN STD_LOGIC_VECTOR(DEVICENUM - 1 DOWNTO 0);
			LED 					: 	IN STD_LOGIC_VECTOR(DEVICENUM - 1 DOWNTO 0);
			points				:	OUT INTEGER; --points achieved this cycle at most 02
		);
		END COMPONENT;
		
		SIGNAL t, i						: STD_LOGIC; --t is our time slice, can either be 0,1,2
		SIGNAL score,points			: STD_LOGIC_VECTOR(7 DOWNTO 0); --score to be output to hex
		
	BEGIN
		PROCESS(start,clk,reset)
		BEGIN
		
		IF(start = '1') THEN --load next led combination
			t = 3;
			IF(reset = '0') THEN
				score <= (OTHERS => '0');
				points<= (OTHERS => '0');
				
				END IF;
				
			ELSE					--all following code exists within current led combination
				if(rising_edge(clk)) THEN
				
			END IF;
		END IF;
		END PROCESS;
		
		ledArray: ledCombo PORT MAP(clk,reset);
		--buttonArray: buttonLogic PORT MAP(
		SSD0: seven_seg_hex PORT MAP(score(3 DOWNTO 0), seven_seg1);
		SSD1: seven_seg_hex PORT MAP(score(7 DOWNTO 4), seven_seg2);
		SSD2: seven_seg_hex PORT MAP(points(3 DOWNTO 0), seven_seg3);
		SSD3: seven_seg_hex PORT MAP(points(7 DOWNTO 4), seven_seg4);

END logic;
	
	