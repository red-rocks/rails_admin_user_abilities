$(document).on 'change', ".user_abilities_trigger, .model_accesses_trigger", (e)->
  _target = $(e.currentTarget)
  _confirm_message = _target.data('confirm-message')
  if !_confirm_message or confirm(_confirm_message)
    _label = _target.siblings('label')
    _label.find(".message").remove()
    $.post _target.closest("[data-url]").data("url"), _target.siblings().andSelf().serializeArray(), (data)->
      _label.find(".message").remove()
      _label.append(data)
  else
    _target.prop("checked", !_target.prop("checked"));


$(document).on "ajax:send", "", (e, xhr)->
  button = $(e.currentTarget)
  target = $(button.data('target'))
  target.html("")


$(document).on "ajax:success", ".json_block button[data-remote]", (e, data, status, xhr)->
  button = $(e.currentTarget)
  target = $(button.data('target'))
  target.html(data)
