//= require 'jquery-latest.min'
//= require 'jquery-mobilemenu.min'
//= require 'jquery-ui.min'
//= require 'custom'
//= require 'unite-gallery/unite-gallery.min'
//= require 'unite-gallery/tiles/ug-theme-tiles'

window.$ = jQuery;

$(document)
  .ready(function() {
    $('#gallery').unitegallery({
      lightbox_type: 'compact'
    });
  });
