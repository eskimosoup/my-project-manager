module ApplicationHelper
  def format_area(area)
    "#{area}m<sup>2</sup>".html_safe
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

  def invoice_nav_classes(controller_name)
    'current' if controller_name == params[:controller]
  end

  # http://stackoverflow.com/a/926092
  def archive_dates
    date = Date.new(2016, 04, 01)
    laterdate = Date.today

    dates = []

    (date.year..laterdate.year).each do |y|
      mo_start = (date.year == y) ? date.month : 1
      mo_end = (laterdate.year == y) ? laterdate.month : 12

      (mo_start..mo_end).each do |m|
        dates << Date.new(y, m, 01)
      end
    end
    dates
  end
end
