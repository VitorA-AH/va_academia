*&---------------------------------------------------------------------*
*& Report ZVA_PROGRAMA_TESTES_ANI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zva_programa_testes_ani.

DATA: dt_extenso TYPE TABLE OF casdayattr.

DATA: ls_birthday_people TYPE zva_s_birthday_people,
      lt_birthday_people TYPE TABLE OF zva_s_birthday_people.

DATA: lo_zva_cl_birthday_people TYPE REF TO zva_cl_birthday_people.

CREATE OBJECT lo_zva_cl_birthday_people.


DATA LV_aux_Date TYPE sy-datum.

lv_aux_date = '20221104'.

CALL FUNCTION 'DAY_ATTRIBUTES_GET'
  EXPORTING
    date_from      = lv_aux_date "sy-datum
    date_to        = lv_aux_date "sy-datum
    language       = 'P'
  TABLES
    day_attributes = dt_extenso.

READ TABLE dt_extenso INTO DATA(ls_extenso) INDEX 1.


IF ls_extenso-weekday EQ 6 OR ls_extenso-weekday EQ 7.

  return.

ELSE.


*SPLIT ls_extenso-day_string AT space INTO DATA(lv_dia_semana) DATA(lv_dia) DATA(lv_mes) DATA(lv_ano).
*
*CONCATENATE lv_dia(2) 'de' lv_mes INTO DATA(lv_dia_extenso) SEPARATED BY space.

  lo_zva_cl_birthday_people->get_birth_days(
  IMPORTING
    et_brith_days = DATA(lt_birth_days)
  ).


  LOOP AT lt_birth_days INTO DATA(ls_birth_days).

    FREE: ls_birthday_people.

    "fim de semana caso o dia corrente seja o 5º (sexta-feira)
    IF ls_extenso-weekday EQ 5.

      DATA: lv_aux_date_1 TYPE sy-datum, "Sabado
            lv_aux_date_2 TYPE sy-datum. "domingo

      lv_aux_date_1 = lv_aux_date + 1. "sy-datum + 1.
      lv_aux_date_2 = lv_aux_date + 2. "sy-datum + 2.

      "verifica no sabado (dia corrente mais 1)
      IF ls_birth_days-birth_day+4(4) EQ lv_aux_date_1+4(4).

        lo_zva_cl_birthday_people->get_details(
               EXPORTING
                 iv_num_emp     = ls_birth_days-num_col    " Nº pessoal
               CHANGING
                 cs_emp_details = ls_birthday_people    " Estrutura Serviço enviar email aniversariantes
             ).

*      PERFORM get_details_emp USING ls_birth_days-num_col CHANGING ls_birthday_people.

        ls_birthday_people-day_string = 'Sábado'.

        APPEND ls_birthday_people TO lt_birthday_people.

      ENDIF.

      "verifica no domingo (dia corrente mais 2)
      IF ls_birth_days-birth_day+4(4) EQ lv_aux_date_2+4(4).

        lo_zva_cl_birthday_people->get_details(
          EXPORTING
            iv_num_emp     = ls_birth_days-num_col    " Nº pessoal
          CHANGING
            cs_emp_details = ls_birthday_people    " Estrutura Serviço enviar email aniversariantes
        ).

*      PERFORM get_details_emp USING ls_birth_days-num_col CHANGING ls_birthday_people.

        ls_birthday_people-day_string = 'Domingo'.

        APPEND ls_birthday_people TO lt_birthday_people.

      ENDIF.

    ENDIF.

    "dia de corrente
    IF ls_birth_days-birth_day+4(4) EQ lv_aux_date+4(4). "sy-datum+4(4).

      lo_zva_cl_birthday_people->get_details(
         EXPORTING
           iv_num_emp     = ls_birth_days-num_col    " Nº pessoal
         CHANGING
           cs_emp_details = ls_birthday_people    " Estrutura Serviço enviar email aniversariantes
       ).

*    PERFORM get_details_emp USING ls_birth_days-num_col CHANGING ls_birthday_people.

      APPEND ls_birthday_people TO lt_birthday_people.

    ENDIF.

  ENDLOOP.

ENDIF.

BREAK-POINT.

FORM get_details_emp USING num_emp TYPE persno CHANGING ls_birth_people TYPE zva_s_birthday_people.

  DATA: lt_infty_1 TYPE TABLE OF p0001,
        lt_infty_2 TYPE TABLE OF p0002,
        lv_subrc   TYPE sy-subrc.

  CALL FUNCTION 'HR_READ_INFOTYPE'
    EXPORTING
      pernr     = num_emp
      infty     = '0002'
      begda     = sy-datum
      endda     = sy-datum
    IMPORTING
      subrc     = lv_subrc
    TABLES
      infty_tab = lt_infty_2.

  IF lv_subrc EQ 0.

    READ TABLE lt_infty_2 INTO DATA(ls_infty_2) INDEX 1.
    IF sy-subrc EQ 0.


      CALL FUNCTION 'HR_READ_INFOTYPE'
        EXPORTING
          pernr     = num_emp
          infty     = '0001'
          begda     = sy-datum
          endda     = sy-datum
        IMPORTING
          subrc     = lv_subrc
        TABLES
          infty_tab = lt_infty_1.

      READ TABLE lt_infty_1 INTO DATA(ls_infty_1) INDEX 1.
      IF sy-subrc EQ 0.

        ls_birth_people-num_emp = ls_birth_days-num_col.
        ls_birth_people-name_emp = ls_infty_2-cname.
        ls_birth_people-company = ls_infty_1-bukrs.

*          APPEND ls_birthday_people TO lt_birthday_people.

      ENDIF.

    ENDIF.

  ENDIF.


ENDFORM.
