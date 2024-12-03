MACHINE M0
SEES CTX
    
VARIABLES
    current_speed, /* current speed - input */
    last_beacon_read, /* id of last beacon read - input */
    current_speed_limit, /* current speed limit computed */
    emergency_braking, /* trigger for emergency braking - output */
    travel_time, /* time (cycles) measured since the beginning of travel */
    travel_completed
INVARIANT
    current_speed : NATURAL & 
    last_beacon_read : BEACONS &
    current_speed_limit : S_MANOEUVER..S_MAX &
    emergency_braking : BOOL &
    travel_time : NATURAL &
    travel_completed : BOOL &
    /* Safety p1: overspeed implis emergency braking */
    (current_speed > current_speed_limit => emergency_braking = TRUE)
    
INITIALISATION
    current_speed := 0 ||
    last_beacon_read := b0_stop ||
    current_speed_limit := S_MANOEUVER ||
    emergency_braking := TRUE || /* safety position
    we leave this state if conditions met */
    travel_time := 0 ||
    travel_completed := FALSE
    
OPERATIONS
    cycle_b0_b5 =
    PRE travel_completed = FALSE THEN
        current_speed,
        emergency_braking,
        last_beacon_read,
        travel_time: (
            current_speed : NATURAL & /* input */
            last_beacon_read : BEACONS & /* input */
            /* to ensure that past beacons are read */
            last_beacon_read : NEXT_BEACONS(last_beacon_read$0) &
            emergency_braking : BOOL & /* output */
            travel_time : NATURAL &
            travel_time > travel_time$0 &
            
            (travel_time > DELAY_TRAVEL_APPROACH => 
                current_speed_limit = S_MANOEUVER) &
            (travel_time <= DELAY_TRAVEL_APPROACH 
                => current_speed_limit = S_BEACONS(last_beacon_read)) &
            
            (emergency_braking = TRUE => current_speed 
                <= current_speed$0 & current_speed >= 0) &
            /* safety p1 */
            (current_speed > current_speed_limit 
                => emergency_braking = TRUE) &
            /* safety p2 */
            (emergency_braking$0 = TRUE & current_speed = 0 
                => emergency_braking = FALSE) &
            /* safety p2 */
            (emergency_braking$0 = TRUE & current_speed > 0 
                => emergency_braking = TRUE)
        )   
    END;
    
    end_travel =
    PRE 
        travel_completed = FALSE &
        last_beacon_read = b5_stop &
        current_speed = 0
    THEN
        travel_completed := TRUE
    END
    
END
