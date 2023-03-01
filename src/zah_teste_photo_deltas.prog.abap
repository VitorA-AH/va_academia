*&---------------------------------------------------------------------*
*& Report ZAH_TESTE_PHOTO_DELTAS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zah_teste_photo_deltas.

*TABLES: zva_photo_emp.

DATA: lt_num_emp       TYPE TABLE OF zah_s_num_emp,
      lt_photo_emp     TYPE TABLE OF zah_s_photo_emp,
      lt_photo_emp_bd  TYPE TABLE OF zva_photo_emp,
      lt_photo_emp_exp TYPE TABLE OF zah_s_photo_emp.

DATA:
        lo_zah_cl_get_photo_emp TYPE REF TO zah_cl_get_photo_emp.

CREATE OBJECT lo_zah_cl_get_photo_emp.

lo_zah_cl_get_photo_emp->get_photos_emps(
  EXPORTING
    it_num_emp   =  lt_num_emp  " tabela de importação/exportação do número de colaborador
  IMPORTING
    et_photo_emp =   lt_photo_emp  " Tipo de tabela para exportação fotos do colaborador
).

SELECT * FROM zva_photo_emp INTO TABLE lt_photo_emp_bd.



LOOP AT lt_photo_emp INTO DATA(ls_photo_emp).

  READ TABLE lt_photo_emp_bd INTO DATA(ls_photo_emp_bd) WITH KEY num_emp = ls_photo_emp-num_emp.
  IF sy-subrc EQ 0.

    IF ls_photo_emp-photo_emp NE ls_photo_emp_bd-photo_emp ."or ls_photo_emp-photo_emp IS NOT INITIAL.

      ls_photo_emp_bd-num_emp = ls_photo_emp-num_emp.
      ls_photo_emp_bd-photo_emp = ls_photo_emp-photo_emp.

      MODIFY zva_photo_emp FROM ls_photo_emp_bd.

      APPEND ls_photo_emp TO lt_photo_emp_exp.
    ENDIF.

  ELSEIF ls_photo_emp-photo_emp IS NOT INITIAL.

    ls_photo_emp_bd-num_emp = ls_photo_emp-num_emp.
    ls_photo_emp_bd-photo_emp = ls_photo_emp-photo_emp.

    MODIFY zva_photo_emp FROM  ls_photo_emp_bd.

    APPEND ls_photo_emp TO lt_photo_emp_exp.

  ENDIF.

ENDLOOP.

CLEAR: ls_photo_emp,
       ls_photo_emp_bd.


LOOP AT lt_photo_emp_bd INTO ls_photo_emp_bd.

  READ TABLE lt_photo_emp INTO ls_photo_emp WITH KEY num_emp = ls_photo_emp_bd-num_emp.
  IF sy-subrc ne 0.

    "extrutura inserir tabela de exportação
    ls_photo_emp-num_emp = ls_photo_emp_bd-num_emp.
    ls_photo_emp-photo_emp = ' '.

    APPEND  ls_photo_emp TO lt_photo_emp_exp.

    "elimina linha daquele colaborador na bd
    DELETE FROM zva_photo_emp WHERE num_emp EQ ls_photo_emp-num_emp.
  ENDIF.

ENDLOOP.



BREAK-POINT.
