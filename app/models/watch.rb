  class Watch < ApplicationRecord
  belongs_to :user
  belongs_to :auction

  validates :auction_id, presence:true,uniqueness:{scope: :user_id}

  
end
