MACHINE beacons

SETS
	BEACONS = {b0, b1, b2, b3, b4, b5}
CONSTANTS
	nextB,
	lenghtTC,
	kpB,
	lastB
PROPERTIES
	nextB: BEACONS --> BEACONS &
	nextB = {
	    b0 |-> b1, 
	    b1 |-> b2,
	    b2 |-> b3,
	    b3 |-> b4,
	    b4 |-> b5,
	    b5 |-> b0
	} &
	dom(nextB) \/ ran(nextB) = BEACONS &
	
	lenghtTC: BEACONS --> INTEGER &
	lenghtTC = {
	    b0 |-> 1000, 
	    b1 |-> 1000,
	    b2 |-> 2000,
	    b3 |-> 2000,
	    b4 |-> 1000,
	    b5 |-> 1000
	} &
	
	kpB : BEACONS --> INTEGER &
	!bc.(bc: BEACONS => 
	    (bc = b0 => kpB(bc) = 0) &
	    (not(bc=b0) => kpB(bc) = lenghtTC(nextB~(bc)) + kpB(nextB~(bc)))
	) &
	lastB: BEACONS &
	lastB = b5 &
	!bc.(bc: BEACONS - {lastB} => kpB(bc) <= kpB(nextB(bc)))
END