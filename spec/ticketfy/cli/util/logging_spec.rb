require 'spec_helper'

describe Ticketfy::Cli::Util::Logging do
  let(:klass) { Class.new { include Ticketfy::Cli::Util::Logging } }
  subject { klass.new }
  before { Ticketfy::Cli::Util::Logging.level = Logger::INFO }

  describe '#info' do
    it do
      expect(subject.logger).to receive(:info)

      subject.info 'An info message'
    end

    context 'when quiet!' do
      before { subject.quiet! }

      it do
        expect(subject.logger).to_not receive(:info)
        subject.info 'An info message'
      end
    end
  end

  describe '#success' do
    it do
      expect(subject.logger).to receive(:info)

      subject.success 'A success message'
    end

    context 'when quiet!' do
      before { subject.quiet! }

      it do
        expect(subject.logger).to_not receive(:success)
        subject.success 'An success message'
      end
    end
  end

  describe '#error' do
    it do
      expect(subject.logger).to receive(:error)

      subject.error 'An error message'
    end

    context 'when a exception is given' do
      let(:error) { double('error', message: 'Hey!', backtrace: ['No', 'way!']) }

      it 'logs an error messsage with details' do
        subject.error 'An error message', e: error
      end
    end

    context 'when quiet!' do
      before { subject.quiet! }

      it do
        expect(subject.logger).to_not receive(:error)
        subject.error 'An error message'
      end
    end
  end

  describe '#warning' do
    it do
      expect(subject.logger).to receive(:error)

      subject.warning 'A warning message'
    end

    context 'when quiet!' do
      before { subject.quiet! }

      it do
        expect(subject.logger).to_not receive(:error)
        subject.error 'An error message'
      end
    end
  end

  describe '#alert' do
    context 'when type is `info`' do
      it do
        expect(subject).to receive(:info)

        subject.alert 'An info alert', type: :info
      end
    end

    context 'when type is `warning`' do
      it do
        expect(subject).to receive(:warning)

        subject.alert 'A warning alert', type: :warning
      end
    end
  end
end
