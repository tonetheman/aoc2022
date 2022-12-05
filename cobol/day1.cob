        IDENTIFICATION DIVISION.
        PROGRAM-ID. HELLO.

        ENVIRONMENT DIVISION.
            INPUT-OUTPUT SECTION.
                FILE-CONTROL.
                SELECT STUDENT ASSIGN TO './input.txt'
                ORGANIZATION IS LINE SEQUENTIAL.

        DATA DIVISION.
            FILE SECTION.
            FD STUDENT.
            01 STUDENT-FILE.
                05 STUDENT-ID PIC 9(6).

            Working-Storage Section.
            01 WS-STUDENT.
                05 STUDENT-ID PIC 9(6).

        PROCEDURE DIVISION.
            DISPLAY "day1".
            OPEN input STUDENT.
                READ STUDENT into WS-STUDENT
                    DISPLAY WS-STUDENT
                
            CLOSE STUDENT.
        STOP RUN.

        
