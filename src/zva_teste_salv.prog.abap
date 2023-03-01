*&---------------------------------------------------------------------*
*& Report ZVA_TESTE_SALV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zva_teste_salv.

INCLUDE zva_teste_slav_cl.


TYPES: BEGIN OF zest_teste,
         num_col       TYPE pernr_d,
         nome_completo TYPE pad_cname,
       END OF zest_teste.

DATA: lt_teste TYPE TABLE OF zest_teste.


DATA: lr_salv_table TYPE REF TO cl_salv_table.



data: lr_functions  TYPE REF TO cl_salv_functions.

DATA: gr_events TYPE REF to lcl_handler_events.
DATA: lr_events TYPE REF TO cl_salv_events_table.

START-OF-SELECTION.

SELECT pernr cname FROM pa0002 INTO TABLE lt_teste WHERE begda LE sy-datum AND endda GT sy-datum.

end-OF-SELECTION.

CALL METHOD cl_salv_table=>factory
  IMPORTING
    r_salv_table = lr_salv_table
  CHANGING
    t_table      = lt_teste.


lr_events = lr_salv_table->get_event( ).

CREATE OBJECT gr_events.

set HANDLER gr_events->on_double_click FOR lr_events.

lr_salv_table->get_columns( )->set_optimize( abap_true ).
lr_salv_table->get_selections( )->set_selection_mode( if_salv_c_selection_mode=>row_column ).

lr_salv_table->display( ).
