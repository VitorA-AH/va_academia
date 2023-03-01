*&---------------------------------------------------------------------*
*& Report ZVA_P_TESTES_TICET_SECIL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zva_p_testes_ticet_secil.


DATA lt_perws TYPE TABLE OF ptpsp.

CALL FUNCTION 'HR_PERSONAL_WORK_SCHEDULE'
  EXPORTING
    pernr = '00000002'
    begda = '20231201'
    endda = '20231231'
  TABLES
    perws = lt_perws.

*********************estrutura ptpsp**********************************
*
*Dia -> DATUM
*Agrupamento da subárea de recursos humanos -> MOTPR
*Plano de trabalho -> TPROG
*Tipo de dia -> TAGTY
*Classe feriado ->FTKLA
*plano de horário de trabalho diário ->   TPKLA
**********************************************************************

*validaçao dias que nao uteis
LOOP AT lt_perws INTO DATA(ls_perws) WHERE tpkla EQ 0  OR tagty NE 0 AND ftkla NE 0.
  WRITE:/ ls_perws-datum.
ENDLOOP.

*****************************************************************************

DATA: ls_p2001 TYPE p2001.

DATA: wa_bapi TYPE bapireturn1..


*ls_p2001-pernr = '00000002'.
*ls_p2001-infty = '2001'.
*ls_p2001-subty = '0100'.
*ls_p2001-AEDTM = sy-datum.
*ls_p2001-UNAME = sy-uname.
*ls_p2001-beguz = '20230801'.
*ls_p2001-enduz = '20230804'.
*ls_p2001-awart = '0100'.
*"n obrigatorio
*ls_p2001-begda = '20230801'.
*ls_p2001-endda = '20230804'.
*"
*ls_p2001-alldf = 'X'.

*DATA: lv_beguz TYPE p2001-beguz VALUE '000000'.
*DATA: lv_enduz TYPE p2001-enduz VALUE '000000'.
*
*ls_p2001-pernr = '00000002'.
*ls_p2001-infty = '2001'.
*ls_p2001-subty = '0300'.
*ls_p2001-aedtm = sy-datum.
*ls_p2001-uname = sy-uname.
*ls_p2001-awart = '0300'.
*ls_p2001-begda = '20230223'.
*ls_p2001-endda = '20230222'.
*ls_p2001-beguz = lv_beguz.
*ls_p2001-enduz = lv_enduz.
*ls_p2001-alldf = 'X'.
*ls_p2001-abwtg = 2.
*ls_p2001-stdaz = '16'.
*ls_p2001-abrst = '16'.
*
*
*
*CALL FUNCTION 'ENQUEUE_EPPRELE'
*  EXPORTING
*    pernr = ls_p2001-pernr.
*
*CALL FUNCTION 'HR_INFOTYPE_OPERATION'
*  EXPORTING
*    infty         = ls_p2001-infty
*    subtype       = ls_p2001-subty
*    number        = ls_p2001-pernr
*    validitybegin = ls_p2001-begda
*    validityend   = ls_p2001-endda
*    record        = ls_p2001
*    operation     = 'INS'
*    tclas         = 'A'
*  IMPORTING
*    return        = wa_bapi.
*
*
*CALL FUNCTION 'DEQUEUE_EPPRELE'
*  EXPORTING
*    pernr = ls_p2001-pernr.
*
*BREAK-POINT.


DATA(lv_num_days) = 24.
DATA lv_num_days_aux TYPE i.
DATA lv_datum TYPE datum.

IF lv_num_days GT 20.
  DO 2 TIMES.
    IF sy-index EQ 1.

      lv_num_days_aux = 20.
      WRITE:/ 'Index: ', sy-index, ' nº de dias: ', lv_num_days_aux.
      lv_datum = sy-datum.

    ELSEIF sy-index EQ 2.

      lv_num_days_aux = lv_num_days - 20.
      WRITE:/ 'Index: ', sy-index, ' nº de dias: ', lv_num_days_aux.
      WRITE:/ lv_datum.
    ENDIF.

  ENDDO.
  ELSE.
    "Insere
ENDIF.
