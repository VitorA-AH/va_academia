FUNCTION zva_teste_photo_mf.
*"----------------------------------------------------------------------
*"*"Interface local:
*"  IMPORTING
*"     REFERENCE(IT_NUM_EMP) TYPE  ZAH_TT_NUM_EMP
*"  EXPORTING
*"     REFERENCE(ET_PHOTO_EMP) TYPE  ZAH_TT_PHOTO_EMP
*"----------------------------------------------------------------------

  DATA:
          lo_zva_cl_teste TYPE REF TO zva_teste.
  CREATE OBJECT lo_zva_cl_teste.

  lo_zva_cl_teste->get_photo(
    EXPORTING
      it_num_emp   = it_num_emp    " tabela de importação/exportação do número de colaborador
    IMPORTING
      et_photo_emp = et_photo_emp    " Tipo de tabela para exportação fotos do colaborador
  ).



ENDFUNCTION.
