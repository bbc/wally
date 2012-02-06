$().ready(function(){
  $("#projects").change(function(){
    var project = $("#projects option:selected").val();
    window.location = "/projects/" + project;
  });
});
