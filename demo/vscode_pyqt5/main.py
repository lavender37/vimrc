# -*- coding=utf-8 -*-

import sys
import time
from threading import Thread
from PyQt5.QtWidgets import QApplication, QWidget, QLabel
from PyQt5.QtGui import QPixmap, QPalette
from PyQt5.QtCore import pyqtSignal


class MyApplication(QWidget):

    picture_list = [r"picture_1.jpg",
                    r"picture_2.jpg",
                    r"picture_3.jpg",
                    r"picture_4.jpg"
                    ]
    picture_index = 0
    picture_switch = pyqtSignal()

    def __init__(self, parent=None):
        QWidget.__init__(self, parent)

        self.palette = QPalette()
        self.label_pic = QLabel(self)
        self.label_pic.setPixmap(
            QPixmap(self.picture_list[self.picture_index]))
        self.clour = ""
        self.setWindowTitle(u'demo')
        self.setAutoFillBackground(True)
        self.resize(600, 500)
        self.move(500, 200)
        self.picture_switch.connect(self.switch_pic_from_signal)
        thread_t = Thread(target=self.generate_signal_per_sec)
        thread_t.start()

    def switch_pic_from_signal(self):
        if self.picture_index == len(self.picture_list):
            self.picture_index = 0
        self.label_pic.setPixmap(
            QPixmap(self.picture_list[self.picture_index]))
        self.picture_index = self.picture_index + 1

    def generate_signal_per_sec(self):
        for i in range(1, 100):
            time.sleep(1)
            self.picture_switch.emit()


if __name__ == '__main__':
    app = QApplication(sys.argv)
    foo = MyApplication()
    foo.show()
    sys.exit(app.exec_())
