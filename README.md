# bitstream_filter
VHDL to filter a bit stream into samples for SDR. Just a proof of concept

In C you will find a C program to generate a 9182-entry lookup table that uses a Windowed Sinc filter kernel

In VHDL you will find the following:
- A test bench
- The top level design
- A pseudo random bit stream generator
- The component that converts the bit stream into filtered samples

