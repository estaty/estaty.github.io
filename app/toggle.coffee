$(document).on 'change', 'input.js-toggle', () ->
  $this = $ this
  show = $(this).data('show')
  hide = $(this).data('hide')

  if $this.attr('type') in ['checkbox', 'radio'] and $this.is ':checked'
    if show
      $(show)
        .removeClass 'hidden'
        .find(':input')
        .addBack()
          .removeAttr 'disabled'

    if hide
      $(hide)
        .addClass 'hidden'
        .find(':input')
        .addBack()
          .attr 'disabled', 'disabled'

$('.js-toggle-active-labels').on 'click', 'label', () ->
  $this = $ this
  $this
    .addClass('active')
    .closest('.js-toggle-active-labels')
    .find('.active')
      .not($this)
        .removeClass('active')
