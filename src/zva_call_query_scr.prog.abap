*&---------------------------------------------------------------------*
*&  Include           ZVA_CALL_QUERY_SCR
*&---------------------------------------------------------------------*
TABLES:  aqgqcat,
        pa0001.

SELECTION-SCREEN BEGIN OF BLOCK sc_b1.

SELECT-OPTIONS so_u_g FOR aqgqcat-num NO INTERVALS NO-EXTENSION .
SELECT-OPTIONS so_query FOR aqgqcat-qnum NO INTERVALS NO-EXTENSION.
SELECT-OPTIONS so_emp for  pa0001-pernr NO INTERVALS no-EXTENSION.

SELECTION-SCREEN END OF BLOCK sc_b1.
