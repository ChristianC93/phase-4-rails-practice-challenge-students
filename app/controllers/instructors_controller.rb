class InstructorsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    #GET all instructors
    def index
        instructors = Instructor.all
        render json: instructors
    end

    #GET an instructor by id
    def show
        instructor = Instructor.find_by(id: params[:id])
        render json: instructor
    end

    #POST an instructor
    def create 
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :created
    end

    #UPDATE an instructor
    def update
        instructor = Instructor.find_by(id: params[:id])
        instructor.update!(instructor_params)
        render json: instructor, status: :created
    end

    #DELETE an instructor
    def destroy
        instructor = Instructor.find_by(id: params[:id])
        instructor.destroy
    end

    private

    def instructor_params
        params.permit(:name)
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
end
