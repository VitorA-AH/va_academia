*&---------------------------------------------------------------------*
*& Report ZVA_CALL_QUERY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZVA_CALL_QUERY.


*»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»*
*   20.10.2022 10:15:54                *
*««««««««««««««««««««««««««««««««««««««««««««««*

*INCLUDE ZVA_CALL_QUERY_top.
INCLUDE ZVA_CALL_QUERY_scr.
*INCLUDE ZVA_CALL_QUERY_cls.
*INCLUDE ZVA_CALL_QUERY_f01.

INITIALIZATION.


AT SELECTION-SCREEN.

START-OF-SELECTION.

END-OF-SELECTION.


DATA lv_prognam TYPE aqadef-pgname.

"recolher reportname da query
"no parametro 'WORKSPACE'
"  usar '' se for area standard
"  usar 'G' se for area global

CALL FUNCTION 'RSAQ_REPORT_NAME'
  EXPORTING
    workspace  = 'G'
    usergroup  = so_u_g-low
    query      = so_query-low
  IMPORTING
    reportname = lv_prognam.

*  CONCATENATE 'AQZZ' 'Z_GRUPOLR' '===' 'Z_QUERYLR' '=====' INTO lv_prognam.

*SUBMIT AQZZZ_GRUPOLR===Z_QUERYLR===== VIA SELECTION-SCREEN EXPORTING LIST TO MEMORY AND RETURN.

*SUBMIT (lv_prognam) USING SELECTION-SET 'VAR_2' via SELECTION-SCREEN  EXPORTING LIST TO MEMORY  AND RETURN .
SUBMIT (lv_prognam) with SP$00001 eq so_emp-low
                    via SELECTION-SCREEN
                    EXPORTING LIST TO MEMORY  AND RETURN .

DATA list_tab TYPE TABLE OF abaplist.

"recolhe a lista vinda da query e guardada na memoria
CALL FUNCTION 'LIST_FROM_MEMORY'
  TABLES
    listobject = list_tab
  EXCEPTIONS
    not_found  = 1
    OTHERS     = 2.

*IF sy-subrc = 0.
*  "mostra a lista
*  CALL FUNCTION 'WRITE_LIST'
*    TABLES
*      listobject = list_tab.
*ENDIF.








































*
*data sel_tab type table of rihaufk_list with header line.
*
*import sel_tab from memory ID 'ZVA_CALL_QUERY'.
*
*DATA LT_TAB TYPE STANDARD TABLE OF rihaufk_list.
*
*field-symbols: <struc> type rihaufk_list.
*
*data: ls_rihaufk_list type rihaufk_list,
*      lt_rihaufk_list TYPE TABLE OF rihaufk_list.
*
*lt_tab[] = sel_tab[].
*
*loop at lt_tab assigning <struc>.
*  move-corresponding <struc> to ls_rihaufk_list.
*
*  APPEND ls_rihaufk_list to lt_rihaufk_list.
*
*  ENDLOOP.


BREAK-POINT.
