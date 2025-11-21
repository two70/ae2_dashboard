class ItemsController < ApplicationController
  # protect_from_forgery with: :null_session  # for API posts

  def index
    render json: Item.all
  end

  def create
    items = JSON.parse(request.body.read)

    created = 0
    updated = 0

    Item.transaction do
      items.each do |item|
        next unless item["name"].present?

        rec = Item.find_or_initialize_by(name: item["name"])
        old_amount = rec.amount
        rec.display_name = item["displayName"]
        rec.amount = item["amount"]
        rec.nbt = item["nbt"]

        if rec.new_record?
          rec.save!
          Rails.logger.info("Created item: #{rec.name} display_name=#{rec.display_name}, amount=#{rec.amount}")
          created += 1
        else
          if rec.changed?
            rec.save!
            Rails.logger.info("Updated item: #{rec.name} display_name=#{rec.display_name}, from #{old_amount} to #{rec.amount}")
            updated += 1
          end
        end
      end
    end

    render json: { status: "ok", created: created, updated: updated, total: Item.count }
  end
end
