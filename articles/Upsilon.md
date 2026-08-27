# Forced Bionomics with Lags

In delay differential equations describing mosquito infection dynamics,
we are faced with the challenge of dealing with time-varying mosquito
bionomic parameters, including a time-varying EIP. In particular, we
must compute \\\Upsilon(t),\\ the fraction of mosquitoes that survived
to become infectious at time \\t.\\

In the following, we explain the mathematics and the
[SimBA](https://faculty.washington.edu/smitdave/simba/) algorithm for
computing mosquito survival and dispersal through a time-varying EIP.

## The EIP

To describe the dynamics of infection in mosquitoes, we must take some
care in defining a time varying parasite latent period, traditionally
called the extrinsic incubation period (EIP) If the lag varies with
time, *e.g.*, if it is a function of temperature, then we need notation
for the lag computed with respect to the moment when a mosquito becomes
*infected* and when it becomes *infectious*. Here, we must define the
EIP with respect to both:

- Let \\\tau(t)\\ denote the delay counting from the moment a mosquito
  becomes *infected*: a mosquito becoming infected at time \\t\\ would
  become infectious at time \\t+\tau(t).\\

- Let \\\tau'(t)\\ denote the lag for a mosquito at the point in time
  when it becomes infectious: a mosquito becoming infectious at time
  \\t\\ would have become infected at time \\t-\tau'(t).\\

The two are related by the identities \\\tau(t) = \tau'(t+\tau(t))\\ and
\\\tau'(t) = \tau(t-\tau'(t)).\\

## The Demographic Matrix

The demographic matrix, \\\Omega\\ includes all the parameters affecting
mosquito survival and dispersal:

- \\g(t)\\ is the patch mortality rate of adult mosquitoes;

- \\\sigma(t)\\ the patch emigration rate;

- \\\mu(t)\\ the loss associated with emigration (including emigration
  related mortality and emigration out of the system); and

- \\K(t)\\ is the dispersal matrix.

After leaving a patch, the proportion surviving dispersal (\\1-\mu(t)\\)
that end up in every other patch is given by a kernel, \\K(t).\\

\\\Omega(t) = g(t) + \sigma (1-\mu(t)) \cdot K(t).\\

In a delay differential equation, we must compute survival and dispersal
through the EIP, \\\Upsilon(t)\\. If all the parameters were constant,
and \\\tau(t)=n,\\ then we would need to compute:

\\ \Upsilon = e^{-\gamma} \\

where

\\\gamma = \int\_{t-\tau'(t)}^t \Omega(s) ds\\

## Upsilon

To motivate the algorithm used to compute it, we introduce a new
variable, \\G\\ that integrates \\\Omega\\ over time:

\\\begin{equation} \frac{d{G}}{dt} = \Omega(t) dt. \end{equation}\\

Letting \\s\\ denote the moment a mosquito becomes infectious,
cumulative mortality from time \\t\\ to time \\t+s\\ is:

\\\begin{equation} \gamma(t,s) = { G}(t+s) - { G}(t). \end{equation}\\

The probability a mosquito becoming infectious at time \\t\\ survived
the interval to become infectious is:

\\\begin{equation} \Upsilon(t) = e^{-\gamma\left(t-\tau'(t), t\right)} =
e^{-\left({ G}\left(t\right) - { G}\left(t-\tau'(t) \right)\right)}.
\end{equation}\\

In solving the equations, we compute \\\Upsilon\\ as a set of accessory
variables with dynamics:

\\\begin{equation} \frac{d\Upsilon}{dt} =
\left(\Omega\left(t-\tau'(t)\right)\left(1-\frac{d\tau'(t)}{dt}\right)-\Omega(t)\right)\Upsilon(t)
\label{dUpsilon} \end{equation}\\

The initial condition, \\\Upsilon(0) = e^{-\Omega(0)},\\ can be computed
using the
[`expm`](https://cran.r-project.org/web/packages/expm/index.html)
package in R.
