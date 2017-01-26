class Product < ApplicationRecord
	def self.search(search)
	  if search
	    where('title LIKE ?', "%#{search}%", title.downcase)
	  else
	    all
	  end
	end
end
