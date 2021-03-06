library ieee;
use ieee.std_logic_1164.all;
library work;
use work.MyFsmPack.all;
entity my_fsm_gun is
  port (ip: in input_symbol;
        op: out output_symbol;
        cc: in std_logic);
end entity my_fsm_gun;

architecture Behave of my_fsm_gun is
  signal state_sig: fsm_gun;
begin
process(cc,ip)
   variable nstate: fsm_gun;
   variable nop: output_symbol;
begin
  if (cc = '1') then
   -- default values.
   nstate := state_sig;
   nop := n;
   -- code the next-state and output
   -- functions using sequential code
   -- compute variables nstate, vY
   -- Note that reset condition is not
   -- checked here..
   case state_sig is
     when  s_phi =>
       if(ip = g) then
         nstate := s_g;
       end if;
     when s_g =>
       if(ip = u) then
         nstate := s_gu;
       end if;
     when s_gu =>
       if(ip = n) then
         nstate := s_phi;
         nop := y;
       end if;
   end case;
   -- now apply vY to output signal
   if(ip = reset) then
     op <= n;
   else
     op <= nop;
   end if;
   -- apply nstate to state after
   -- delay. Note that the
   -- reset condition is checked
   -- here.
   if(ip = reset) then
     state_sig <= s_phi;
   else
     state_sig <= nstate;
   end if;
 end if;
end process;
end Behave;



