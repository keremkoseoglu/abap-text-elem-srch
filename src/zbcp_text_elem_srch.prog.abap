REPORT zbcp_text_elem_srch.

TABLES: vxabapt255, stxh, tadir.

SELECT-OPTIONS: s_phras FOR vxabapt255-line OBLIGATORY NO INTERVALS,
                s_langu FOR stxh-tdspras OBLIGATORY NO INTERVALS,
                s_devcl FOR tadir-devclass,
                s_objna FOR tadir-obj_name.

CAST zif_bc_tes_gui( NEW zcl_bc_tes_def_gui( ) )->run(
    VALUE #( textpool_container_input = VALUE #( dev_class_rng   = s_devcl[]
                                                 object_name_rng = s_objna[] )
             search_phrases           = VALUE #( FOR _phras IN s_phras WHERE ( low IS NOT INITIAL )
                                                 ( _phras-low ) )
             languages                = VALUE #( FOR _lang IN s_langu WHERE ( low IS NOT INITIAL )
                                                 ( _lang-low ) ) ) ).
