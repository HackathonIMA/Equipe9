<?php

function importar_foco_form() {
  $form = array();

  $form['mymodule_node_types'] = array(
    '#type' => 'textfield',
    '#title' => t("Node types enabled for my module"),
    '#default_value' => 'abc',
  );

  return $form;
}
