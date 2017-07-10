
def make_sample_simulator( sim_name )
  if sim = Simulator.where(name: sim_name).exists?
    $stderr.puts "already Simulator '#{sim_name}' exists. Delete this before running this script."
    raise "Simulator already exists"
  end

  sim = Simulator.create!(
    name: sim_name,
    parameter_definitions: [
      ParameterDefinition.new(key: "p1", type: "Float", default: 0.0),
    ],
    command: "ruby -r json -e 'r=JSON.load(File.open(\"_input.json\"))[\"p1\"]*10.0; puts({\"r\"=>r}.to_json)' > _output.json",
    executable_on: [Host.find_by_name("localhost")]
  )
  $stderr.puts "A new simulator #{sim.id} is created."
end

%w(workflow_sample_step1 workflow_sample_step2 workflow_sample_step3 workflow_sample_step4_1 workflow_sample_step4_2 workflow_sample_step5).each do |sim_name|
  make_sample_simulator(sim_name)
end

