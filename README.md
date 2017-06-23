# SlotMachine
A  slot machine animation for iOS. 🎲

## Trial 1
 
基于 `UITableView` 实现滚动效果。滚动到最后一行时，迅速返回到起始位置。如此往复。缺点在层次比较多，需要 `cell` `tableView` 以及 N 多代理方法。并且返回到起始位置的动作，使动画看起来有点不爽。

[demo](https://github.com/zssr/SlotMachine/tree/master/SlotMachine)

运行效果

![](https://github.com/zssr/SlotMachine/blob/master/images/slotmachine.gif)

MP4视频会清晰一点，[点击下载](https://github.com/zssr/SlotMachine/blob/master/images/slotmachine.mp4?raw=true)

## Trial 2

基于 CA 动画。只要循环改变 `UILabel` 的文字即可，简单直白。基本原理参见：[zssr/LabelTextChangeAnimation](https://github.com/zssr/LabelTextChangeAnimation)。

完整的老虎机动画实现： [demo](https://github.com/zssr/SlotMachine/tree/master/SlotMachine-Refined)

## License

[MIT](https://github.com/zssr/SlotMachine/blob/master/LICENSE)
