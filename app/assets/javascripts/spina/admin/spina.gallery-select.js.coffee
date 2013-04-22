# jQuery plugin
$.fn.galleryselect = ->
  return this.each ->
    gallery = $(this)
    gallery.find('.item input').hide()
    gallery.wrap('<div class="gallery-container" />')

    width = gallery.find('.item').size() * 153
    gallery.css('width', width + "px")

    selected = gallery.find('.item.selected')
    gallery.prepend(selected)

    gallery.find('.item').click ->
      gallery.find('.item').removeClass('selected')
      gallery.find('.item input').attr('checked', false)
      $(this).toggleClass('selected')
      $(this).find('input').attr('checked', true)
