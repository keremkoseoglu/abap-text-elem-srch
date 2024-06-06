INTERFACE zif_bc_tes_text_elem_output
  PUBLIC.

  METHODS publish
    IMPORTING text_elements TYPE zbctt_tes_output
    RAISING   zcx_bc_output.

ENDINTERFACE.
