module ApplicationHelper
	def display_error_message(errors, field_name, display_name = nil, no_name = false)
		html = ""
		if errors.present?
			field_name = field_name.to_sym
			display_name = display_name.present? ? display_name : field_name.capitalize
			if errors["bank_errors"].present? && errors[field_name].present?
				html = "<span class='text-red'>#{errors[field_name].join(',')}</span>".html_safe
			elsif errors[field_name].present? && no_name
        html = "<span class='text-red'>#{errors[field_name].join(',')}</span>".html_safe
      elsif errors[field_name].present?
				html = "<span class='text-red'>#{display_name} #{errors[field_name].join(',')}</span>".html_safe
			end
		end
		html
	end
end
