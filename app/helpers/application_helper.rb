module ApplicationHelper
  def language_switch
    if I18n.locale == :en
      link_to 'Switch to Chinese', url_for(locale: 'zh-CN')
    # link_to 'Switch to Chinese', request.original_fullpath, locale: 'zh-CN'
    else
      link_to 'Switch to English', url_for(locale: 'en')
    # link_to 'Switch to English', request.original_fullpath, locale: 'en'
    end
  end

  def language_chooser
    langs = [
      ['English',         'en'],
      ["Chinese".html_safe,  'zh-CN']
    ]
    form_tag url_for, method: :get, class: 'locale' do
      select_tag 'locale', options_for_select(langs, I18n.locale.to_s), onchange: 'this.form.submit()'
      submit_tag 'submit'
      javascript_tag "$('.locale input').hide()"
    end
  end

  def flash_messages!
    html = ""
    flash.each do |name, msg|
      if msg.is_a? String
      # message = content_tag :div, msg, :id => "flash_#{name}"
        msgclass = "fade in alert alert-#{name == :notice ? 'success' : 'danger'}"
        html += <<-HTML
        <div class="#{msgclass}">
          <button type="button" class="close" data-dismiss="alert">&times;</button>
          <div id="flash_#{name}">#{msg}</div>
        </div>
        HTML
      end
    end
    html.html_safe
  end

  def form_error_messages!(object)
    return "" if object.errors.empty?

    messages = object.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.template.header",
                      count: object.errors.count,
                      model: object.class.model_name.human.downcase)
    bodyhead = I18n.t("errors.template.body")

    html = <<-HTML
    <div id="error_explanation">
      <h2>#{sentence}</h2>
      <p>#{bodyhead}</p>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end
end
