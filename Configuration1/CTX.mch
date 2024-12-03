MACHINE
    CTX
SETS
    BEACONS = {b0_stop, b1_leave, b2_approach, b3_approach, b4_enter, b5_stop}
CONSTANTS
    S_MANOEUVER, /* minimum speed limit - garanteed not to injure passengers */
    S_MAX, /* maximum speed limit */
    S_BEACONS, /* associate to each beacon a speed limit */
    DELAY_TRAVEL_APPROACH, /* delay where we consider that 
                            first approach beacon has been missed */
    NEXT_BEACONS /* What is the order of reading beacons - for simulation */
PROPERTIES
    S_MANOEUVER: INTEGER &
    S_MAX : INTEGER &
    S_MANOEUVER > 0 &
    S_MAX >= S_MANOEUVER &
    S_BEACONS : BEACONS --> INTEGER &
    ran(S_BEACONS) <: S_MANOEUVER..S_MAX &
    S_BEACONS = {
        b0_stop |-> S_MANOEUVER, 
        b1_leave |-> S_MAX, 
        b2_approach |-> S_MAX, 
        b3_approach |-> S_MAX, 
        b4_enter |-> S_MANOEUVER, 
        b5_stop |-> S_MANOEUVER    
    } &
    S_MAX = max(ran(S_BEACONS))&
    DELAY_TRAVEL_APPROACH : NATURAL1 &
    DELAY_TRAVEL_APPROACH <= 10 &
    NEXT_BEACONS : BEACONS --> POW(BEACONS) &
    NEXT_BEACONS = {
        b0_stop |-> {b0_stop, b1_leave, b2_approach, b3_approach, b4_enter, b5_stop},
        b1_leave |-> {b1_leave, b2_approach, b3_approach, b4_enter, b5_stop},
        b2_approach |-> {b2_approach, b3_approach, b4_enter, b5_stop},
        b3_approach |-> {b3_approach, b4_enter, b5_stop},
        b4_enter |-> {b4_enter, b5_stop},
        b5_stop |-> {b5_stop}
    }
END
