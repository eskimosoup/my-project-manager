require "rails_helper"

describe StatusChanger::Finalised, type: :model do
  context "successfully changes status" do
    it "changes the status" do
      project = create(:sold_project)
      changer = StatusChanger::Finalised.new(project)
      allow(changer).to receive(:valid?).and_return(true)

      changer.save

      expect(project.reload.status).to eq("finalised")
    end
  end

  it "delegates print jobs to project" do
    project = create(:sold_project)
    changer = StatusChanger::Finalised.new(project)

    expect(changer).to delegate_method(:print_jobs).to(:project) 
  end

  it "setting attr_accessors for each print job" do
    project = create(:sold_project)
    print_jobs = create_list(:sold_print_job, 3, project: project)
    allow(project).to receive(:print_jobs).and_return(print_jobs)

    changer = StatusChanger::Finalised.new(project)
    

    attrs = print_jobs.map{|x| 
      [
        "print_job_#{ x.id }_envisage_sale_price".to_sym,
        "print_job_#{ x.id }_envisage_trade_sale_price".to_sym,
        "print_job_#{ x.id }_envisage_to_my_sale_price".to_sym,
        "print_job_#{ x.id }_my_sale_price".to_sym,
      ]
    }.flatten
    expect(changer.public_methods).to include(*attrs)
  end

  it "sets the default print job prices correctly" do
    project = create(:sold_project)
    print_job = create(:sold_print_job, project: project)
    allow(project).to receive(:print_jobs).and_return([ print_job ])

    changer = StatusChanger::Finalised.new(project)

    expect(changer.public_send("print_job_#{ print_job.id }_envisage_sale_price")).to eq(print_job.envisage_sale_price)
    expect(changer.public_send("print_job_#{ print_job.id }_envisage_trade_sale_price")).to eq(print_job.envisage_trade_sale_price)
    expect(changer.public_send("print_job_#{ print_job.id }_envisage_to_my_sale_price")).to eq(print_job.envisage_to_my_sale_price)
    expect(changer.public_send("print_job_#{ print_job.id }_my_sale_price")).to eq(print_job.my_sale_price)
  end

  it "allows the changed prices to be set over the current print job ones" do
    project = create(:sold_project)
    print_job = create(:sold_print_job, project: project)
    allow(project).to receive(:print_jobs).and_return([ print_job ])

    attrs = {
      "print_job_#{ print_job.id }_envisage_sale_price" => (print_job.envisage_sale_price + 5),
      "print_job_#{ print_job.id }_envisage_trade_sale_price" => (print_job.envisage_trade_sale_price + 5),
      "print_job_#{ print_job.id }_envisage_to_my_sale_price" => (print_job.envisage_to_my_sale_price + 5),
      "print_job_#{ print_job.id }_my_sale_price" => (print_job.my_sale_price + 5),
    }
    changer = StatusChanger::Finalised.new(project, attrs)

    expect(changer.public_send("print_job_#{ print_job.id }_envisage_sale_price")).to eq(print_job.envisage_sale_price + 5)
    expect(changer.public_send("print_job_#{ print_job.id }_envisage_trade_sale_price")).to eq(print_job.envisage_trade_sale_price + 5)
    expect(changer.public_send("print_job_#{ print_job.id }_envisage_to_my_sale_price")).to eq(print_job.envisage_to_my_sale_price + 5)
    expect(changer.public_send("print_job_#{ print_job.id }_my_sale_price")).to eq(print_job.my_sale_price + 5)
  end

  it "sets the print_job prices" do
    project = create(:sold_project)
    print_job = create(:sold_print_job, project: project)
    envisage_sale_price = print_job.envisage_sale_price + 5
    envisage_trade_sale_price = print_job.envisage_trade_sale_price + 5
    envisage_to_my_sale_price = print_job.envisage_to_my_sale_price + 5
    my_sale_price = print_job.my_sale_price + 5

    attrs = {
      "print_job_#{ print_job.id }_envisage_sale_price" => envisage_sale_price,
      "print_job_#{ print_job.id }_envisage_trade_sale_price" => envisage_trade_sale_price,
      "print_job_#{ print_job.id }_envisage_to_my_sale_price" => envisage_to_my_sale_price,
      "print_job_#{ print_job.id }_my_sale_price" => my_sale_price,
    }
    changer = StatusChanger::Finalised.new(project, attrs)
    allow(changer).to receive(:valid?).and_return(true) # I think DB cleaner isn't cleaning db correctly so sometimes has additional print jobs, this doesn't need to check validity here
    changer.save

    expect(print_job.reload.envisage_sale_price).to eq(envisage_sale_price)
    expect(print_job.reload.envisage_trade_sale_price).to eq(envisage_trade_sale_price)
    expect(print_job.reload.envisage_to_my_sale_price).to eq(envisage_to_my_sale_price)
    expect(print_job.reload.my_sale_price).to eq(my_sale_price)
  end

  describe "validations", :validation do
    describe "envisage sale price" do
      it "presence" do
        project = create(:sold_project)
        print_job = create(:sold_print_job, project: project)

        changer = StatusChanger::Finalised.new(project)

        expect(changer).to validate_presence_of("print_job_#{ print_job.id }_envisage_sale_price".to_sym)
      end

      it "numericality" do
        project = create(:sold_project)
        print_job = create(:sold_print_job, project: project)

        changer = StatusChanger::Finalised.new(project)

        expect(changer).to validate_numericality_of("print_job_#{ print_job.id }_envisage_sale_price".to_sym).is_greater_than_or_equal_to(0.0)
      end
    end

    describe "envisage trade sale price" do
      it "presence" do
        project = create(:sold_project)
        print_job = create(:sold_print_job, project: project)

        changer = StatusChanger::Finalised.new(project)

        expect(changer).to validate_presence_of("print_job_#{ print_job.id }_envisage_trade_sale_price".to_sym)
      end

      it "numericality" do
        project = create(:sold_project)
        print_job = create(:sold_print_job, project: project)

        changer = StatusChanger::Finalised.new(project)

        expect(changer).to validate_numericality_of("print_job_#{ print_job.id }_envisage_trade_sale_price".to_sym).is_greater_than_or_equal_to(0.0)
      end
    end

    describe "envisage to my sale price" do
      it "presence" do
        project = create(:sold_project)
        print_job = create(:sold_print_job, project: project)

        changer = StatusChanger::Finalised.new(project)

        expect(changer).to validate_presence_of("print_job_#{ print_job.id }_envisage_to_my_sale_price".to_sym)
      end

      it "numericality" do
        project = create(:sold_project)
        print_job = create(:sold_print_job, project: project)

        changer = StatusChanger::Finalised.new(project)

        expect(changer).to validate_numericality_of("print_job_#{ print_job.id }_envisage_to_my_sale_price".to_sym).is_greater_than_or_equal_to(0.0)
      end
    end

    describe "my sale price" do
      it "presence" do
        project = create(:sold_project)
        print_job = create(:sold_print_job, project: project)

        changer = StatusChanger::Finalised.new(project)

        expect(changer).to validate_presence_of("print_job_#{ print_job.id }_my_sale_price".to_sym)
      end

      it "numericality" do
        project = create(:sold_project)
        print_job = create(:sold_print_job, project: project)

        changer = StatusChanger::Finalised.new(project)

        expect(changer).to validate_numericality_of("print_job_#{ print_job.id }_my_sale_price".to_sym).is_greater_than_or_equal_to(0.0)
      end
    end

  end
end
