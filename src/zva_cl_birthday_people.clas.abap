class ZVA_CL_BIRTHDAY_PEOPLE definition
  public
  final
  create public .

public section.

  methods GET_BIRTH_DAYS
    exporting
      !ET_BRITH_DAYS type ZVA_TT_BIRTH_DAY .
  methods GET_BIRTHDAY_PEOPLE
    exporting
      !ET_BIRTHDAY_PEOPLE type ZVA_TT_BIRTHDAY_PEOPLE .
  methods GET_DETAILS
    importing
      !IV_NUM_EMP type PERSNO
    changing
      !CS_EMP_DETAILS type ZVA_S_BIRTHDAY_PEOPLE .
protected section.
private section.

  methods GET_ALL_EMPLOYEES
    exporting
      !ET_ALL_PERNR type ZVA_TT_NUM_EMP .
ENDCLASS.



CLASS ZVA_CL_BIRTHDAY_PEOPLE IMPLEMENTATION.


  method GET_ALL_EMPLOYEES.
    CONSTANTS: lc_active(1) TYPE c VALUE '3'.

    data(lv_aux_date) = sy-datum.

    "colaboradores ativos à data
    SELECT pernr
      INTO TABLE et_all_pernr
      FROM pa0000
      WHERE begda LE lv_aux_date
      AND endda GE lv_aux_date
      AND stat2 EQ lc_active"ativo
      ORDER BY pernr ASCENDING.
  endmethod.


  METHOD get_birthday_people.

    DATA: dt_extenso TYPE TABLE OF casdayattr.

    DATA: ls_birthday_people TYPE zva_s_birthday_people.

    CALL FUNCTION 'DAY_ATTRIBUTES_GET'
      EXPORTING
        date_from      = sy-datum
        date_to        = sy-datum
        language       = 'P'
      TABLES
        day_attributes = dt_extenso.

    READ TABLE dt_extenso INTO DATA(ls_extenso) INDEX 1.

    IF ls_extenso-weekday EQ 6 OR ls_extenso-weekday EQ 7.

      RETURN.

    ELSE.

   get_birth_days(
        IMPORTING
          et_brith_days =  DATA(lt_brith_days)   " tabela importação/exportaçao datas de aniversario
      ).

      LOOP AT lt_brith_days INTO DATA(ls_birth_days).

        FREE: ls_birthday_people.

        IF ls_extenso-weekday EQ 5.

          DATA: lv_aux_date_1 TYPE sy-datum, "Sabado
                lv_aux_date_2 TYPE sy-datum. "domingo

          lv_aux_date_1 = sy-datum + 1.
          lv_aux_date_2 = sy-datum + 2.

          "verifica no sabado (dia corrente mais 1)
          IF ls_birth_days-birth_day+4(4) EQ lv_aux_date_1+4(4).

            get_details(
             EXPORTING
               iv_num_emp     = ls_birth_days-num_col    " Nº pessoal
             CHANGING
               cs_emp_details = ls_birthday_people    " Estrutura Serviço enviar email aniversariantes
           ).

            ls_birthday_people-day_string = 'Sábado'.

            APPEND ls_birthday_people TO et_birthday_people.

          ENDIF.


          "verifica no domingo (dia corrente mais 2)
          IF ls_birth_days-birth_day+4(4) EQ lv_aux_date_2+4(4).

            get_details(
              EXPORTING
                iv_num_emp     = ls_birth_days-num_col    " Nº pessoal
              CHANGING
                cs_emp_details = ls_birthday_people    " Estrutura Serviço enviar email aniversariantes
            ).

            ls_birthday_people-day_string = 'Domingo'.

            APPEND ls_birthday_people TO et_birthday_people.

          ENDIF.

        ENDIF.

        "dia de corrente
        IF ls_birth_days-birth_day+4(4) EQ sy-datum+4(4).

          get_details(
             EXPORTING
               iv_num_emp     = ls_birth_days-num_col    " Nº pessoal
             CHANGING
               cs_emp_details = ls_birthday_people    " Estrutura Serviço enviar email aniversariantes
           ).

          ls_birthday_people-day_string = 'Hoje'.

          APPEND ls_birthday_people TO et_birthday_people.

        ENDIF.

      ENDLOOP.


    ENDIF.


  ENDMETHOD.


  method GET_BIRTH_DAYS.

    DATA: ls_birth_days TYPE zah_s_birth_day,
          lv_subrc      TYPE sy-subrc,
          lt_infty_2    TYPE TABLE OF p0002,
          ls_infty_2    TYPE  p0002.

    CONSTANTS: lc_infotype(4) TYPE c VALUE '0002'.

    get_all_employees(
      IMPORTING
        et_all_pernr = data(lt_num_emps)   " tabela de importação/exportação do número de colaborador
    ).

    LOOP AT lt_num_emps INTO DATA(ls_num_emp).
      FREE: lt_infty_2,
             ls_infty_2,
             ls_birth_days.

      CALL FUNCTION 'HR_READ_INFOTYPE'
        EXPORTING
          pernr     = ls_num_emp-num_emp
          infty     = lc_infotype
          begda     = sy-datum
          endda     = sy-datum
        IMPORTING
          subrc     = lv_subrc
        TABLES
          infty_tab = lt_infty_2.

      IF lv_subrc EQ 0.

        READ TABLE lt_infty_2 INTO ls_infty_2 INDEX 1.
        IF sy-subrc EQ 0.


          ls_birth_days-num_col = ls_num_emp-num_emp.
          ls_birth_days-birth_day = ls_infty_2-gbdat.

          APPEND ls_birth_days TO et_brith_days.

        ENDIF.
      ENDIF.



    ENDLOOP.

  endmethod.


  METHOD get_details.

    DATA: lt_infty_1 TYPE TABLE OF p0001,
          lt_infty_2 TYPE TABLE OF p0002,
          lv_subrc   TYPE sy-subrc.

    CALL FUNCTION 'HR_READ_INFOTYPE'
      EXPORTING
        pernr     = iv_num_emp
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
            pernr     = iv_num_emp
            infty     = '0001'
            begda     = sy-datum
            endda     = sy-datum
          IMPORTING
            subrc     = lv_subrc
          TABLES
            infty_tab = lt_infty_1.

        READ TABLE lt_infty_1 INTO DATA(ls_infty_1) INDEX 1.
        IF sy-subrc EQ 0.

          cs_emp_details-num_emp = iv_num_emp.
          cs_emp_details-name_emp = ls_infty_2-cname.
          cs_emp_details-company = ls_infty_1-bukrs.

        ENDIF.

      ENDIF.

    ENDIF.

  ENDMETHOD.
ENDCLASS.
