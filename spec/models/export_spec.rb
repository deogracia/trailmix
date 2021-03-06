describe Export do
  describe "#filename" do
    it "includes today's date" do
      Timecop.freeze(Time.utc(2014, 1, 2)) do
        export = Export.new(double(:user))

        filename = export.filename

        expect(filename).to eq("trailmix-2014-01-02.json")
      end
    end
  end

  describe "#to_json" do
    it "returns the user's entries as json" do
      today = Time.utc(2014, 2, 3)
      user = build_stubbed(:user, entries: [
        build_stubbed(:entry, body: "first entry", date: today),
        build_stubbed(:entry, body: "second entry", date: today + 1.day)
      ])

      export = Export.new(user)

      expect(export.to_json).to eq('[' +
        '{"body":"first entry","date":"2014-02-03"},' +
        '{"body":"second entry","date":"2014-02-04"}' +
      ']')
    end
  end
end
