#:nodoc:
class Participant < ApplicationRecord
  belongs_to :member
  belongs_to :activity

  validates :notes, length: { maximum: 30 }

  before_destroy :rewrite_logs_before_delete!, prepend: true
  is_impressionable dependent: :nullify

  def price=(price)
    write_attribute(:price, price.to_s.tr(',', '.').to_f) unless price.blank?
    write_attribute(:price, nil) if price.blank?
  end

  def currency
    return activity.price if read_attribute(:price).nil?

    self.price ||= 0
  end

  before_validation do
    self.paid = false if price_changed?
    write_attribute(:price, nil) if activity.price == self.price
  end

  # Update logs before deleting a Participant to keep what happened
  def rewrite_logs_before_delete!
    impressions.each do |i|
      message = if i.action_name == "update"
                  I18n.t i.message, scope: [:activerecord, :attributes, :impression, i.impressionable_type.downcase, i.action_name]
                else
                  I18n.t i.action_name, scope: [:activerecord, :attributes, :impression, i.impressionable_type.downcase]
                end

      i.update(message: "#{ activity.name } (#{ activity.id }) - #{ message }")
    end
  end
end
