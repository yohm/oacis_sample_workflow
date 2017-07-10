LOCALHOST = Host.find_by_name("localhost")

def step1(param)
  sim = Simulator.find_by_name("workflow_sample_step1")
  ps = sim.find_or_create_parameter_set( {"p1"=>param} )
  runs = ps.find_or_create_runs_upto( 1, submitted_to: LOCALHOST)
  OacisWatcher.await_ps(ps)
  ps.runs.first.result["r"]
end

def step2(param)
  sim = Simulator.find_by_name("workflow_sample_step2")
  ps = sim.find_or_create_parameter_set( {"p1"=>param} )
  runs = ps.find_or_create_runs_upto( 1, submitted_to: LOCALHOST)
  OacisWatcher.await_ps(ps)
  ps.runs.first.result["r"]
end

def step3(param)
  sim = Simulator.find_by_name("workflow_sample_step3")
  result = nil

  # retry until result%3 == 0
  3.times do |t|  # retry three times
    ps = sim.find_or_create_parameter_set( {"p1"=>param} )
    runs = ps.find_or_create_runs_upto( 1, submitted_to: LOCALHOST)
    OacisWatcher.await_ps(ps)
    result = ps.runs.first.result["r"]
    if _result_is_okay?(result)
      break
    else
      param = _generate_next_param(param)
    end
  end
  result
end

def _result_is_okay?(r)
  r.to_i % 3 == 0
end

def _generate_next_param(param)
  param + 1.0
end

def step4(param)
  # create a Run for the first simulator
  sim1 = Simulator.find_by_name("workflow_sample_step4_1")
  ps1 = sim1.find_or_create_parameter_set( {"p1"=>param} )
  ps1.find_or_create_runs_upto( 1, submitted_to: LOCALHOST)

  # create a Run for the second simulator
  sim2 = Simulator.find_by_name("workflow_sample_step4_2")
  ps2 = sim2.find_or_create_parameter_set( {"p1"=>param} )
  ps2.find_or_create_runs_upto( 1, submitted_to: LOCALHOST)

  OacisWatcher.await_all_ps( [ps1,ps2] )
  result = ps1.runs.first.result["r"] + ps2.runs.first.result["r"]
  result
end

def step5(param)
  if param.to_i % 10000 == 0   # execute step5 only if the condition is satisfied
    sim = Simulator.find_by_name("workflow_sample_step5")
    ps = sim.find_or_create_parameter_set( {"p1"=>param} )
    ps.find_or_create_runs_upto( 1, submitted_to: LOCALHOST)
    OacisWatcher.await_ps(ps)
    ps.runs.first.result["r"]
  else
    param
  end
end


OacisWatcher::start do |w|
  input_params = [1.0, 2.0, 3.0]
  input_params.each do |input|
    w.async {
      r1 = step1(input)    # => 10.0, 20.0, 30.0
      r2 = step2(r1)       # => 100.0, 200.0, 300.0
      r3 = step3(r2)       # => 1020.0, 2010.0, 3000.0
      r4 = step4(r3)       # => 20400.0, 40200.0, 60000.0
      r5 = step5(r4)       # => 20400.0, 40200.0, 600000.0
      p r5
    }
  end
end

