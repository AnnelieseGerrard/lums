import "dropzone";

const initializeDropzone = () => {
    dropzone.Dropzone.options.submissionUpload = {
      paramName: "file", // The name that will be used to transfer the file
      maxFilesize: 20, // MB
      timeout: 180000,
      acceptedFiles: ".zip"
    };
    dropzone.Dropzone.autoDiscover = false;
};

export { initializeDropzone }