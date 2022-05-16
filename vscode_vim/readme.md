注：other表示编辑器以外的窗口，包括Explorer window，Setting window，Terminal window，这些窗口下切换窗口以及vim设置失效

# 特殊命令
| 状态   | 命令 | 描述                                                                           |
| ------ | ---- | ------------------------------------------------------------------------------ |
| Normal | gd   | 跳转到定义                                                                     |
| Normal | gq   | 在视觉选择上重排和文字包装块的文本，保留注释风格。非常适合格式化文档注释       |
| Normal | gb   | 在它找到的下一个单词上添加另一个光标，该单词与光标下的单词相同                 |
| Normal | af   | 可视模式命令，选择越来越大的文本块                                             |
| Normal | gh   | 相当于将鼠标悬停在光标所在的任何位置。方便查看类型和错误消息，而无需触及鼠标！ | N |

# 常用编辑器相关快捷键
| 状态   | 命令   | 描述                |
| ------ | ------ | ------------------- |
| Insert | ctrl-b | 打开/关闭文件浏览器 |
| Normal | ctrl-b | 向上滚动N屏         |
| Insert | ctrl-f | 开始搜索            |
| Normal | ctrl-f | 向下滚动N屏         |
| Insert | ctrl-t | 当前行首添加缩进    |
| Normal | ctrl-t | 跳转tag             |

# 常用窗口快捷键
| 状态         | 命令   | 描述              |
| ------------ | ------ | ----------------- |
| Insert       | ctrl-w | 删除光标前的单词  |
| Normal       | ctrl-w | 按hl切换窗口      |
| Insert       | ctrl-c | 退出Insert模式    |
| Normal       | ctrl-c | 关闭当前tab页     |
| Normal       | t      | 切换到下一个tab页 |
| Normal       | T      | 切换到上一个tab页 |

# other情况下窗口切换
| 状态         | 命令   | 描述              |
| ------------ | ------ | ----------------- |
| other        | ctrl-w | 关闭当前tab页      |
| other        | ctrl-tab | 切换到最近使用的tab页      |
