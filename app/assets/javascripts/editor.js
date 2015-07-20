for (var i = 1; i < 3; i++) {
  var identifier = 'editor';

  if (i > 1) {
    identifier += '_' + i;
  }

  if ($('#' + identifier).length > 0) {
    var editor = new Editor({
      element: document.getElementById(identifier)
    });

    editor.render();
  }
}

