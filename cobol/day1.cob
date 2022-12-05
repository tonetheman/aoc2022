        IDENTIFICATION DIVISION.
        PROGRAM-ID. HELLO.

        ENVIRONMENT DIVISION.
            INPUT-OUTPUT SECTION.
                FILE-CONTROL.
                SELECT CFILE ASSIGN TO './input.txt'
                ORGANIZATION IS LINE SEQUENTIAL.

        DATA DIVISION.

            Working-Storage Section.
            01 WS-CALORIES.
                05 CALORIES PIC 9(6).
            01 WS-EOF   PIC A(1).

        PROCEDURE DIVISION.
            DISPLAY "day1".
            OPEN input CFILE.
                PERFORM UNTIL WS-EOF='Y'
                    READ CFILE into WS-CALORIES
                        AT END MOVE 'Y' to WS-EOF
                        NOT AT END DISPLAY WS-CALORIES
                    END-READ
                END-PERFORM               
            CLOSE CFILE.
        STOP RUN.

        
