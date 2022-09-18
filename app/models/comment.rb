# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  after_create_commit -> { broadcast_append_to_post }
  after_destroy_commit -> { broadcast_remove_to post }
  after_update_commit -> { broadcast_update_to_post }

  def broadcast_append_to_post
    broadcast_append_to(self, locals: { current_user: user, post: post })
  end

  def broadcast_update_to_post
    broadcast_update_to(self, locals: { current_user: user, post: post })
  end
end
