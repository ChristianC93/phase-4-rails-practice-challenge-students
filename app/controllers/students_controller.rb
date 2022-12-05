class StudentsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    #GET all students
    def index
        students = Student.all
        render json: students 
    end

    #GET a student
    def show
        student = Student.find_by(id: params[:id])
        render json: student
    end

    #POST a student
    def create
        student = Student.create!(student_params)
        render json: student
    end

    #UPDATE a student
    def update
        student = Student.find_by(id: params[:id])
        student.update!(student_params)
        render json: student, status: :created
    end

    #DELETE student
    def destroy
        student = Student.find_by(id: params[:id])
        student.destroy
    end


    private

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
end
