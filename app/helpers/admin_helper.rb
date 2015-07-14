module AdminHelper
  include ActionView::Helpers::UrlHelper

  # Text
  def edit_text(
    page,
    key,
    default_text = 'Lorem ipsum dolor sit amet domo, consectetur adipisicing elit.',
    options = { render_markdown: true, p_tags: true }
  )
    page_id = key.start_with?('global') ? 0 : page.id
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                        autolink: true,
                                        space_after_headers: true,
                                        prettify: true)

    page_element =
      PageElementText.create_with(value: default_text).find_or_create_by(key: key, web_page_id: page_id)

    value_to_return = page_element.default_text

    if user_signed_in?
      value_to_return += " "
      value_to_return +=
        link_to('Edit', edit_page_element_text_path(page_element), class: 'edit-page-element')
    end

    if options[:render_markdown]
      value_to_return = @markdown.render(value_to_return).html_safe

      unless options[:p_tags]
        value_to_return = Regexp.new(/\A<p>(.*)<\/p>\Z/m).match(value_to_return)[1] rescue value_to_return
      end
    else
      value_to_return = value_to_return.html_safe
    end
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

    page_element_link =
      PageElementLink
        .create_with(text: default_text, link: default_link)
        .find_or_create_by(key: key, web_page_id: page_id)

    value_to_return = link_to(page_element_link.text, page_element_link.link, options)

    if user_signed_in?
      value_to_return += " "
      value_to_return +=
        link_to('Edit', edit_page_element_link_path(page_element_link), class: 'edit-page-element')
    end

    value_to_return.html_safe
  end

  def edit_setting(key)
    setting = Setting.find_by(key: key)
    value_to_return = setting.value

    if user_signed_in?
      value_to_return += link_to('Edit', edit_setting_path(setting), class: 'edit-page-element')
    end

    value_to_return.html_safe
  end
end
