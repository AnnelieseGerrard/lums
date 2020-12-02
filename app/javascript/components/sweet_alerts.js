import Swal from "sweetalert2";

const newLectureProcessingAlert = () => {
  Swal.fire({
    title: 'Processing...',
    text: 'Please wait...',
  });
  Swal.showLoading();
}

const areYouSureAlertForDestroyLecture = (event) => {
  const lectureId = event.path[1].dataset.lectureId
  Swal.fire({
    title: 'Are you sure?',
    text: "You won't be able to revert this!",
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',
    confirmButtonText: 'Yes, delete it!'
  }).then((result) => {
    if (result.isConfirmed) {
      Swal.fire(
        'Deleted!',
        'Lecture has been deleted.',
        'success'
      )
      document.getElementById(`delete-lecture-${lectureId}`).click()
      document.getElementById(`lecture-card-${lectureId}`).remove()
    }
  })
}

const initNewLectureUploadAlert = () => {
  const newLectureButton = document.getElementById("newLectureSubmitButton");

  if (newLectureButton) {
    newLectureButton.addEventListener("click", (event) => {
      newLectureProcessingAlert();
    });
  };
};

const initAreYouSureAlertForDestroyLecture = () => {
  console.log("hello");
  const deleteIcons = document.querySelectorAll(".delete-lecture-icon-fake");
  console.log(deleteIcons);
  if (deleteIcons) {
    deleteIcons.forEach(icon => {
      console.log(icon);
      icon.addEventListener("click", (event) => {
        console.log("icon clicked");
        areYouSureAlertForDestroyLecture(event);
      })
    })
  }
}

export { initAreYouSureAlertForDestroyLecture, initNewLectureUploadAlert } 