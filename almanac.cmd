#trigger {e/$gametime >= $almanactime/} {#echo >Log Red You can study your almanac.;#class almanac_timer off} {almanac_timer}
#trigger {^You set about studying your omnibus almanac intently\.} {#var almanactime {#evalmath $gametime+605};#class almanac_timer on;#echo >Log Lime Learned $1}
