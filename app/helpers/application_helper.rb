module ApplicationHelper
  def fa_icon_link_to id: nil, link_url: nil, icon_name: nil, class_name: nil, text: nil, data: nil
    span_tag = content_tag(:span, text, class: 'icon') do
      content_tag(:i, nil, class: "fas fa-#{icon_name}")
    end
    text_tag = content_tag(:span, text)
    span_tag.concat(text_tag)
    link_to span_tag.html_safe, link_url, id: id, class: class_name, data: data
  end
end
