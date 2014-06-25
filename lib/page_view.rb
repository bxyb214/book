require 'roo'
def set_page_view
	s = Roo::Excelx.new("#{Rails.root}/lib/page_view.xlsx")  # loads an Excel Spreadsheet for Excel .xlsx files


	s.default_sheet = s.sheets.first

	id_pv = {}

	s.each do |id, value|


		topic = Topic.find id.to_i rescue nil

		if topic

			# impressions_count is counter_cache column, so should use update_counters method

			Topic.update_counters id, impressions_count: value.to_i

		end

	end
end



