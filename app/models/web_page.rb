class WebPage < ActiveRecord::Base
  has_many :page_element_links
  has_many :page_element_texts
end
