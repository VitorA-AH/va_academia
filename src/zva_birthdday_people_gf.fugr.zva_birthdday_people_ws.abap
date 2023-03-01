FUNCTION ZVA_BIRTHDDAY_PEOPLE_WS.
*"----------------------------------------------------------------------
*"*"Interface local:
*"  EXPORTING
*"     VALUE(ET_BIRTHDAY_PEOPLE) TYPE  ZVA_TT_BIRTHDAY_PEOPLE
*"----------------------------------------------------------------------

data: lo_ZVA_CL_BIRTHDAY_PEOPLE TYPE REF TO ZVA_CL_BIRTHDAY_PEOPLE.

create OBJECT lo_zva_cl_birthday_people.

lo_zva_cl_birthday_people->get_birthday_people(
  IMPORTING
    et_birthday_people =  et_birthday_people   " Tabela exportaçao serviço email aniversariantes
).





ENDFUNCTION.
