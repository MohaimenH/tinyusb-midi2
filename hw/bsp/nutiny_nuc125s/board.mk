CFLAGS += \
  -flto \
  -mthumb \
  -mabi=aapcs-linux \
  -mcpu=cortex-m0 \
  -D__ARM_FEATURE_DSP=0 \
  -DUSE_ASSERT=0 \
  -DCFG_EXAMPLE_MSC_READONLY \
  -DCFG_TUSB_MCU=OPT_MCU_NUC121

# All source paths should be relative to the top level.
LD_FILE = hw/bsp/nutiny_nuc125s/nuc125_flash.ld

SRC_C += \
  hw/mcu/nuvoton/nuc121_125/Device/Nuvoton/NUC121/Source/system_NUC121.c \
  hw/mcu/nuvoton/nuc121_125/StdDriver/src/clk.c \
    hw/mcu/nuvoton/nuc121_125/StdDriver/src/gpio.c

SRC_S += \
  hw/mcu/nuvoton/nuc121_125/Device/Nuvoton/NUC121/Source/GCC/startup_NUC121.S

INC += \
  $(TOP)/hw/mcu/nuvoton/nuc121_125/Device/Nuvoton/NUC121/Include \
  $(TOP)/hw/mcu/nuvoton/nuc121_125/StdDriver/inc \
  $(TOP)/hw/mcu/nuvoton/nuc121_125/CMSIS/Include

# For TinyUSB port source
VENDOR = nuvoton
CHIP_FAMILY = nuc121

# For freeRTOS port source
FREERTOS_PORT = ARM_CM0

# For flash-jlink target
JLINK_DEVICE = NUC125SC2AE
JLINK_IF = swd

# Flash using Nuvoton's openocd fork at https://github.com/OpenNuvoton/OpenOCD-Nuvoton
# Please compile and install it from github source
flash: $(BUILD)/$(BOARD)-firmware.elf
	openocd -f interface/nulink.cfg -f target/numicroM0.cfg -c "program $< reset exit"