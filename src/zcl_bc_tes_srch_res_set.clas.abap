CLASS zcl_bc_tes_srch_res_set DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_bc_tes_text_elem_set.

    METHODS constructor
      IMPORTING input type zbcs_tes_srch_input
      RAISING   ycx_addict_object.

  PRIVATE SECTION.
    DATA search_results TYPE zbctt_tes_output.
ENDCLASS.


CLASS zcl_bc_tes_srch_res_set IMPLEMENTATION.
  METHOD constructor.
    DATA obj TYPE REF TO object.

    TRY.
        DATA(textpool_container_repo_names) = ycl_addict_class=>get_instance(
                                                  zif_bc_tes_textpool_cont_repo=>interface-me )->get_instanceable_subclasses( ).

      CATCH cx_root INTO DATA(repo_if_error).
        RAISE EXCEPTION NEW ycx_addict_object( textid   = ycx_addict_object=>cant_create_instance
                                               previous = repo_if_error
                                               clsname  = ycl_addict_class=>get_class_name( me ) ).
    ENDTRY.

    LOOP AT textpool_container_repo_names REFERENCE INTO DATA(textpool_container_repo_name).
      CREATE OBJECT obj TYPE (textpool_container_repo_name->*).
      DATA(textpool_container_repo) = CAST zif_bc_tes_textpool_cont_repo( obj ).
      DATA(textpool_containers) = textpool_container_repo->get_textpool_containers( input-textpool_container_input ).

      LOOP AT textpool_containers REFERENCE INTO DATA(textpool_container).
        LOOP AT input-languages REFERENCE INTO DATA(language).
          DATA(text_elements) = VALUE textpool_table( ).
          READ TEXTPOOL textpool_container->* INTO text_elements LANGUAGE language->*.

          LOOP AT text_elements REFERENCE INTO DATA(text_element).
            LOOP AT input-search_phrases REFERENCE INTO DATA(search_phrase).
              CHECK    text_element->entry             CS search_phrase->*
                    OR to_upper( text_element->entry ) CS to_upper( search_phrase->* )
                    OR to_lower( text_element->entry ) CS to_lower( search_phrase->* ).

              APPEND VALUE #( obj_name = textpool_container->*
                              langu    = language->*
                              id       = text_element->id
                              key      = text_element->key
                              entry    = text_element->entry
                              length   = text_element->length )
                     TO me->search_results.
            ENDLOOP.
          ENDLOOP.

        ENDLOOP.
      ENDLOOP.
    ENDLOOP.

    SORT me->search_results BY table_line.
    DELETE ADJACENT DUPLICATES FROM me->search_results COMPARING table_line.
  ENDMETHOD.

  METHOD zif_bc_tes_text_elem_set~publish_output.
    output->publish( me->search_results ).
  ENDMETHOD.
ENDCLASS.
