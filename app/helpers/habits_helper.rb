module HabitsHelper
  def badge(label:, color:, icon:)
    content_tag(:span, "#{icon} #{label}",
      class: "inline-block px-2 py-1 rounded text-xs font-medium bg-#{color}-100 text-#{color}-800"
    )
  end
end
