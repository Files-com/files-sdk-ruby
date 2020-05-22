var BrickFTP = (function() {

  var languageSelector = function() {
    $('.main-menu .langs a').click(function() {
      $.cookie('_brickftp_lang', $(this).data('lang'), { expires: 365, path: '/', domain: '.brickftp.com' });
    });
  };

  var search = function() {
    var mobileToggle = $('.header .mobile-menu');
    var navBar    = $('.header .main-menu');
    var searchBar = $('.header ul:last');
    var openSearchButton = $('.header .search');
    var closeSearchButton = $('.header .close');
    var menuBG = $('.header .menu')

    var openSearch = function() {
      mobileToggle.attr('style', 'display: none !important;');
      navBar.attr('style', 'display: none !important;');
      menuBG.addClass('search-enabled')
      searchBar.fadeIn(0, function() {
        searchBar.find('input[type="text"]').attr('placeholder', 'Search brickftp.com').focus();
      });
    };

    var closeSearch = function() {
      searchBar.fadeOut(0, function() {
        mobileToggle.removeAttr('style');
        navBar.removeAttr('style');
        openSearchButton.focus();
        menuBG.removeClass('search-enabled')
      });
    };

    openSearchButton
      .click(openSearch)
      .keypress(function(event) {
        if (event.which === 13) {
          openSearch();
        }
      });

    closeSearchButton
      .click(closeSearch)
      .keypress(function(event) {
        if (event.which === 13) {
          closeSearch()
        }
      })
  };

  var mobileMenu = function() {
    var header = $('.header');
    var mainGroup = $('.page-wrapper');
    var menu = $('.header .main-menu');
    var mobileMenu = $('.header .mobile-menu');
    var hamburger = $(".hamburger");

    var hideMenu = function() {
      menu.fadeOut(0);
      mobileMenu.attr('aria-expanded', "false");
      hamburger.removeClass("is-active");
      header.removeClass("menu-active");
      mainGroup.removeClass("menu-active");

      document.removeEventListener('focus', closeMenu, true);
      document.removeEventListener('click', closeMenu, true);
    }

    var showMenu = function() {
      menu.fadeIn(0);
      mobileMenu.attr('aria-expanded', "true");
      hamburger.addClass("is-active");
      header.addClass("menu-active");
      mainGroup.addClass("menu-active");

      document.addEventListener('focus', closeMenu, true);
      document.addEventListener('click', closeMenu, true);
      window.scrollTo(0, 0);
    }

    var toggleMenu = function() {
      var nextAriaExpanded = mobileMenu.attr('aria-expanded') === 'false' ? 'true' : 'false'
      var hide = nextAriaExpanded === 'false'

      if (hide) {
        hideMenu();
      }
      else {
        showMenu();
      }
    }

    var closeMenu = function(event) {
      if ($(event.target).closest(menu).length === 0 && $(event.target).closest(mobileMenu).length === 0) {
        hideMenu();
      }
    };

    mobileMenu.click(toggleMenu)
  };

  var menuDrop = function() {
    var closeMenu = function(event) {
      if ($(event.target).closest('.drop-link').length === 0) {
        $('.menu-drop .drop-link.expand')
          .attr('aria-expanded', 'false')
          .removeClass('expand');
      }
    };

    document.addEventListener('focus', closeMenu, true);
    document.addEventListener('click', closeMenu, true);

    var toggleMenu = function(event) {
      var toggleButton = $(event.target).closest('.drop-link');

      $('.drop-link').not(toggleButton).attr('aria-expanded', 'false').removeClass('expand');

      if (toggleButton.hasClass('expand')) {
        toggleButton.attr('aria-expanded', 'false')
      }
      else {
        toggleButton.attr('aria-expanded', 'true')
      }

      toggleButton.toggleClass('expand')
    };

    $('.menu-drop .drop-link')
      .attr('role', 'button')
      .click(toggleMenu)
      .keypress(function(event) {
        if (event.which === 13) {
          toggleMenu(event);
        }
      })
  };

  return {
    init: function() {
      mobileMenu();
      menuDrop();
      languageSelector();
      search();
    }
  };

})();

$(document).ready(function() {
BrickFTP.init();
});
