module ApplicationHelper
  def translate_attribute(object = nil, method = nil)
    if object && method
      object.model.human_attribute_name(method)
    else
      'Invalid parameters'
    end
  end
end
