*&---------------------------------------------------------------------*
*& Report ZVA_P_TICKET_INCM
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zva_p_ticket_incm.

*CASE innnn-infty.
*  WHEN '0014'.
*    DATA: ls_p0014 TYPE p0014.
*    DATA: lt_p0001 TYPE TABLE OF p0001,
*          ls_p0001 TYPE p0001.
*    DATA: lv_subrc TYPE lv_subrc.
*    " Parametrizar grupo de empregados
*    r_persg = VALUE t_rt_persg( sign = 'I' option = 'EQ'
*    ( low = '1' )    " Ativos
*    ( low = '9' ) ). " Externos
*    " Parametrizar grupo subgrupos excluídos
*    r_persk = VALUE t_rt_persk( sign = 'I' option = 'EQ'
*    ( low = '03' )    " O. Sociais – SS/Outros
*    ( low = '04' ) ). " O. Sociais – CGA
**** Declaração tipos de Tabelas Ranges
*    TYPES: t_rt_persg TYPE RANGE OF persg, " Grupo empregados
*           t_rt_persk TYPE RANGE OF persk. " Subgrupo empregados
*    "recolhe dados presentes na transaçao PA30
*    CALL METHOD cl_hr_pnnnn_type_cast=>prelp_to_pnnnn
*      EXPORTING
*        prelp = innnn
*      IMPORTING
*        pnnnn = ls_p0014.
*    IF ipsyst-ioper = 'INS' OR ipsyst-ioper = 'UPD' OR gv_ucomm = 'UPD' OR gv_ucomm EQ 'UPD' OR gv_ucomm EQ 'SAVE' OR gv_ucomm EQ 'UPDL'.
*      "vÊ se existe a rubrica na tabela
*      "Select tabela de rubricas
*      SELECT zz_car_tra
*      FROM zhr_rubricas_mob
*      WHERE zz_car_tra EQ @ls_p0014-lgart
*      AND begda <= @sy-datum
*      AND endda >= @sy-datum
*      INTO TABLE @DATA(l_t_rubricas_mob).
*      IF sy-subrc EQ 0.
*        CALL FUNCTION 'HR_READ_INFOTYPE'
*          EXPORTING
*            pernr     = ls_p0014-pernr
*            infty     = innnn-infty
*            begda     = ls_p0014-begda
*            endda     = ls_p0014-endda
*          IMPORTING
*            subrc     = lv_subrc
*          TABLES
*            infty_tab = lt_p0001.
*        READ TABLE lt_p0001 INTO ls_p0001 INDEX 1.
*        IF sy-subrc EQ 0.
*          "verifica grupos de subgrupos de empregados
*          IF ls_p0001-persg IN r_persg AND ls_p0001-persk NOT IN r_persk.
*            CALL METHOD cl_hr_pnnnn_type_cast=>pnnnn_to_prelp
*              EXPORTING
*                pnnnn = ls_p0007
*              IMPORTING
*                prelp = innnn.
*          ELSE.
*            "lança mensagem
*            EXIT.
*          ENDIF.
*        ENDIF.
*      ELSE.
*        "lança mensagem
*        EXIT.
*      ENDIF.
*    ENDIF.
*  WHEN OTHERS.
*ENDCASE.

" Status do envio dos ficheiros
TYPES: BEGIN OF t_st_employee_status,
         colaborador TYPE string,
         status      TYPE icon_d,
         descricao   TYPE string,
         mensagem    TYPE string,
* internal table for cell color information
         it_colors   TYPE lvc_t_scol,
       END OF   t_st_employee_status.

" Texto das colunas ALV
TYPES: BEGIN OF t_st_columns_text,
         column      TYPE lvc_fname,
         long_text   TYPE scrtext_l,
         medium_text TYPE scrtext_m,
         short_text  TYPE scrtext_s,
       END OF t_st_columns_text.



DATA: t_status TYPE TABLE OF t_st_employee_status.  " Definir status de transferencia de cada ficheiro (OUTPUT)
DATA: wa_status TYPE t_st_employee_status.  " Definir status de transferencia de cada ficheiro (OUTPUT)
DATA: wa_colors LIKE LINE OF wa_status-it_colors. "Work area para definir cor da coluna


PERFORM f_ins_status_table USING '00000002' icon_incomplete 'Erro!' 'Teste'.
PERFORM f_ins_status_table USING '00000003' icon_checked 'Sucesso!' 'Teste'.
PERFORM f_ins_status_table USING '00000004' icon_incomplete 'Erro!' 'Teste'.
PERFORM f_ins_status_table USING '00000005' icon_checked 'Sucesso!' 'Teste'.
PERFORM f_ins_status_table USING '00000006' icon_incomplete 'Erro!' 'Teste'.

PERFORM f_show_alv.


FORM f_ins_status_table USING p_colaborador TYPE string
                            p_status      TYPE icon_d
                            p_descricao   TYPE string
                            p_mensagem    TYPE string.

  " Preencher tabela status com os dados
  APPEND VALUE #( colaborador  = p_colaborador
                  status       = p_status
                  descricao    = p_descricao
                  mensagem    =  p_mensagem ) TO t_status.

ENDFORM.





FORM f_show_alv .
  DATA: l_t_columns_text TYPE TABLE OF t_st_columns_text,
        l_r_column       TYPE REF TO cl_salv_column,
        l_r_columns      TYPE REF TO cl_salv_columns_table.

  LOOP AT t_status INTO wa_status .

    "se o icon for de erro mete coluna de mensagem com cor vermelha
    IF wa_status-status EQ icon_incomplete.
      CLEAR wa_colors.
      wa_colors-fname = 'MENSAGEM'.
      wa_colors-color-col = col_negative.
      wa_colors-color-int = 1.
      APPEND wa_colors TO wa_status-it_colors."adicina estrutura de informaçoes da celula na tabela
    ENDIF.
    MODIFY t_status FROM wa_status TRANSPORTING it_colors. "modifica tabela



  ENDLOOP.

  CLEAR l_r_column.

  " /// ---------------------------------------&
  " // Definir texto das respetivas colunas   /
  " / =======================================&
  APPEND VALUE #( column = 'COLABORADOR' long_text = 'Colaborador'(008)   medium_text = 'Colaborador'(008)  short_text = 'Colaborador'(009) ) TO l_t_columns_text.
  APPEND VALUE #( column = 'STATUS'        long_text = 'Status'          medium_text = 'Status'         short_text = 'Status')                TO l_t_columns_text.
  APPEND VALUE #( column = 'DESCRICAO'        long_text = 'Descrição'          medium_text = 'Descrição'         short_text = 'Descrição')    TO l_t_columns_text.
  APPEND VALUE #( column = 'MENSAGEM'      long_text = 'Mensagem'(010)    medium_text = 'Mensagem'(010)   short_text = 'Mensagem'(010) )      TO l_t_columns_text.


  " /// ------------------------&
  " // Instanciar objeto SALV  /
  " / ========================&

  TRY.
      cl_salv_table=>factory(
        IMPORTING
          r_salv_table = DATA(l_r_salv)
        CHANGING
          t_table      = t_status ).

    CATCH cx_salv_msg.

  ENDTRY.


  " /// -----------------------------&
  " // Atribuir texto das colunas   /
  " / =============================&
  LOOP AT l_t_columns_text INTO DATA(ls_columns_text).
    TRY.
        l_r_column = l_r_salv->get_columns( )->get_column( ls_columns_text-column ).
        l_r_column->set_long_text( ls_columns_text-long_text ).
        l_r_column->set_medium_text( ls_columns_text-medium_text ).
        l_r_column->set_short_text( ls_columns_text-short_text ).

      CATCH cx_salv_not_found.

    ENDTRY.
  ENDLOOP.



  " /// --------------------------------------------------&
  " // Justificar texto da coluna STATUS para o centro   /
  " / ==================================================&
  TRY.
      l_r_column = l_r_salv->get_columns( )->get_column( 'STATUS' ).
      l_r_column->set_alignment(
          value = if_salv_c_alignment=>centered
      ).

    CATCH cx_salv_not_found.

  ENDTRY.

  " /// -------------------------------------------------&
  " // Definir cor das colunas MENSAGEM e COLABORADOR   /
  " / =================================================&
  TRY.
      DATA(l_r_column_tab) = CAST cl_salv_column_table( l_r_salv->get_columns( )->get_column( 'COLABORADOR' ) ).
      l_r_column_tab->set_color( VALUE #( col = col_heading ) ).
    CATCH cx_salv_not_found.
  ENDTRY.

  TRY.

      l_r_columns = l_r_salv->get_columns( ).
      l_r_columns->set_color_column( value = 'IT_COLORS' ).

    CATCH cx_salv_data_error.

  ENDTRY.



  " /// -------------------------------&
  " // Otimizar tamanho das colunas   /
  " / ===============================&
  l_r_salv->get_columns( )->set_optimize( abap_true ).


  " /// -----------------------------&
  " // Definir botões default SALV  /
  " / =============================&
  l_r_salv->get_functions( )->set_default( abap_true ).


  " /// ---------------&
  " // Exibir tabela  /
  " / ===============&
  l_r_salv->display( ).
ENDFORM.
