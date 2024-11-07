# Just_A_Dutchman_'s Library Files

This is my collection of files which I copy over to new projects if I need them. This README will provide you with additional information if needed on the library files


---



# Timer.lua

`Timer.lua` is a library file I use to time (parts of) my mods. For example, if I want to improve a mod, I make the new implementation and then time both of them to see which of them is faster. In general it is great to know how fast your program is, you might need to put some constraints on it.

## Objects

### TimerData
| Field name | Type | Description |
| ---------- | ---- | ----------- |
| Name | string | The name of the timer |
| TotalSeconds | number | The total number of seconds this timer has recorded |
| TimesUsed | number | The number of times this timer was used |
| ShortestTime | number _OR_ nil | The shortest recorded time in seconds. This will only be tracked if the [TrackShortestTime]() was configured as `true` |
| LongestTime | number _OR_ nil | The longest recorded time in seconds |
| Times | number[] _OR_ nil | Array containing all recorded times |

## Functions

### InitTimer
**Definition**: `Timer.InitTimer(wl)`

**Parameters**: 
- wl [_WL_](https://www.warzone.com/wiki/Mod_API_Reference:WL)

**Description**: Function to configure the timers 

**How to use**: This function must be called before you can start a timer. In order to be able to time how long something took the library needs access to the [TickCount()](https://www.warzone.com/wiki/Mod_API_Reference:TickCount) function. Therefore, starting/stopping a timer before this function has been called will throw an error. The only function you may call before initializing the library is the [Timer.Config]() function.


### Config
**Definition**: `Timer.Config(params)`

**Parameters**:
- 
