import Swal from "sweetalert2";

const newLectureProcessingAlert = () => {
  Swal.fire({
    title: 'Processing...',
    text: 'Please wait...',
  });
  Swal.showLoading();
}

const initNewLectureUploadAlert = () => {
  const newLectureButton = document.getElementById("newLectureSubmitButton");

  if (newLectureButton) {
    newLectureButton.addEventListener("click", (event) => {
      newLectureProcessingAlert();
    });
  };
};

export { initNewLectureUploadAlert }