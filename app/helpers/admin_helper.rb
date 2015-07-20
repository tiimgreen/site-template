module AdminHelper
  include ActionView::Helpers::UrlHelper

  # Text
  def edit_text(
    page,
    key,
    default_text = 'Lorem ipsum dolor sit amet domo, consectetur adipisicing elit.',
    options = {}
  )
    key += "_#{I18n.locale.to_s}" if Rails.configuration.i18n_used
    page_id = key.start_with?('global') ? 0 : page.id
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                        autolink: true,
                                        space_after_headers: true,
                                        prettify: true)

    page_element =
      PageElementText.create_with(value: default_text).find_or_create_by(key: key, web_page_id: page_id)

    value_to_return = page_element.value

    if user_signed_in?
      value_to_return += " "
      value_to_return +=
        link_to(
          'Edit',
          edit_page_element_text_path(
            page_element,
            markdown: !options.has_key?(:render_markdown) || options[:render_markdown]
          ),
          class: 'edit-page-element'
        )
    end

    if !options.has_key?(:render_markdown) || options[:render_markdown]

      value_to_return = @markdown.render(value_to_return).html_safe

      if options.has_key?(:p_tags) && !options[:p_tags]
        value_to_return = Regexp.new(/\A<p>(.*)<\/p>\Z/m).match(value_to_return)[1] rescue value_to_return
      end
    end

    value_to_return.html_safe
  end

  def read_text(
    page,
    key,
    default = ''
  )
    key += "_#{I18n.locale}" if Rails.configuration.i18n_used
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
    key += "_#{I18n.locale}" if Rails.configuration.i18n_used
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
    key += "_#{I18n.locale}" if Rails.configuration.i18n_used
    setting = Setting.find_by(key: key)
    value_to_return = setting.value

    if user_signed_in?
      value_to_return += link_to('Edit', edit_setting_path(setting), class: 'edit-page-element')
    end

    value_to_return.html_safe
  end
end
