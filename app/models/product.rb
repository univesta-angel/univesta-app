class Product < ApplicationRecord
	def self.search(searchprd)
	  if searchprd
	    where('lower(title) LIKE ?', "%#{searchprd.downcase}%")
	  else
	    all
	  end
	end
end
