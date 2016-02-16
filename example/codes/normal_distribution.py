#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.cm as cm

mu    = [0.0, 0.0, 0.0, -2.0]
sigma = [0.2, 1.0, 5.0, 0.5]
x     = np.arange(-5, 5, 1e-3)
for i, ms in enumerate(zip(mu, sigma)):
    y = (1 / np.sqrt(2 * np.pi * ms[1])) * np.exp(-(x - ms[0])**2 / (2 * ms[1]))
    plt.plot(x, y, linewidth=3,
             color=cm.prism(1.0 * i / len(mu)),
             label=r'$\mu$='+str(ms[0])+r', $\sigma^2$='+str(ms[1]))
plt.legend(loc=0)
plt.minorticks_on()
plt.grid(True)
plt.xlim(xmin=min(x), xmax=max(x))
plt.show()
