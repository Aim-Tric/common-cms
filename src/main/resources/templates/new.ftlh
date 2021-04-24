<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="./plugin/layui/css/layui.css">
  <title>添加</title>
</head>

<body>
  
  <script src="./plugin/layui/layui.js"></script>
  <script>
    layui.use(['element', 'form'], function () {
      var element = layui.element;
      var form = layui.form;
      form.on('submit(formDemo)', function (data) {
        layer.msg(JSON.stringify(data.field));
        return false;
      });
    });
  </script>
</body>

</html>