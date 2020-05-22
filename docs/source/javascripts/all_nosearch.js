//= require ./lib/_energize
//= require ./app/_toc
//= require ./app/_lang


var navHeight = 61; //see also _variables.scss

$(function() {
  loadToc($('#toc'), '.toc-link', '.toc-list-h2', 10 + navHeight);
  setupLanguages($('body').data('languages'));
  $('.content').imagesLoaded( function() {
    window.recacheHeights();
    window.refreshToc();
  });

  var $root = $('html, body');
  $('a[href^="#"][href!="#"]').click(function(e) {
    e.preventDefault();
    var href = $.attr(this, 'href');
    var offset = $(href).offset();
    if (offset) {
      $root.animate({
        scrollTop: offset.top - navHeight
      }, 200);
    }
    if (window.history && window.history.pushState) {
      window.history.pushState({}, document.title, location.pathname + href);
    }
  })
});



window.onpopstate = function() {
  activateLanguage(getLanguageFromQueryString());
};
