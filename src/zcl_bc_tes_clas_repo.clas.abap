CLASS zcl_bc_tes_clas_repo DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_bc_tes_textpool_cont_repo.
ENDCLASS.


CLASS zcl_bc_tes_clas_repo IMPLEMENTATION.
  METHOD zif_bc_tes_textpool_cont_repo~get_textpool_containers.
    SELECT FROM tadir "#EC CI_GENBUFF
           FIELDS obj_name
           WHERE pgmid     = 'R3TR'
             AND object    = 'CLAS'
             AND obj_name IN @input-object_name_rng
             AND devclass IN @input-dev_class_rng
           INTO TABLE @DATA(classes).

    LOOP AT classes INTO DATA(cls).
      WHILE strlen( cls-obj_name ) < 30.
        cls-obj_name = |{ cls-obj_name }=|.
      ENDWHILE.

      APPEND |{ cls-obj_name }CP| TO result.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
