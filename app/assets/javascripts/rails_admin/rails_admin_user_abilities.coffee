$(document).delegate ".user_abilities_trigger, .model_accesses_trigger", 'change', (e)->
  _target = $(e.currentTarget)
  $.post _target.closest("[data-url]").data("url"), _target.siblings().andSelf().serializeArray(), (data)->
    _label = _target.siblings('label')
    _label.find(".message").remove()
    _label.append(data)
