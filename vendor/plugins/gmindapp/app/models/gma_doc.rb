class GmaDoc < ActiveRecord::Base
  belongs_to :gma_runseq
  belongs_to :gma_service
  belongs_to :gma_user
end
