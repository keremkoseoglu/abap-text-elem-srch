CLASS zcl_bc_tes_def_gui DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_bc_tes_gui.
ENDCLASS.


CLASS zcl_bc_tes_def_gui IMPLEMENTATION.
  METHOD zif_bc_tes_gui~run.
    TRY.
        CAST zif_bc_tes_text_elem_set( NEW zcl_bc_tes_srch_res_set( search_input )
             )->publish_output( CAST #( NEW zcl_bc_tes_text_elem_alvg_out( ) ) ).

      CATCH cx_root INTO DATA(diaper).
        ycl_addict_gui_toolkit=>report_fatal_error( diaper ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
