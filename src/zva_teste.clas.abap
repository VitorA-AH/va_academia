class ZVA_TESTE definition
  public
  inheriting from ZAH_CL_PORTAL_COL
  final
  create public .

public section.

  methods GET_PHOTO
    importing
      !IT_NUM_EMP type ZAH_TT_NUM_EMP
    exporting
      !ET_PHOTO_EMP type ZAH_TT_PHOTO_EMP .
protected section.
private section.
ENDCLASS.



CLASS ZVA_TESTE IMPLEMENTATION.


  METHOD get_photo.
    DATA:
      lv_photo_exists TYPE c,
      ls_connect_info TYPE  toav0,
      lt_acinf        TYPE TABLE OF scms_acinf,
      lt_content      TYPE TABLE OF sdokcntbin,
      lv_length       TYPE i,
      lv_emp_photo    TYPE xstring,
*          lt_content      TYPE STANDARD TABLE OF string,
      lv_photo_base64 TYPE string,
      ls_photo_emp    TYPE zah_s_photo_emp.



    "metodo validar os numeros do colaborador importados
    "casa nao sejam importados nenhum o metodo retorna todos os colaboradores ativos
    zah_i_common_methods~validate_num_emp(
      EXPORTING
        it_num_emp           =   it_num_emp  " tabela de importação/exportação do número de colaborador
      IMPORTING
        et_num_emp_validated =   DATA(lt_num_emps)  " tabela de importação/exportação do número de colaborador
    ).

    "lopp à tabela de colaboradores
    LOOP AT lt_num_emps INTO DATA(ls_num_emp).

      CLEAR: lv_photo_exists,
      lv_length.

      FREE: ls_connect_info,
       lt_acinf,
       lt_content,
       lv_length,
       ls_photo_emp.

      "verifica se existe foto deste colaborador
      CALL FUNCTION 'HR_IMAGE_EXISTS'
        EXPORTING
          p_pernr               = ls_num_emp-num_emp
        IMPORTING
          p_exists              = lv_photo_exists
          p_connect_info        = ls_connect_info
        EXCEPTIONS
          error_connectiontable = 1
          OTHERS                = 2.

      "se existir foto
      IF ls_connect_info IS NOT INITIAL.

        "vai ler as informaçoes da mesma e recolher o binario
        CALL FUNCTION 'SCMS_DOC_READ'
          EXPORTING
            stor_cat    = ' '
            crep_id     = ls_connect_info-archiv_id
            doc_id      = ls_connect_info-arc_doc_id
          TABLES
            access_info = lt_acinf
            content_bin = lt_content.

        "recolhe o numero de linhas de binario
        DATA(lv_last_line) = lines( lt_content )."funçao que conta o numero de linhas na tabela

*** NOVA SINTAXE READ TABLE ***
        TRY.
            "recolhe o tamanho da foto
            lv_length = lt_acinf[ 1 ]-comp_size.

          CATCH cx_sy_itab_line_not_found.

        ENDTRY.

        "transforma o binario numa unica string
        CALL FUNCTION 'SCMS_BINARY_TO_XSTRING'
          EXPORTING
            input_length = lv_length
            first_line   = 0
            last_line    = lv_last_line
          IMPORTING
            buffer       = lv_emp_photo
          TABLES
            binary_tab   = lt_content.



        ls_photo_emp-num_emp = ls_num_emp-num_emp.
        ls_photo_emp-photo_emp = lv_emp_photo.

        "preenche a tabela de exportaçao
        APPEND ls_photo_emp TO et_photo_emp.

      ENDIF.

    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
