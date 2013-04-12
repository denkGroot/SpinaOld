jQuery ->

  $(document).on 'click', '[data-collapse]', ->
    target = $(this).data('collapse')
    $(target).slideToggle()
    return false