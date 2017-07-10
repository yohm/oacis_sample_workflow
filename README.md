# A sample of workflow management using OACIS

This is a sample of workflow consists of several simulators.
We define the following workflow as an example.
The above workflows are executed concurrently for different input parameters.

```txt
step1
  |
step2
  |
step3             # including retries at error cases
  |----------|
step4-1   step4-2
  |          |
  |----------|
step5             # executed if a condition is satisfied
```


## Prerequisites

Run the following commands to register simulators used in this sample on your OACIS.

```
export OACIS_ROOT=/path/to/your/oacis              # change the path to yours
${OACIS_ROOT}/bin/oacis_ruby prepare_simulators.rb
```

After running the command, you'll find the following simulators registered on your OACIS.

- workflow\_sample\_step1
- workflow\_sample\_step2
- workflow\_sample\_step3
- workflow\_sample\_step4\_1
- workflow\_sample\_step4\_2
- workflow\_sample\_step5

Run the following command if you want to delete the registered sample simulators.

```
${OACIS_ROOT}/bin/oacis_ruby delete_simulators.rb
```

# How to run

There are two scripts written in Ruby and Python. You can use either one of them.

```sh
${OACIS_ROOT}/bin/oacis_ruby workflow_sample.rb
```

or 

```sh
${OACIS_ROOT}/bin/oacis_python workflow_sample.py
```

# LICENSE

The MIT License (MIT)

Copyright (c) 2017 RIKEN, AICS

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
