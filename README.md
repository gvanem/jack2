# [JACK2](http://jackaudio.org)

[![Build Status](https://ci.appveyor.com/api/projects/status/github/gvanem/jack2?branch=master&svg=true)](https://ci.appveyor.com/project/gvanem/jack2)

My fork aims to get Jack2 compiled using MSVC and/or clang-cl.
The main differences are mostly related to the horrid `LIB_EXPORT` anf
`SERVER_EXPORT` stuff. All these `dllexport` and `dllimport` decorations
are now in a new file [`common/jack/export.h`](common/jack/export.h).


JACK2 aka jackdmp is a C++ version of the JACK low-latency audio server for
multi-processor machines. It is a new implementation of the JACK server core
features that aims at removing some limitations of the JACK1 design. The
activation system has been changed for a data flow model and lock-free
programming techniques for graph access have been used to have a more dynamic
and robust system.

- uses a new client activation model, that allows simultaneous client
  execution (on a SMP machine) when parallel clients exist in the graph (client
  that have the same inputs). This activation model allows to better use
  available CPU on a smp machine, but also works on mono-processor machine.

- uses a lock-free way to access (read/write) the client graph, thus
  allowing connections/disconnection to be done without interrupting the audio
  stream. The result is that connections/disconnections are glitch-free.

- can work in two different modes at the server level:

  - *synchronous activation*: in a given cycle, the server waits for all
    clients to be finished (similar to normal jackd)

  - *asynchronous activation*: in a given cycle, the server does not wait for
    all clients to be finished and use output buffer computed the previous
    cycle.
    The audible result of this mode is that if a client is not activated
    during one cycle, other clients may still run and the resulting audio
    stream will still be produced (even if its partial in some way). This
    mode usually result in fewer (less audible) audio glitches in a loaded
    system.
