class Product < ApplicationRecord
	def self.search(search)
	  if search
	    where('lower(title) LIKE ?', "%#{search.downcase}%")
	  else
	    all
	  end
	end
end
