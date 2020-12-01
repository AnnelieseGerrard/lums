import Sortable from "sortablejs";
import Rails from "@rails/ujs";

// Changing style of lecture#show tray on selection of lecture

// const trayItemChange = () => {
//   const trayItem = document.querySelectorAll(".lecture-card");
//   trayItem.forEach(item => {
//     const trayLink = item.children[0].getAttribute('href');
//     console.log(trayLink)
//     console.log(window.location.pathname)
//     if (trayLink === window.location.pathname) {
//       console.log("change!")
//       item.style.backgroundColor = "yellow"
//     } else {
//     };
//   });
// };

// Setting drag and drop for lecture cards
const initLectureSorting = () => {
  window.Rails = Rails
  const tray = document.getElementById("lecture-tray-sortable");
  if (tray) {
    console.log(tray);
    Sortable.create(tray, {
      ghostClass: "ghost",
      animation: 150,
      onEnd: (event) => {
        console.log(event);
        let data = new FormData();

        let url = `${event.item.dataset.id}/move`;
        console.log(url);
        data.append("position", event.newIndex + 1);
        console.log(`old index ${event.oldIndex}`);
        console.log(`new index ${event.newIndex}`);
        Rails.ajax({
          url: url,
          type: "PATCH",
          data: data
        });
      }
    });
  }
};

export { initLectureSorting };
