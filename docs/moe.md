# **MOE: Metric Optimization Engine** Terminal.com Snapshot

*A global, black box optimization engine for real world metric optimization.*

---

## About MOE

**MOE** (Metric Optimization Engine) is an efficient way to optimize a system's parameters, when evaluating parameters is time-consuming or expensive.

---

## Application Examples

- **Optimizing a system's click-through rate (CTR).**  MOE is useful when evaluating CTR requires running an A/B test on real user traffic, and getting statistically significant results requires running this test for a substantial amount of time (hours, days, or even weeks).

- **Optimizing tunable parameters of a machine-learning prediction method.**  MOE is useful if calculating the prediction error for one choice of the parameters takes a long time, which might happen because the prediction method is complex and takes a long time to train, or because the data used to evaluate the error is huge.

- **Optimizing the design of an engineering system** (an airplane, the traffic network in a city, a combustion engine, a hospital).  MOE is useful if evaluating a design requires running a complex physics-based numerical simulation on a supercomputer.

- **Optimizing the parameters of a real-world experiment** (a chemistry, biology, or physics experiment, a drug trial).  MOE is useful when every experiment needs to be physically created in a lab, or very few experiments can be run in parallel.

### MOE does this internally by:

1. Building a Gaussian Process (GP) with the historical data.
2. Optimizing the hyperparameters of the Gaussian Process (model selection)
3. Finding the points of highest Expected Improvement (EI)
4. Returning the points to sample, then repeat.

---

## Usage

Just spin up a new Terminal based on this snapshot. MOE libraries are already installed.
Access the MOE demo page by clicking at "MOE Demo App"

For information about libraries usage please check the Documentation section.

---

![1](http://i.imgur.com/L9HcTQg.png)

---

## Documentation

- [Full Online Documentation](http://yelp.github.io/MOE/)
- [Rest Endpoint Documentation](http://yelp.github.io/MOE/moe.views.rest.html)
- [GitHub Repo](http://github.com/Yelp/MOE/)

---

### Snapshot Bootstrap Script

This snapshot was created from a [base snapshot](https://www.terminal.com/tiny/FzpHiTXG1K) by executing:
`wget https://raw.githubusercontent.com/terminalcloud/apps/master/MOE_installer.sh && bash MOE_installer.sh`

---

#### Thanks for using MOE at Terminal.com!
