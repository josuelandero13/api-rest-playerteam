class Api::PlayersController < ApplicationController
  before_action :authorize_request, only: [ :destroy ]
  before_action :player, only: [ :show, :update, :destroy ]

  def index
    render json: Player.all.as_json(
      include: {
        player_skills: { except: [ :created_at, :updated_at ] }
      },
      except: [ :created_at, :updated_at ]
    ), status_code: :ok
  end

  def show
    if player.present?
      render json: player.as_json(
        include: {
          player_skills: { only: [ :id, :skill_name, :value, :player_id ] }
        },
        only: [ :id, :name, :position ]
      )
    else
      render json: { error: "Player not found" }, status: :not_found
    end
  end

  def create
    player = Player.new(player_params)

    if player.save
      render json: player.as_json(
        include: {
          player_skills: { only: [ :id, :skill_name, :value, :player_id ] }
        },
        only: [ :id, :name, :position ]
      ), status: :created
    else
      render json: player.errors.messages, status: :unprocessable_entity
    end
  end

  def update
    if player.update(player_params)
      render json: player.as_json(
        include: {
          player_skills: {
            only: [ :id, :skill_name, :value, :player_id ]
          }
        },
        only: [ :id, :name, :position ]
      ), status: :ok
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if player
      player.destroy!
      render json: { message: "Player deleted" }, status: :ok
    else
      render json: { error: "Player not found" }, status: :not_found
    end
  end

  private

  def player_params
    params.require(:player).permit(
      :id, :name, :position,
      player_skills_attributes: [
        :id, :skill_name, :value, :player_id
      ]
    )
  end

  def player
    return if params[:id].blank?

    Player.find(params[:id])
  end

  def authorize_request
    token = request.headers["Authorization"]&.split(" ")&.last

    render json: { error: "Unauthorized" }, status: :unauthorized unless valid_token?(token)
  end

  def valid_token?(token)
    secure_token = Rails.application.credentials.dig(:api, :bearer_token)

    ActiveSupport::SecurityUtils.secure_compare(token.to_s, secure_token.to_s)
  end
end
