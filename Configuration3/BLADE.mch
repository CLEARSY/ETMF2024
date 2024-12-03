MACHINE
    BLADE
SETS 
    POSITION = {Left, Right, Unknown}
OPERATIONS
    pos <-- estimate (s1, s2, s3) =
    PRE
        s1 : POSITION &
        s2 : POSITION &
        s3 : POSITION
    THEN
        IF Right: {s1, s2, s3} THEN
            IF Left: {s1, s2, s3} THEN
                pos := Unknown
            ELSE
                pos := Right
            END
        ELSIF Left: {s1, s2, s3} THEN
            pos := Left
        ELSE
            pos := Unknown
        END
    END
END
