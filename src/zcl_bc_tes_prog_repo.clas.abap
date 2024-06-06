CLASS zcl_bc_tes_prog_repo DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_bc_tes_textpool_cont_repo.
ENDCLASS.


CLASS zcl_bc_tes_prog_repo IMPLEMENTATION.
  METHOD zif_bc_tes_textpool_cont_repo~get_textpool_containers.
    SELECT FROM tadir "#EC CI_GENBUFF
           FIELDS obj_name
           WHERE pgmid     = 'R3TR'
             AND object    = 'PROG'
             AND obj_name IN @input-object_name_rng
             AND devclass IN @input-dev_class_rng
           INTO TABLE @result.
  ENDMETHOD.
ENDCLASS.
