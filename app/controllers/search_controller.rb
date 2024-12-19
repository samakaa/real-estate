class SearchController < ApplicationController
  def index
    @properties = Property.all

    # Filter by status
    if params[:status].present?
      @properties = @properties.where(status: params[:status])
    end
  # Filter by price range
    if params[:min_price].present? && params[:max_price].present?
      @properties = @properties.where(price: params[:min_price].to_i..params[:max_price].to_i)
    end

    # Filter by address
    if params[:address].present?
      @properties = @properties.where("address ILIKE ?", "%#{params[:address]}%")
    end

    # Filter by address
    if params[:price].present?
      @properties = @properties.where("price ILIKE ?", "%#{params[:price]}%")
    end

    # Filter by title (if present)
    if params[:title].present?
      @properties = @properties.where("title ILIKE ?", "%#{params[:title]}%")
    end

    # If no matching results, @properties will be empty
  end
end
