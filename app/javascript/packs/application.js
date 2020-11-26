// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import "bootstrap"

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

require("trix")
require("@rails/actiontext")

// Internal imports:
import { navChange } from '../components/navbar';

//turbolinks import
document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // initSelect2();
  navChange();
});

// Controlling parameters for the dropzone upload area
Dropzone.options.submissionUpload = {
  paramName: "file", // The name that will be used to transfer the file
  maxFilesize: 20, // MB
  timeout: 180000,
  acceptedFiles: ".zip"
};

// Setting it drag and drop for lecture cards
import Sortable from "sortablejs";
import Rails from "@rails/ujs";
window.Rails = Rails;

const tray = document.getElementById("lecture-tray-sortable");

Sortable.create(tray, {
  ghostClass: "ghost",
  animation: 150,
  onEnd: (event) => {
    console.log(event);
    const item = event.item;
    let data = new FormData();

    data.append("position", event.newIndex + 1);
    let url = `${event.item.href}/move`;
    console.log(url);
    Rails.ajax({
      url: url,
      type: "PATCH",
      data: data
    });
  }
});
