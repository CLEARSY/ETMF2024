MACHINE
    CTX
SETS
    TRACK_CIRCUITS = {tc1, tc2, tc3, tc4, tc5, tc6, tc7, tc8, tc9};
    SIGNALS = {s1, s2, s3, s4, s5, s6, s7, s8, s9};
    STATUS = {GREEN, RED}
CONSTANTS
    IS_PROTECTED_BY
PROPERTIES
    IS_PROTECTED_BY : TRACK_CIRCUITS +-> SIGNALS &
    IS_PROTECTED_BY = {
        tc1 |-> s1, 
        tc2 |-> s2, 
        tc3 |-> s3, 
        tc4 |-> s4, 
        tc5 |-> s5,  
        tc6 |-> s6,  
        tc7 |-> s7,  
        tc8 |-> s8,  
        tc9 |-> s9
    } 
END
