while { ((getPos dolf_paradrop_aereo) select 2) < dolf_paradrop_Altitudine - 15} do {
	sleep 15;
};
dolf_paradrop_aereo limitSpeed dolf_paradrop_MaxSpeed;


