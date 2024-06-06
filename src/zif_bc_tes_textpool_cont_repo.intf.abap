INTERFACE zif_bc_tes_textpool_cont_repo
  PUBLIC.

  CONSTANTS: BEGIN OF interface,
               me TYPE seoclsname VALUE 'ZIF_BC_TES_TEXTPOOL_CONT_REPO',
             END OF interface.

  METHODS get_textpool_containers
    IMPORTING !input        TYPE zbcs_tes_textpool_cont_inp
    RETURNING VALUE(result) TYPE rso_t_objnm.

ENDINTERFACE.
