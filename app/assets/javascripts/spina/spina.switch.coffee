# jQuery plugin checkbox
$.fn.spinaSwitch = ->
  return this.each ->
    input = $(this)
    input.hide()

    # Check if it is checked
    if input.is(':checked')
      klass = "checkbox activated"
    else
      klass = "checkbox"

    onIcon = input.data('on') or "v"
    offIcon = input.data('off') or "x"

    # Insert new HTML into the DOM
    input.after('<a href="#' + input.attr("id") + '" class="' + klass + '">
                  <span class="knob"></span>
                  <i data-icon="' + onIcon + '"></i>
                  <i data-icon="' + offIcon + '"></i>
                </a>')

# Click handlers for checkbox
$(document).on 'click', 'a.checkbox', (e) ->
  toggleSwitch(e)

$(document).on 'touchend', 'a.checkbox', (e) ->
  toggleSwitch(e)

toggleSwitch = (e) ->
  checkbox = $(e.currentTarget)
  input = $(checkbox.attr("href"))

  if checkbox.hasClass('activated')
    checkbox.removeClass('activated')
    input.attr("checked", false)
  else
    checkbox.addClass('activated')
    input.attr("checked", true)

  return false