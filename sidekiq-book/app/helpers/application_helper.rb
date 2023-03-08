module ApplicationHelper
  def label_showing_errors(f,field,record,css_class=nil,label_override=nil)
    label_css = begin
                  css = [css_class].compact
                  if record.errors[field].any?
                    css << "text-red-800"
                    css << "font-semibold"
                  else
                    css << "font-medium"
                  end
                  css.join(" ")
                end
    f.label field, (label_override || field.to_s.humanize), class: label_css
  end
end