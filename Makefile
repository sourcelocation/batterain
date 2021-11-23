ARCHS = arm64 arm64e
THEOS_DEVICE_IP = 192.168.1.90 -p 22
TARGET := iphone:clang:latest:12.2
INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Batterain

Batterain_FILES = $(shell find Sources/Batterain -name '*.swift') $(shell find Sources/BatterainC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
Batterain_SWIFTFLAGS = -ISources/BatterainC/include
Batterain_CFLAGS = -fobjc-arc -ISources/BatterainC/include

include $(THEOS_MAKE_PATH)/tweak.mk
