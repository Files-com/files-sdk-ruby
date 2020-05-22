var ToggleButtons = (function() {

  var docsToggleButtons = function() {
    var html = $('#code-tabs').html();
    $('.tab-shell--json, .tab-json').before(html);
    $('.highlight[class*=-xml]').hide();
    $('a[data-language-name*=--xml]').hide();

    $('.lang-selector a').click(function(event) {
      var firstParagraph = null;
      var offsetStart = null;
      var scrollTop = $(window).scrollTop();
      $(".content").find("h1, h2, h3, table, p").each(function() {
        var offset = $(this).offset().top;
        if (!firstParagraph && offset > scrollTop) {
          firstParagraph = $(this);
          offsetStart = offset;
        }
      });
      setActive('json');
      var offsetEnd = firstParagraph.offset().top;
      var difference = offsetEnd - offsetStart;
      $(window).scrollTop($(window).scrollTop() + difference);
      window.recacheHeights();
    });

    $(document).on('click', '.code-tabs button', function() {
      var clicked = $(this);
      var lang = clicked.data('lang');
      var offsetStart = clicked.offset().top;
      setActive(lang);
      var offsetEnd = clicked.offset().top;
      var difference = offsetEnd - offsetStart;
      $(window).scrollTop($(window).scrollTop() + difference);
      window.recacheHeights();
    });

    setActive('json');
  };

  function setActive(lang) {
    var slateLang = $('a[class=active]').attr('data-language-name');
    slateLang = slateLang.substr(0, slateLang.indexOf('--'));
    if (slateLang != "shell") {
      lang = "json";
    }
    $('.highlight[class*=-xml], .highlight[class*=-json]').hide();
    $('.tab-' + slateLang + '--' + lang).show();
    $('.tab-xml, .tab-json').hide();
    $('.tab-' + lang).show();
    if (slateLang == "shell") {
      $(".code-tabs").show();
      $('.code-tabs button').removeClass('active');
      $('.code-tabs button[data-lang="' + lang + '"]').addClass('active');
    } else {
      $(".code-tabs").hide();
    }
  }

  return {
    init: function() {
      docsToggleButtons();
    }
  };

})();

$(document).ready(function() {
  ToggleButtons.init();
});
