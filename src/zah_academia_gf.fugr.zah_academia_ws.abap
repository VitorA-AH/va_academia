FUNCTION zah_academia_ws.
*"----------------------------------------------------------------------
*"*"Interface local:
*"  IMPORTING
*"     VALUE(IV_NUM_COL) TYPE  PERNR_D
*"  EXPORTING
*"     VALUE(EV_NOME_COMPLETO) TYPE  PAD_CNAME
*"----------------------------------------------------------------------

  SELECT SINGLE cname
    FROM pa0002
    INTO ev_nome_completo
    WHERE pernr = iv_num_col
    AND begda LE sy-datum
    AND endda GE sy-datum.



ENDFUNCTION.
