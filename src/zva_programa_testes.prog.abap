*&---------------------------------------------------------------------*
*& Report ZVA_PROGRAMA_TESTES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zva_programa_testes.


*TABLES: pa0001.
*
*SELECTION-SCREEN BEGIN OF BLOCK sc_g2 WITH FRAME .
*
*SELECT-OPTIONS so_so1 FOR pa0001-pernr.
*
*SELECTION-SCREEN END OF BLOCK sc_g2.
*
*SELECTION-SCREEN BEGIN OF BLOCK sc_g1 WITH FRAME .
*
*PARAMETER p_parm1 TYPE i.
*
*SELECTION-SCREEN END OF BLOCK sc_g1.
*
*
*SELECTION-SCREEN BEGIN OF BLOCK sc_g3 WITH FRAME.
*
*PARAMETERS: rb_1 RADIOBUTTON GROUP rbg1 DEFAULT 'X',
*            rb_2 RADIOBUTTON GROUP rbg1.
*
*SELECTION-SCREEN END OF BLOCK sc_g3.
*
*SELECTION-SCREEN BEGIN OF BLOCK sc_g4 WITH FRAME.
*
*PARAMETERS: cb_1 AS CHECKBOX DEFAULT abap_true.
*
*SELECTION-SCREEN END OF BLOCK sc_g4.
*
*DATA: lv_variavel_1     TYPE i,
*      lv_variavel_2(20) TYPE c.
*
*MOVE 10 TO lv_variavel_1. "Atribuição de valores ás variáveis
*MOVE 'ABC' TO lv_variavel_2.
*
*
* Escreve conteúdo das variáveis no ecrã
*WRITE: lv_variavel_1,
*       lv_variavel_2.
*
*TYPES: lty_contador      TYPE i, "Elementares
*       lty_tipo_nome(25).
*
*TYPES: BEGIN OF lest_endereco, "Strings de campos/ /Estruturas
*         nome       TYPE lty_tipo_nome,
*         rua(30),
*         cidade(15),
*         cpostal(4),
*       END OF lest_endereco.
*
*TYPES: lest_endereco2 TYPE lest_endereco.
*
*DATA: lv_contador     TYPE  i     VALUE  100,
*      lv_quantia      TYPE  p    DECIMALS  2  VALUE  '2000.05',
*      lv_caudal       TYPE  f    VALUE  '12e-3',
*      lv_ext_telef(4) TYPE  n    VALUE  '1203',
*      lv_local(4)     TYPE  c   VALUE  '1203',
*      lv_data         TYPE  d    VALUE  '19990910',
*      lv_hora         TYPE  t    VALUE  '154600',
*      lv_tipo_nome    TYPE  lty_tipo_nome,
*      lv_cliente      LIKE  kna1-kunnr,
*      lv_cliente_2    LIKE  lv_cliente.
*
*
*DATA: ls_endereco_1 TYPE lest_endereco.
*DATA: BEGIN OF ls_endereco_2,
*        nome       TYPE lty_tipo_nome,
*        rua(30),
*        cidade(15),
*        cpostal(4) TYPE n,
*      END OF ls_endereco_2.
*
*DATA: ls_endereco_3 LIKE ls_endereco_1,
*      ls_endereco_4 LIKE adrc.
*
*
*
*DATA: lt_lista_enderecos_1 TYPE lest_endereco OCCURS 0 WITH HEADER LINE.
*
*DATA: lt_lista_enderecos_2 LIKE lt_lista_enderecos_1 OCCURS 0 WITH HEADER LINE.
*
*DATA: BEGIN OF lt_lista_enderecos OCCURS 0,
*        nome       TYPE lty_tipo_nome,
*        rua(30),
*        cidade(15),
*        cpostal(4) TYPE n,
*      END OF lt_lista_enderecos.
*
*
*
*
*DATA: lt_lista_enderecos   TYPE lest_endereco OCCURS 0,
*      lt_lista_enderecos_2 LIKE ls_endereco_2 OCCURS 0,
*      lt_lista_enderecos_3 TYPE STANDARD TABLE OF lest_endereco2.
*
*
*
*
*DATA:  BEGIN OF lt_kna1 OCCURS 0.
*    INCLUDE STRUCTURE kna1.
*DATA:  END OF lt_kna1.
*
*DATA: lt_kna1_2 LIKE kna1 OCCURS 0 WITH HEADER LINE,
*      lt_kna1_3 LIKE kna1 OCCURS 0,
*      lt_kna1_4 TYPE STANDARD TABLE OF kna1.
*
*
*
*CONSTANTS: lc_contador  TYPE  i                    VALUE  100,
*           lc_local(4)  TYPE  c                 VALUE  1203,
*           lc_tipo_nome TYPE  lty_tipo_nome   VALUE  'apelido',
*           lc_cliente   LIKE  kna1-kunnr VALUE  '0010000000',
*           lc_cliente_2 LIKE  lc_cliente         VALUE  '0020000000'.
*
*CONSTANTS: BEGIN OF lc_endereco_2,
*             nome       TYPE lty_tipo_nome VALUE '',
*             rua(30)    VALUE 'rua',
*             cidade(15) VALUE 'lisboa',
*             cpostal(4) TYPE n VALUE '2685-190',
*           END OF lc_endereco_2.
*
*
*TABLES kna1.
*DATA:  digitos(10) TYPE c.
*
*CLEAR: digitos, kna1.
*
*TYPES: BEGIN OF lest_rec_type,
*         flag   TYPE c,
*         carrid LIKE spfli-carrid,
*         connid LIKE spfli-connid,
*       END OF lest_rec_type.
*
*DATA: ls_spfli LIKE spfli,
*      ls_rec   TYPE lest_rec_type.
*
*
*MOVE-CORRESPONDING ls_spfli TO ls_rec.
*
*
*
*
*
*
*DATA: lv_carrier LIKE spfli-carrid,
*      ls_rec1    TYPE lest_rec_type,
*      ls_rec2    TYPE lest_rec_type.
*
*MOVE 'lh' TO lv_carrier.
*MOVE: 400 TO ls_rec1-connid, lv_carrier TO ls_rec2-carrid.
*
*ls_rec1-flag = 'X'.
*ls_rec2 = ls_rec1.
*
*WRITE: /15 text-001,
*       /2 sy-datum,
*       /23 text-002,
*       /5 sy-  uname.
*

*
*DATA: lv_final(25) TYPE c VALUE 'abcdeABCDE',
*      lv_padrao(3) TYPE c VALUE 'ABC',
*      lv_subst(5)  TYPE c VALUE '12345'.
*
*REPLACE lv_padrao WITH lv_subst INTO lv_final.
*
*WRITE: lv_final.

*
*DATA: lv_final(25) TYPE c VALUE 'abcde'.
*DATA: lv_final_1(25) TYPE c VALUE 'ABCDE'.
*
*TRANSLATE lv_final to UPPER CASE.
*
*TRANSLATE lv_final_1 USING 'A1B2C3'.
*
*WRITE: lv_final.
*WRITE: / lv_final_1.

*
*DATA: lv_string(50)  TYPE c VALUE 'A       B     C D  E',
*      lv_string2(50) TYPE c.
*
*CONDENSE lv_string.
*
*MOVE lv_string TO lv_string2.
*
*CONDENSE lv_string2 NO-GAPS.
*
*WRITE: lv_string,
*       / lv_string2.

*
*DATA: lv_prim_nome(20)      TYPE c VALUE 'John',
*      lv_outros_nomes(50)   TYPE c VALUE 'F. J.',
*      lv_ulti_nome(25)      TYPE c VALUE 'Kennedy',
*      lv_nome_completo(100) TYPE c.
*
*CONCATENATE lv_prim_nome lv_outros_nomes lv_ulti_nome
*  INTO lv_nome_completo SEPARATED BY space.
*
*WRITE lv_nome_completo.

*
*DATA: lv_digitos(10) TYPE  c VALUE '1234567890',
*      lv_date TYPE datum.
*
*lv_date = '20220927'.
*
*lv_date+6(2) = '01'.
*
*lv_digitos+6 = '9999'.
*
*WRITE: lv_date,
*      / lv_digitos.

*
*DATA: lv_dia_ext(10) TYPE  c VALUE '99990101',
*      lv_date        TYPE sy-datum.
*
*WRITE lv_dia_ext TO lv_date.
*
*WRITE: lv_dia_ext,
*      / lv_date.

*
*DATA: lv_variavel_1(10) TYPE c VALUE 'Variavel 1',
*      lv_variavel_2(10) TYPE c VALUE 'Variavel 2'.
*
*WRITE:  sy-vline,
*       5 lv_variavel_1 COLOR COL_KEY,
*       sy-vline,
*       lv_variavel_2,
*       sy-vline,
*       / sy-uline(29).

*DATA  lv_f1  TYPE  f  VALUE '12.345678e2'.
*
*WRITE: / lv_f1,
*       /,
*       / lv_f1 EXPONENT 1 DECIMALS 4,
*       /,
*       / lv_f1 EXPONENT 0 DECIMALS 2.

*WRITE: 'Teste mensagem!'.
*
*
*MESSAGE S000(zva_msg).



*
*data:lv_start TYPE d,
*      lv_sum1 TYPE f VALUE '1.11111',
*      lv_sum2 TYPE i VALUE 1.
*
*
*      IF lv_start is INITIAL. "se a variavel estiver vazia
*          WRITE: 'Variável nao iniciada.'.
*          IF lv_sum1 GT lv_sum2. "se a variavel 'lv_sum1' for maior que a variavel 'lv_sum2'
*              WRITE: / 'Variavel 1 maior que a variavel 2.'.
*              IF lv_sum1 BETWEEN 0 and 100."se a variavel 'lv_sum1' estiver no intervalo de 0 a 100
*                WRITE: / 'Valor da variavel está no intervalo de 0 a 100.'.
*              ENDIF.
*          ENDIF.
*      ENDIF.


*PARAMETER: p_pais(3) TYPE c.
*
*WRITE: 'Código do pais: ', p_pais.
*
*SKIP 2.
*
*CASE p_pais.
*  WHEN 'DEU'.
*    WRITE: / 'Alemenha.'.
*  WHEN 'USA'.
*    WRITE: / 'Estados Unidos'.
*  WHEN 'POR'.
*    WRITE: / 'Portugal'.
*  WHEN OTHERS.
*    WRITE: / 'Pais não econtrado ou nao definido.'.
*ENDCASE.
*
*
*PARAMETER: p_pais(3) TYPE c.
*
*WRITE: 'Código do pais: ', p_pais.
*
*SKIP 2.
*
*IF p_pais EQ 'DEU'.
*  WRITE: / 'Alemenha.'.
*ELSEIF p_pais EQ 'USA'.
*  WRITE: / 'Estados Unidos'.
*ELSEIF p_pais EQ 'POR'.
*  WRITE: / 'Portugal'.
*ELSE.
*  WRITE: / 'Pais não econtrado ou nao definido.'.
*ENDIF.

*
*DATA: lv_counter        TYPE i,
*      lv_num_passangens TYPE i VALUE 3.
*
*DO.
*  WRITE: / sy-index, 'ª passagem'.
*
*  ADD 1 TO lv_counter.
*
*  CHECK lv_counter EQ lv_num_passangens."verifica se o contador for igual à variavel lv_num_passagens
*  "se for igual significa que ja fizemos o numero de passagens que queremos e sai do ciclo
*
*  WRITE: / 'Fim Ciclo'.
*
*  EXIT.
*ENDDO.

*DATA: lv_num_passangens TYPE i VALUE 3.
*
*FIELD-SYMBOLS: <fs_1> TYPE ANY.
*
*ASSIGN lv_num_passangens TO <fs_1>.
*
*WRITE <fs_1>.

*
*DATA: lt_pa0001 type TABLE OF p0001.
*
*FIELD-SYMBOLS: <fs_tab> TYPE ANY TABLE.
*FIELD-SYMBOLS: <fs_wa> TYPE any.
*
*ASSIGN lt_pa0001 to <fs_tab>.
*select * from pa0001 into table lt_pa0001.


***Serviço aniversariantes***
**
**TYPES: BEGIN OF lest_birthday_person,
**         num_emp     TYPE pernr_d,
**         name_emp    TYPE pad_cname,
**         age         TYPE i,
**         day_string TYPE char25,
**       END OF lest_birthday_person.
**
**
**
**DATA: lr_zah_cl_get_brith_days TYPE REF TO zah_cl_get_brith_days.
**
**CREATE OBJECT lr_zah_cl_get_brith_days.
**
**DATA: lt_num_emp TYPE TABLE OF zah_s_num_emp.
**
**DATA: dt_extenso TYPE TABLE OF casdayattr.
**
**DATA: ls_birthday_people TYPE lest_birthday_person,
**      lt_birthday_people TYPE TABLE OF lest_birthday_person.
**
**DATA: lt_infty_2 TYPE TABLE OF p0002,
**      lv_subrc   TYPE sy-subrc.
**
**
**CALL FUNCTION 'DAY_ATTRIBUTES_GET'
**  EXPORTING
**    date_from      = sy-datum
**    date_to        = sy-datum
**    language       = sy-langu
**  TABLES
**    day_attributes = dt_extenso.
**
**READ TABLE dt_extenso INTO DATA(ls_extenso) INDEX 1.
**
**SPLIT ls_extenso-day_string AT space INTO DATA(lv_dia_semana) DATA(lv_dia) DATA(lv_mes) DATA(lv_ano).
**
**CONCATENATE lv_dia(2) 'de' lv_mes INTO DATA(lv_dia_extenso) SEPARATED BY space.
**
**
**
**lr_zah_cl_get_brith_days->get_birth_days(
**  EXPORTING
**    it_num_emp    = lt_num_emp   " tabela de importação/exportação do número de colaborador
**  IMPORTING
**    et_brith_days = DATA(lt_brith_days)    " tabela importação/exportaçao datas de aniversario
**).
**
**LOOP AT lt_brith_days INTO DATA(ls_birth_days).
**
**  free: lt_infty_2.
**
**  IF ls_birth_days-birth_day+4(4) EQ sy-datum+4(4).
**
**    DATA(lv_age) = sy-datum(4) - ls_birth_days-birth_day(4).
**
**
**    CALL FUNCTION 'HR_READ_INFOTYPE'
**      EXPORTING
**        pernr     = ls_birth_days-num_col
**        infty     = '0002'
**        begda     = sy-datum
**        endda     = sy-datum
**      IMPORTING
**        subrc     = lv_subrc
**      TABLES
**        infty_tab = lt_infty_2.
**    IF lv_subrc EQ 0.
**
**      READ TABLE lt_infty_2 INTO DATA(ls_infty_2) INDEX 1.
**      IF sy-subrc EQ 0.
**        ls_birthday_people-num_emp = ls_birth_days-num_col.
**        ls_birthday_people-name_emp = ls_infty_2-cname.
**        ls_birthday_people-age = lv_age.
**        ls_birthday_people-day_string = lv_dia_extenso.
**
**        APPEND ls_birthday_people to lt_birthday_people.
**      ENDIF.
**
**    ENDIF.
**
**  ENDIF.
**
**ENDLOOP.

DATA: ls_ecra_selecao TYPE rsparams,
      lt_ecra_selecao TYPE TABLE OF rsparams.
*
*
*
*
*CALL FUNCTION 'RSAQ_QUERY_CALL'
*  EXPORTING
**   WORKSPACE                         = ' '
*    query                             = 'ZFITV_TRIP'
*    usergroup                         = 'ZFI-TV'
*   VARIANT                           = 'VAR_2'
**   DBACC                             = 0
**   SKIP_SELSCREEN                    = 'X'
**   DATA_TO_MEMORY                    = ' '
**   FREE_SELECTIONS                   =
** IMPORTING
**   REF_TO_LDATA                      =
**   LISTTEXT                          =
**   LIST_ID                           =
**   PROGRAM                           =
**   USED_VARIANT                      =
* TABLES
*   SELECTION_TABLE                   = lt_ecra_selecao
**   LISTDESC                          =
**   FPAIRS                            =
*.
*
*IF sy-subrc <> 0.
** Implement suitable error handling here
*ENDIF.
*
*CALL FUNCTION 'IQAPI_QCALL'
* EXPORTING
*   QUERY                       = 'ZFITV_TRIP'
**   OLD_QID                     = 'ZFI-TV'
*   VARIANT                     =  'VAR_2'
**   FILTER                      =
** IMPORTING
**   USED_VARIANT                =
* EXCEPTIONS
*   ILLEGAL_INPUT               = 1
*   INTERNAL_ERROR              = 2
*   FUNCTION_NOT_POSSIBLE       = 3
*   OTHERS                      = 4
*          .
*IF sy-subrc <> 0.
** Implement suitable error handling here
*ENDIF.

*data lv_prognam TYPE AQADEF-PGNAME.
*
*  CALL FUNCTION 'RSAQ_REPORT_NAME'
*    EXPORTING
*    WORKSPACE        = ''
*    USERGROUP        = 'Z_GRUPOLR'
*      QUERY            = 'Z_QUERYLR'
*   IMPORTING
*     REPORTNAME       = lv_prognam
*            .
*
*   SUBMIT (lv_prognam) VIA SELECTION-SCREEN AND RETURN.
*
*
*CALL FUNCTION 'RZL_SUBMIT'
*  EXPORTING
*    repid                    = 'Z_QUERYLR'
** EXCEPTIONS
**   NO_ADMIN_AUTHORITY       = 1
**   OTHERS                   = 2
*          .
*IF sy-subrc <> 0.
** Implement suitable error handling here
*ENDIF.

*CALL FUNCTION 'IQAPI_QCALL'
* EXPORTING
*   QUERY                       = 'Z_QUERYLR'
**   OLD_QID                     = 'ZFI-TV'
*   VARIANT                     =  ' '
**   FILTER                      =
** IMPORTING
**   USED_VARIANT                =
* EXCEPTIONS
*   ILLEGAL_INPUT               = 1
*   INTERNAL_ERROR              = 2
*   FUNCTION_NOT_POSSIBLE       = 3
*   OTHERS                      = 4
*          .
*IF sy-subrc <> 0.
** Implement suitable error handling here
*ENDIF.


***CORRETO***


DATA lv_prognam TYPE aqadef-pgname.

"recolher reportname da query
"no parametro 'WORKSPACE'
"  usar '' se for area standard
"  usar 'G' se for area global

**CALL FUNCTION 'RSAQ_REPORT_NAME'
**  EXPORTING
**    workspace  = 'G'
**    usergroup  = 'Z_GRUPOLR'
**    query      = 'Z_QUERYLR'
**  IMPORTING
**    reportname = lv_prognam.
**
***  CONCATENATE 'AQZZ' 'Z_GRUPOLR' '===' 'Z_QUERYLR' '=====' INTO lv_prognam.
**
***SUBMIT AQZZZ_GRUPOLR===Z_QUERYLR===== VIA SELECTION-SCREEN EXPORTING LIST TO MEMORY AND RETURN.
**
**SUBMIT (lv_prognam) USING SELECTION-SET 'VAR_2'  EXPORTING LIST TO MEMORY AND RETURN.
**
**DATA list_tab TYPE TABLE OF abaplist.
**
**"recolhe a lista vinda da query e guardada na memoria
**CALL FUNCTION 'LIST_FROM_MEMORY'
**  TABLES
**    listobject = list_tab
**  EXCEPTIONS
**    not_found  = 1
**    OTHERS     = 2.
**
**DATA: BEGIN OF ascitab OCCURS 1,
**
**        line(256),
**
**      END OF ascitab.
**
**CALL FUNCTION 'LIST_TO_ASCI'
**  EXPORTING
**    list_index = -1
**  TABLES
**    listasci   = ascitab
**    listobject = list_tab.

*
*DATA: BEGIN OF ls_asd,
*        f1(50),
*        f2(50),
*        f3(50),
*        f4(50),
*        f5(50),
*        f6(50),
*        f7(50),
*        f8(50),
*        f9(50),
*        f10(50),
*      END OF ls_asd.
*
*IF sy-subrc EQ 0.
*
*
*DATA(lv_length) = lines( ascitab ).
*
*  FIELD-SYMBOLS <fs_s_test> TYPE TABLE.
*
**  DATA lt_table TYPE TABLE  TABLE.
*
*  LOOP AT ascitab INTO DATA(ls_ascitab).
*    IF sy-tabix GE 5.
*
**       SPLIT ls_ascitab-line AT '|' INTO TABLE <fs_s_test>.
*      CALL FUNCTION 'CONVERT_STRING_TO_TABLE'
*        EXPORTING
*          i_string               = ls_ascitab-line
*          i_tabline_length       = lv_length
*        TABLES
*          et_table               = <fs_s_test>
*                .
*
*
*
*    ENDIF.


*  ENDLOOP.
*
*
*
*ENDIF.

*DATA SLKAS TYPE  rihaufk_list.




*
*CALL FUNCTION 'CONVERT_STRING_TO_TABLE'
*  EXPORTING
*    i_string               =
*    i_tabline_length       =
*  TABLES
*    et_table               =
*          .


*IF sy-subrc = 0.
*  "mostra a lista
*  CALL FUNCTION 'WRITE_LIST'
*    TABLES
*      listobject = list_tab.
*ENDIF.

********************************************************************

*data lt_list TYPE TABLE OF RSAQLDESC.
*
*****CORRETO 2 ***
*CALL FUNCTION 'RSAQ_QUERY_CALL'
*  EXPORTING
*    workspace      = 'G' "tipo de work area
*    usergroup      = 'Z_GRUPOLR' "nome usergroup
*    query          = 'Z_QUERYLR' "nome query
*    dbacc          = '10000' "numero maximo de dados a ir buscar
*    skip_selscreen = '' "nao salta o ecrã de seleção
**   VARIANT        = ''
***   DATA_TO_MEMORY                    = ' '
**   FREE_SELECTIONS                   =
** IMPORTING
***   REF_TO_LDATA                      =
**  LISTTEXT                          =
***   LIST_ID                           =
***   PROGRAM                           =
***   USED_VARIANT                      =
* TABLES
**   SELECTION_TABLE                   =
*   LISTDESC                          = lt_list
***   FPAIRS                            =
*  .


*DATA list_tab TYPE TABLE OF abaplist.
*
*"recolhe a lista vinda da query e guardada na memoria
*CALL FUNCTION 'LIST_FROM_MEMORY'
*  TABLES
*    listobject = list_tab
*  EXCEPTIONS
*    not_found  = 1
*    OTHERS     = 2.


****** Declaração tipos de Tabelas Ranges
***    TYPES: t_rt_LOCL TYPE RANGE OF CHAR2.
***
***
***DATA(lv_iloc_pt) = 'IP-F  -ICM-647'.
***
***data(r_locl) = VALUE t_rt_LOCL( sign = 'I' option = 'EQ'
***    ( low = 'BT' )    " Ativos
***    ( low = 'IP' ) ). " Externos
***
***LOOP AT r_locl INTO DATA(ls_locl).
***
***      CONCATENATE ls_locl-low lv_iloc_pt+2 INTO DATA(lv_iloc).
**
*
***      ENDLOOP.
*data lv_days TYPE tfmatage.
*
*CALL FUNCTION 'FIMA_DAYS_AND_MONTHS_AND_YEARS'
*  EXPORTING
*    i_date_from          = '20220201'
**   I_KEY_DAY_FROM       =
*    i_date_to            = '20220210'
**   I_KEY_DAY_TO         =
**   I_FLG_SEPARATE       = ' '
* IMPORTING
*   E_DAYS               = lv_days
**   E_MONTHS             =
**   E_YEARS              =
*          .

**BREAK-POINT.
**
**data(lv_leap_year) = sy-datum(4) mod 4.

***
***PARAMETERS p_folder TYPE string.
***
***data diretory TYPE string.
***
***data: ifile type filetable.
***data: xfile like line of ifile.
***data:  xdesktop_directory type string.
***data: rc type sy-subrc.
***
***call method cl_gui_frontend_services=>get_desktop_directory
***  changing
***    desktop_directory    = xdesktop_directory.
***
***
***
***Call method cl_gui_frontend_services=>directory_browse
***  EXPORTING
***    window_title         = xdesktop_directory
***    initial_folder       = xdesktop_directory
***  CHANGING
***    selected_folder      = diretory
****  EXCEPTIONS
****    cntl_error           = 1
****    error_no_gui         = 2
****    not_supported_by_gui = 3
****    others               = 4
***  .
***
***
***
***p_folder = diretory.
TABLES sscrfields.

PARAMETERS p_folder TYPE string.
SELECTION-SCREEN:
PUSHBUTTON /81(10) button1 USER-COMMAND but1.
PARAMETERS sfolder_ TYPE string.

INITIALIZATION.


AT SELECTION-SCREEN.

  LOOP AT SCREEN.
    IF sscrfields EQ 'BUT1'.

      PERFORM select_folder_diretory.
      MODIFY SCREEN.
      EXIT.

    ENDIF.
  ENDLOOP.

END-OF-SELECTION.


FORM select_folder_diretory.

  DATA lv_diretory TYPE string.
  DATA:  lv_desktop_directory TYPE string.

  "Recolhe caminho para a pasta Desktop (Ambiente de trabalho)
  CALL METHOD cl_gui_frontend_services=>get_desktop_directory
    CHANGING
      desktop_directory = lv_desktop_directory.

  "atualiza a variavel com o caminho recolhido
  CALL METHOD cl_gui_cfw=>update_view.

  "recolhe caminho para o diretório escolhido
  CALL METHOD cl_gui_frontend_services=>directory_browse
    EXPORTING
      window_title    = 'Pasta onde deseja guardar o ficheiro:'
      initial_folder  = lv_desktop_directory
    CHANGING
      selected_folder = lv_diretory
*  EXCEPTIONS
*     cntl_error      = 1
*     error_no_gui    = 2
*     not_supported_by_gui = 3
*     others          = 4
    .

  "dá valor ao parameter do ecrã de sleção
  p_folder = lv_diretory.
ENDFORM.


*********************************************************************
