library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity top_level is
	port(
		
		clk       	: in	std_logic;
		en        	: in	std_logic;
		key1 			: in  std_logic;
		key2  		: in  std_logic;
		beep  		: out  std_logic;
		leds_out		: out	std_logic_vector( 3 downto 0 );
		TXD			: out	std_logic;
		RXD			: in	std_logic;
		SDA			: inout std_logic;
		SCL			: inout	std_Logic;
		sel_seg_readdata	: out	std_logic_vector( 7 downto 0 );
		sel_dig_digit	: out	std_logic_vector( 3 downto 0 )
	);
	
end top_level;


architecture arch of top_level is

	signal top_sda_in, top_sda_oe	: std_logic;
	signal top_scl_in, top_scl_oe 	: std_logic;
	
	
	 component simple_struct is
        port (
			clk_clk          : in  std_logic                    := 'X'; -- clk
			leds_leds        : out std_logic_vector(3 downto 0);        -- leds
			beeper_0_beep_buzzer    : out std_logic;                            -- buzzer
			reset_reset_n    : in  std_logic                    := 'X'; -- reset_n
			scl_in           : in  std_logic                    := 'X'; -- in
			scl_oe           : out std_logic;                           -- oe
			sda_in           : in  std_logic                    := 'X'; -- in
			sda_oe           : out std_logic;                           -- oe
			usart_rxd        : in  std_logic                    := 'X'; -- rxd
			usart_txd        : out std_logic;                           -- txd
			sel_seg_readdata : out std_logic_vector(7 downto 0);        -- readdata
			sel_dig_digit    : out std_logic_vector(3 downto 0);         -- digit
			controller_0_start_key1 : in  std_logic                    := 'X'; -- key1
			controller_0_stop_key2  : in  std_logic                    := 'X'  -- key2
        );
    end component simple_struct;

begin
	
	 u0 : component simple_struct
        port map (
            clk_clk       => clk, 				--   clk.clk
            leds_leds     =>  leds_out, 		--      .leds
				beeper_0_beep_buzzer        => beep,        --       beeper_0_out.beep
            reset_reset_n =>  en, 				-- reset.reset_n
            scl_in        =>  top_scl_in,		--   scl.in
            scl_oe        =>  top_scl_oe,		--      .oe
            sda_in        =>  top_sda_in,		--   sda.in
            sda_oe        =>  top_sda_oe,		--      .oe
            usart_rxd     =>  RXD,				-- usart.rxd
            usart_txd     =>  TXD,				--      .txd
				sel_seg_readdata => sel_seg_readdata, -- sel_seg.readdata
				sel_dig_digit    => sel_dig_digit,     -- sel_dig.digit
				controller_0_start_key1 => key1, -- controller_0_start.key1
				controller_0_stop_key2  => key2   --  controller_0_stop.key2		
        );
	
	
	SDA <= '0' when top_sda_oe = '1' else 'Z';
	top_sda_in <= SDA;
	
	SCL <= '0' when top_scl_oe = '1' else 'Z';
	top_scl_in <= SCL;


end arch;