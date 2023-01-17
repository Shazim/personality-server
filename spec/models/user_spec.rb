require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    shared_examples_for 'a valid user' do
      subject { user }
      it { should be_valid }
    end

    context 'when email is valid' do
      it { should validate_presence_of(:email) }
      it { should validate_uniqueness_of(:email).case_insensitive }
      

      let(:user) { create(:user, user_attributes) }
      let(:user_attributes) { {} }

      describe 'when email has valid format' do
        context 'long top level domain' do
          let(:user_attributes) { {email: 'test@place.online'} }

          it_behaves_like 'a valid user'
        end

        context 'short top level domain' do
          let(:user_attributes) { {email: 'test@place.co'} }

          it_behaves_like 'a valid user'
        end

        context 'dashes in domain' do
          let(:user_attributes) { {email: 'test@dash-company.com'} }

          it_behaves_like 'a valid user'
        end

        context 'underscore followed by other letters' do
          let(:user_attributes) { {email: 'test_email@place.com'} }

          it_behaves_like 'a valid user'
        end

        context 'period followed by other letters' do
          let(:user_attributes) { {email: 'test.email@place.com'} }

          it_behaves_like 'a valid user'
        end

        context 'dash followed by other letters' do
          let(:user_attributes) { {email: 'test-email@place.com'} }

          it_behaves_like 'a valid user'
        end

        context 'plus followed by other letters' do
          let(:user_attributes) { {email: 'test+email@place.com'} }

          it_behaves_like 'a valid user'
        end

        context 'email contains capitals' do
          let(:user_attributes) { {email: 'TestEmail@place.com'} }

          it_behaves_like 'a valid user'
        end
      end

      shared_examples_for 'invalid email format' do
        it 'should add invalid format error' do
          expect(user).not_to be_valid
          expect(user.errors.count).to be 1
          expect(user.errors[:email].include?(I18n.t('errors.user.email.invalid_format'))).to be true
        end
      end

      describe 'when email has invalid format' do
        context 'too short top level domain' do
          let(:user_attributes) { {email: 'test@company.t'} }

          include_examples 'invalid email format'
        end

        describe 'invalid characters in email domain' do
          context 'exclamation point' do
            let(:user_attributes) { {email: 'test@cool!company.com'} }

            include_examples 'invalid email format'
          end

          context 'asperand' do
            let(:user_attributes) { {email: 'test@cool@company.com'} }

            include_examples 'invalid email format'
          end

          context 'pound sign' do
            let(:user_attributes) { {email: 'test@cool#company.com'} }

            include_examples 'invalid email format'
          end

          context 'dollar sign' do
            let(:user_attributes) { {email: 'test@cool$company.com'} }

            include_examples 'invalid email format'
          end

          context 'percent' do
            let(:user_attributes) { {email: 'test@cool%company.com'} }

            include_examples 'invalid email format'
          end

          context 'caret' do
            let(:user_attributes) { {email: 'test@cool^company.com'} }

            include_examples 'invalid email format'
          end

          context 'ampersand' do
            let(:user_attributes) { {email: 'test@cool&company.com'} }

            include_examples 'invalid email format'
          end

          context 'asterisk' do
            let(:user_attributes) { {email: 'test@cool*company.com'} }

            include_examples 'invalid email format'
          end

          context 'parentheses' do
            let(:user_attributes) { {email: 'test@cool()company.com'} }

            include_examples 'invalid email format'
          end

          context 'plus sign' do
            let(:user_attributes) { {email: 'test@cool+company.com'} }

            include_examples 'invalid email format'
          end
        end
      end
    end

    context 'password' do
      let(:user) { build(:user, user_attributes) }
      let(:user_attributes) { {} }

      context 'when matching password values are present with valid format' do
        let(:user_attributes) { {password: 'Tacocat-123!@#$%^&*', password_confirmation: 'Tacocat-123!@#$%^&*'} }

        it_behaves_like 'a valid user'
      end

      context 'when password values are blank' do
        let(:user_attributes) { {password: '', password_confirmation: ''} }

        it 'should add blank password error' do
          expect(user).not_to be_valid
          expect(user.errors.count).to be 1
          expect(user.errors[:password].include?("can't be blank")).to be true
        end
      end

      context 'when mismatched password values are present with valid format' do
        let(:user_attributes) { {password: 'Tacocat123', password_confirmation: 'Buritodog123'} }

        it 'should add mismatched password field values error' do
          expect(user).not_to be_valid
          expect(user.errors.count).to be 2
          expect(user.errors[:password].include?(I18n.t('errors.user.password.values_do_not_match'))).to be true
          expect(user.errors[:password_confirmation].include?("doesn't match Password")).to be true
        end
      end

      shared_examples_for 'invalid password format' do
        it 'should add invalid format error' do
          expect(user).not_to be_valid
          expect(user.errors.count).to be 1
          expect(user.errors[:password].include?(I18n.t('errors.user.password.invalid_format'))).to be true
        end
      end

      describe 'when matching password values are present with invalid format' do
        context 'too short' do
          let(:user_attributes) { {password: 'Bad123', password_confirmation: 'Bad123'} }

          include_examples 'invalid password format'
        end

        context 'contains invalid space character' do
          let(:user_attributes) { {password: 'Taco 1234', password_confirmation: 'Taco 1234'} }

          include_examples 'invalid password format'
        end

        context 'contains invalid period character' do
          let(:user_attributes) { {password: 'Taco.1234', password_confirmation: 'Taco.1234'} }

          include_examples 'invalid password format'
        end

        context 'has only lowercase letters' do
          let(:user_attributes) { {password: 'weakpass123', password_confirmation: 'weakpass123'} }

          include_examples 'invalid password format'
        end

        context 'has only capital letters' do
          let(:user_attributes) { {password: 'WEAKPASS123', password_confirmation: 'WEAKPASS123'} }

          include_examples 'invalid password format'
        end

        context 'does not have a number' do
          let(:user_attributes) { {password: 'Weakpass', password_confirmation: 'Weakpass'} }

          include_examples 'invalid password format'
        end

        context 'contains only numbers' do
          let(:user_attributes) { {password: '12345678', password_confirmation: '12345678'} }

          include_examples 'invalid password format'
        end
      end
    end
  end
end