CLASS zcl_bc_tes_text_elem_alvg_out DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_bc_tes_text_elem_output.

  PRIVATE SECTION.
    DATA text_elements TYPE zbctt_tes_output.
ENDCLASS.


CLASS zcl_bc_tes_text_elem_alvg_out IMPLEMENTATION.
  METHOD zif_bc_tes_text_elem_output~publish.
    me->text_elements = text_elements.

    TRY.
        NEW ycl_addict_alv( REF #( me->text_elements ) )->show( ).

      CATCH cx_root INTO DATA(alv_error).
        RAISE EXCEPTION NEW zcx_bc_output( textid   = zcx_bc_output=>generation_failed
                                           previous = alv_error ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
