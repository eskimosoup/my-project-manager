module ApplicationHelper
  def format_area(area)
    "#{ area }m<sup>2</sup>".html_safe
  end
  
  def octicon(code)
    content_tag :span, '', class: "octicon octicon-#{code.to_s.dasherize}"
  end

  def present(object, klass = nil)
    klass ||= "#{object.class}Presenter".constantize if object.present?
    presenter = klass.new(object: object, view_template: self)
    yield presenter if block_given?
    presenter
  end

  def collection_presenter(object, klass = nil)
    klass ||= "#{object.first.class}Presenter".constantize if object.present?
    BaseCollectionPresenter.new(collection: object, view_template: self, presenter: klass)
  end
end
