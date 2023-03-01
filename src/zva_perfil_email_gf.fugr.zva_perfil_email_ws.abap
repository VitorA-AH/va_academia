FUNCTION zva_perfil_email_ws.
*"----------------------------------------------------------------------
*"*"Interface local:
*"  IMPORTING
*"     VALUE(IV_NUM_COL) TYPE  PERSNO
*"  EXPORTING
*"     VALUE(ES_PERFIL) TYPE  ZVA_S_PERFIL_EMAIL
*"     VALUE(EV_STATUS) TYPE  CHAR50
*"----------------------------------------------------------------------



  SELECT SINGLE pa0002~cname, pa0002~gbdat, pa0006~stras, pa0006~pstlz, pa0009~iban
    INTO @es_perfil
    from pa0002
    INNER JOIN pa0006 on pa0006~pernr eq pa0002~pernr
    left join pa0009 on pa0009~pernr eq pa0006~pernr
    WHERE pa0002~pernr eq @iv_num_col
    AND pa0002~begda le @sy-datum
    AND pa0002~endda ge @sy-datum
    AND pa0006~begda le @sy-datum
    AND pa0006~endda ge @sy-datum
    AND pa0009~begda le @sy-datum
    AND pa0009~endda ge @sy-datum.

    IF sy-subrc ne 0.
      ev_status = 'Colaborador nao econtrado!'.

    ENDIF.

    BREAK-POINT.


  endfunction.
