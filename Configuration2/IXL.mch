MACHINE
    IXL
SEES CTX
VARIABLES
    is_occupied,
    signal_status
INVARIANT
    is_occupied <: TRACK_CIRCUITS &
    signal_status : SIGNALS --> STATUS 
INITIALISATION
    is_occupied :: POW(TRACK_CIRCUITS) ||
    signal_status := SIGNALS * {RED} 
OPERATIONS
    update_protection =
    BEGIN
        signal_status: (
            signal_status : SIGNALS --> STATUS &
            /* all signals protecting an occupied TC should be red */
            signal_status[IS_PROTECTED_BY[is_occupied]] = {RED}
        ) 
    END
END
