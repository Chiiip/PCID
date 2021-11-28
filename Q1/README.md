## RemoteController module

### Implementation
State machine to read a remote controller signal and identify what key was pressed. The input serial signal pattern is the following one:
![Input serial signal pattern](https://github.com/Chiiip/PCID/blob/master/Q1/InputSignalSample.png)

### Project settings
We are assuming that the remote controller signal carrier frequency is 38KHz, and we used a clock signal of 76kHz in order to identify each bit from the signal. The constraint for the input and output signal from the state machine is 10% of the clock period.
![TimeQuest Analysis](https://github.com/Chiiip/PCID/blob/master/Q1/TimeQuestTimingAnalysis.png)

### List of valid keys
These are the valid keys to be identified by the state machine:
![Key code map](https://github.com/Chiiip/PCID/blob/master/Q1/KeysCode.png)

### Test bench waveform
![Test bench waveform](https://github.com/Chiiip/PCID/blob/master/Q1/RemoteControllerWaveformTestbench.png)
