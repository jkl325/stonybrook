class FixBadPositionData < ActiveRecord::Migration[5.2]
  using_group(:shards)

  class VisitGroup < ApplicationRecord
    belongs_to :arm
  end

  def change
    bar = ProgressBar.new(Arm.count)
    Arm.find_each do |arm|
      index = 1
      arm.visit_groups.order(:day).each do |visit_group|
        visit_group.update_attribute(:position, index)
        index += 1
      end
      bar.increment!
    end
  end
end
