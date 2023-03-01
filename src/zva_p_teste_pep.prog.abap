*&---------------------------------------------------------------------*
*& Report ZVA_P_TESTE_PEP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zva_p_teste_pep.

DATA: ls_export TYPE zah_s_emp_pep_cc,
      lt_export TYPE zah_tt_emp_pep_cc.


DATA: lt_infty27 TYPE TABLE OF p0027.
DATA: lv_subrc TYPE sy-subrc.


DATA:
  lv_fname   TYPE rollname,
  lv_counter TYPE numc2 VALUE 01.

FIELD-SYMBOLS :

  <fs_pep> TYPE any,
  <fs_cc>  TYPE any.



DATA lo_zah_cl_missing_hours TYPE REF TO zah_cl_get_missing_hours.

CREATE OBJECT lo_zah_cl_missing_hours.

lo_zah_cl_missing_hours->zah_i_common_methods~get_all_employee(
  IMPORTING
    et_all_pernr = DATA(lt_num_emps)    " tabela de importação/exportação do número de colaborador
).

LOOP AT lt_num_emps INTO DATA(ls_num_emp).

  lv_counter = 01.

  FREE: lt_infty27.

  CALL FUNCTION 'HR_READ_INFOTYPE'
    EXPORTING
      pernr     = ls_num_emp-num_emp
      infty     = '0027'
      begda     = sy-datum
      endda     = sy-datum
    IMPORTING
      subrc     = lv_subrc
    TABLES
      infty_tab = lt_infty27.

  IF lv_subrc EQ 0.

    READ TABLE lt_infty27 INTO DATA(ls_infty27) INDEX 1.

    IF sy-subrc EQ 0.

      WHILE lv_counter LE 25.

        free: ls_export.

        lv_fname = 'PSP' && lv_counter.

        ASSIGN COMPONENT lv_fname OF STRUCTURE ls_infty27 TO <fs_pep>.

        lv_fname = 'KST' && lv_counter.

        ASSIGN COMPONENT lv_fname OF STRUCTURE ls_infty27 TO <fs_cc>.

        IF <fs_pep> IS ASSIGNED.

          IF <fs_pep> IS NOT INITIAL.

            ls_export-num_emp = ls_num_emp-num_emp.
            ls_export-pep = <fs_pep>.

            APPEND ls_export TO lt_export.

          ELSEIF <fs_cc> IS NOT INITIAL.

            ls_export-num_emp = ls_num_emp-num_emp.
            ls_export-cost_center = <fs_cc>.

            APPEND ls_export TO lt_export.

          ENDIF.

        ENDIF.

        ADD 1 TO lv_counter.

      ENDWHILE.

    ENDIF.

  ENDIF.

ENDLOOP.





BREAK-POINT.
