import Sortable from "sortablejs";
import Rails from "@rails/ujs";

// Setting drag and drop for lecture cards
const initLectureSorting = () => {
  console.log("loaded initLectureSorting");
  window.Rails = Rails
  const tray = document.getElementById("lecture-tray-sortable");

  Sortable.create(tray, {
    ghostClass: "ghost",
    animation: 150,
    onEnd: (event) => {
      console.log(event);
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
};

export { initLectureSorting };