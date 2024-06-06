INTERFACE zif_bc_tes_text_elem_set
  PUBLIC.

  METHODS publish_output
    IMPORTING !output TYPE REF TO zif_bc_tes_text_elem_output
    RAISING   zcx_bc_output.

ENDINTERFACE.
