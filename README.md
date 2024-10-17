# A Fully Analog Circuit capable of training a Multilayer Perceptron

This repo outlines a circuit capable of training a Multilayer Perceptron (MLP) fully in analog.

The SPICE Netllist of the circuit is created programatically via PySpice, and simulated via a Xyce transient simulation.

For now, idealized switches and amplifiers are used. The synapses are implemented via NFETs whose parameters are roughly modeled after the those found SKY130 PDK.

