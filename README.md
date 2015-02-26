# queue-retry

This repo has three tags that attempt to stabilize and improve the performance of a system that relies on aggregating data from multiple sources in order to produce a final result.

## Tags

### original

The original tag is the system without any improvements whatsoever.

### queue

The queue tag is where we implement a simple queueing system that improves the overall performance of the system by queueing the calls into new threads so they can be called concurrently.

### retry

The retry tag addresses the intermittent failures of external services by implementing a retry feature on the call to the external services.


## Getting Started

1. Clone repo
2. run ```bundle install```
3. run ```rspec```

### Presentation

https://docs.google.com/presentation/d/1gXOtbDcPb-aQ-JqIS-ySvOZbsjZ5K8992O_j1eW7Cw0/edit?usp=sharing
