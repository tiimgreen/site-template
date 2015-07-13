module AdminHelper
  include ActionView::Helpers::UrlHelper

  # Text
  def edit_text(
    page,
    key,
    default_text = 'Lorem ipsum dolor sit amet domo, consectetur adipisicing elit.'
  )
    page_id = key.start_with?('global') ? 0 : page.id

    if (page_element = PageElementText.find_by(key: key, web_page_id: page_id)).nil?
      value_to_return = default_text

      page_element = PageElementText.create(
        key: key,
        value: default_text,
        web_page_id: page_id
      )
    else
      value_to_return = page_element.value
    end

    if user_signed_in?
      value_to_return += " "
      value_to_return +=
        link_to('Edit', edit_page_element_path(page_element), class: 'edit-page-element')
    end

    value_to_return.html_safe
  end

  def read_text(
    page,
    key,
    default = ''
  )
    page_id = key.start_with?('global') ? 0 : page.id

    if (page_element = PageElementText.find_by(key: key, web_page_id: page_id))
      page_element.value.html_safe
    else
      default.html_safe
    end
  end

  # Link
  def edit_link(
    page,
    key,
    default_text = 'Lorem ipsum dolor sit amet domo, consectetur adipisicing elit.',
    default_link = '/',
    options = {}
  )
    page_id = key.start_with?('global') ? 0 : page.id

    if (page_element_link = PageElementLink.find_by(key: key, web_page_id: page_id)).nil?
      value_to_return = link_to(default_text, default_link, options)

      page_element_link = PageElementLink.create(
          key: key,
          text: default_text,
          link: default_link,
          web_page_id: page_id
        )
    else
      value_to_return = link_to(page_element_link.text, page_element_link.link, options)
    end

    if user_signed_in?
      value_to_return += " "
      value_to_return +=
        link_to('Edit', edit_page_element_link_path(page_element_link), class: 'edit-page-element')
    end

    value_to_return.html_safe
  end
end
