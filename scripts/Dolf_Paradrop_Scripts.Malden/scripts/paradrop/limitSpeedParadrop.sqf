while { ((getPos dolf_aereoParadrop) select 2) < dolf_altitudine - 15} do {
	sleep 15;
};
dolf_aereoParadrop limitSpeed dolf_maxSpeed;


