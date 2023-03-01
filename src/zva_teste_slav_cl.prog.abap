*&---------------------------------------------------------------------*
*&  Include           ZVA_TESTE_SLAV_CL
*&---------------------------------------------------------------------*

CLASS lcl_handler_events DEFINITION  .

  PUBLIC SECTION.

    METHODS: on_double_click FOR EVENT double_click OF cl_salv_events_table IMPORTING row.

  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_handler_events IMPLEMENTATION.

  METHOD on_double_click.

    WRITE row.

    ENDMETHOD.

  ENDCLASS.
