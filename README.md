# Just_A_Dutchman_'s Library Files

This is my collection of files which I copy over to new projects if I need them. This README will provide you with additional information if needed on the library files


---



# Timer.lua

`Timer.lua` is a library file I use to time (parts of) my mods. For example, if I want to improve a mod, I make the new implementation and then time both of them to see which of them is faster. In general it is great to know how fast your program is, you might need to put some constraints on it.

A timer is a simple object that keeps track of when it started. When it is stopped, it subtracts the starting time from the final time to calculate the total recorded time. Timers all have a name, and you can use the same name multiple times. However, you cannot have multiple timers with the same name running at the same time. 

The advantage of using the same timer multiple times is that the library keeps track of some statistics, such as shortest recorded time, longest time recorded, etc. This allows you to get a better insight in how much time certain processes take in your program.

##  Objects

### TimerData
| Field name | Type | Default | Description |
| ---------- | ---- | ------- | ----------- |
| Name | string | | The name of the timer |
| TotalSeconds | number | | The total number of seconds this timer has recorded |
| TimesUsed | number | | The number of times this timer was used |
| ShortestTime | number _OR_ nil | nil | The shortest recorded time in seconds. This will only be tracked if the [TrackShortestTime]() was configured as `true` |
| LongestTime | number _OR_ nil | nil | The longest recorded time in seconds |
| Times | number[] _OR_ nil | nil | Array containing all recorded times |


### TimerConfig
| Field name | Type | Default | Description |
| ---------- | ---- | ------- | ----------- |
| PrintTimesWhenStopped | boolean | true | When true, each timer that is stopped will print its recorded time to the log |
| PrintTimerUpdateWhenStopped | boolean | false | When true, each timer that is stopped will print the updated values of that timer |
| TrackShortestTime | boolean | false | When true, **new** timers will keep track of the shortest time recorded |
| TrackLongestTime | boolean | false | When true, **new** timers will keep track of the longest time recorded |
| TrackAllTimes | boolean | false | When true, **new** timers will keep track of every individual recorded time |

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
