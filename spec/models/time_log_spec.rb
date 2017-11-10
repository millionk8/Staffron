require 'rails_helper'

describe TimeLog do

  before do
    @time_log = create(:time_log)
  end

  subject { @time_log }

  it { should respond_to(:user) }
  it { should respond_to(:category) }
  it { should respond_to(:started_at) }
  it { should respond_to(:stopped_at) }
  it { should respond_to(:deleted) }
  it { should respond_to(:deleted_at) }

  # Test validators
  context 'Test validators' do

    context 'presence' do
      describe 'when user is not present' do
        before { @time_log.user_id = nil }
        it { should_not be_valid }
      end
      describe 'when category is not present' do
        before { @time_log.category_id = nil }
        it { should_not be_valid }
      end
    end

    context 'check_in_future' do
      describe 'when started_at is in the future' do
        before { @time_log.started_at = Time.current + 5.minutes }
        it { should_not be_valid }
      end
      describe 'when started_at is in the past' do
        before { @time_log.started_at = Time.current - 5.minutes }
        it { should be_valid }
      end
      describe 'when stopped_at is in the past' do
        before { @time_log.stopped_at = Time.current - 5.minutes }
        it { should be_valid }
      end

      context 'check_valid_dates' do
        describe 'when started_at is after stopped_at' do
          before { @time_log.started_at = @time_log.stopped_at + 5.minutes }
          it { should_not be_valid }
        end
        describe 'when started_at is before stopped_at' do
          before { @time_log.started_at = @time_log.stopped_at - 5.minutes }
          it { should be_valid }
        end
        describe 'when longer than 24 hours' do
          before { @time_log.started_at = @time_log.stopped_at - 25.hours }
          it { should_not be_valid }
        end
        describe 'when longer than 24 hours' do
          before { @time_log.started_at = @time_log.stopped_at - 23.hours }
          it { should be_valid }
        end
      end
    end

    context 'check_overlap' do
      describe 'when start_at is overlapping' do
        before do
          @time_log.started_at = Time.current - 2.hours
          @time_log.stopped_at = Time.current - 30.minutes
          @time_log.save
          @new_time_log = build(:time_log, started_at: Time.current - 1.hour, stopped_at: Time.current)
        end

        it 'should not save new time log' do
          expect(@new_time_log.valid?).to eq(false)
          expect(@new_time_log.errors[:base].size).to eq(1)
        end
      end
      describe 'when stopped_at is overlapping' do
        before do
          @time_log.started_at = Time.current - 2.hours
          @time_log.stopped_at = Time.current - 30.minutes
          @time_log.save
          @new_time_log = build(:time_log, started_at: Time.current - 45.minutes, stopped_at: Time.current)
        end

        it 'should not save new time log' do
          expect(@new_time_log.valid?).to eq(false)
          expect(@new_time_log.errors[:base].size).to eq(1)
        end
      end
      describe 'when started_at and stopped_at are overlapping' do
        before do
          @time_log.started_at = Time.current - 2.hours
          @time_log.stopped_at = Time.current - 30.minutes
          @time_log.save
          @new_time_log = build(:time_log, started_at: Time.current - 3.hours, stopped_at: Time.current)
        end

        it 'should not save new time log' do
          expect(@new_time_log.valid?).to eq(false)
          expect(@new_time_log.errors[:base].size).to eq(1)
        end
      end
      describe 'when inside of existing time log' do
        before do
          @time_log.started_at = Time.current - 2.hours
          @time_log.stopped_at = Time.current
          @time_log.save
          @new_time_log = build(:time_log, started_at: Time.current - 1.hour, stopped_at: Time.current - 30.minutes)
        end

        it 'should not save new time log' do
          expect(@new_time_log.valid?).to eq(false)
          expect(@new_time_log.errors[:base].size).to eq(1)
        end
      end
      describe 'when before existing time log' do
        before do
          @time_log.started_at = Time.current - 2.hours
          @time_log.stopped_at = Time.current
          @time_log.save
          @new_time_log = build(:time_log, started_at: Time.current - 3.hour, stopped_at: Time.current - 121.minutes)
        end

        it 'should not save new time log' do
          expect(@new_time_log.valid?).to eq(true)
          expect(@new_time_log.errors[:base].size).to eq(0)
        end
      end
      describe 'when after existing time log' do
        before do
          @time_log.started_at = Time.current - 2.hours
          @time_log.stopped_at = Time.current - 1.hour
          @time_log.save
          @new_time_log = build(:time_log, started_at: Time.current - 59.minutes, stopped_at: Time.current)
        end

        it 'should not save new time log' do
          expect(@new_time_log.valid?).to eq(true)
          expect(@new_time_log.errors[:base].size).to eq(0)
        end
      end
    end
  end

end