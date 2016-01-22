module Features
  def quoted_print_job
    instance_double("print_job").tap do |print_job|
      allow(print_job).to receive(:quoted?).and_return(true)
    end
  end

  def not_quoted_print_job
    instance_double("print_job").tap do |print_job|
      allow(print_job).to receive(:quoted?).and_return(false)
    end
  end
end
