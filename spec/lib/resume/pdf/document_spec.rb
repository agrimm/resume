require 'spec_helper'
require 'resume/cli/resume_data_fetcher'
require 'resume/pdf/document'

module Resume
  module PDF
    RSpec.describe Document do
      # Suppress output from the ResumeDataFetcher
      before do
        # Use the en locale to test document generation since it
        # requires the least amount of outside dependencies
        allow(I18n).to receive(:locale).and_return(:en)
        allow(Output).to \
          receive(:plain).with(:gathering_resume_information)
      end

      describe '.generate' do
        let!(:resume) { CLI::ResumeDataFetcher.fetch }
        let(:title) { 'My Resume' }
        let(:filename) { 'My_Resume.pdf' }

        after { File.delete(filename) }

        it 'generates a pdf resume with progress notifications' do
          expect(Output).to \
            receive(:plain).with(:creating_social_media_links)
          expect(Output).to \
            receive(:plain).with(:creating_technical_skills_section)
          expect(Output).to \
            receive(:plain).with(:creating_employment_history_section)
          expect(Output).to \
            receive(:plain).with(:creating_education_history_section)
          described_class.generate(resume, title, filename)
          expect(File.exist?(filename)).to be true
        end
      end
    end
  end
end
