CLASS zcl_bc_tes_fugr_repo DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_bc_tes_textpool_cont_repo.
ENDCLASS.


CLASS zcl_bc_tes_fugr_repo IMPLEMENTATION.
  METHOD zif_bc_tes_textpool_cont_repo~get_textpool_containers.
    SELECT FROM tadir "#EC CI_GENBUFF
           FIELDS obj_name
           WHERE pgmid     = 'R3TR'
             AND object    = 'FUGR'
             AND obj_name IN @input-object_name_rng
             AND devclass IN @input-dev_class_rng
           INTO TABLE @DATA(func_groups).

    LOOP AT func_groups REFERENCE INTO DATA(fugr).
      APPEND |SAPL{ fugr->obj_name }| TO result.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
