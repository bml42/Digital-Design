LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY seven_seg_hex IS
	PORT (bin: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	leds: OUT STD_LOGIC_VECTOR(1 to 7));
END seven_seg_hex;

ARCHITECTURE behavior OF seven_seg_hex IS
BEGIN
	leds <= "0000001" WHEN bin = "0000" ELSE
			 "1001111" WHEN bin = "0001" ELSE
			 "0010010" WHEN bin = "0010" ELSE
			 "0000110" WHEN bin = "0011" ELSE
			 "1001100" WHEN bin = "0100" ELSE
			 "0100100" WHEN bin = "0101" ELSE
			 "0100000" WHEN bin = "0110" ELSE
			 "0001111" WHEN bin = "0111" ELSE
			 "0000000" WHEN bin = "1000" ELSE
			 "0001100" WHEN bin = "1001" ELSE
			 "0001000" WHEN bin = "1010" ELSE
			 "1100000" WHEN bin = "1011" ELSE
			 "0110001" WHEN bin = "1100" ELSE
			 "1000010" WHEN bin = "1101" ELSE
			 "0110000" WHEN bin = "1110" ELSE
			 "0111000" WHEN bin = "1111" ELSE
			 "-------";
END behavior;