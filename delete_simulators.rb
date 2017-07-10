
def make_sample_simulator( sim_name )
  sim = Simulator.find_by_name(sim_name)
  if sim
    sim.discard
  else
    $stderr.puts "Simulator #{sim_name} is not found."
  end
end

%w(workflow_sample_step1 workflow_sample_step2 workflow_sample_step3 workflow_sample_step4_1 workflow_sample_step4_2 workflow_sample_step5).each do |sim_name|
  make_sample_simulator(sim_name)
end

