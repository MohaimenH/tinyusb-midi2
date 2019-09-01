CFLAGS += \
  -mthumb \
  -mabi=aapcs \
  -mcpu=cortex-m4 \
  -mfloat-abi=hard \
  -mfpu=fpv4-sp-d16 \
  -DCORE_M4 \
  -DCFG_TUSB_MCU=OPT_MCU_LPC54XXX \
  -DCPU_LPC54114J256BD64_cm4 \
  -Wfatal-errors \
  -DCFG_TUSB_MEM_SECTION='__attribute__((section(".data")))' \
  -DCFG_TUSB_MEM_ALIGN='__attribute__((aligned(64)))' 

MCU_DIR = hw/mcu/nxp/lpc_driver/lpc54xxx/devices/LPC54114

# All source paths should be relative to the top level.
LD_FILE = $(MCU_DIR)/gcc/LPC54114J256_cm4_flash.ld

SRC_C += \
	$(MCU_DIR)/system_LPC54114_cm4.c \
	$(MCU_DIR)/drivers/fsl_clock.c \
	$(MCU_DIR)/drivers/fsl_gpio.c \
	$(MCU_DIR)/drivers/fsl_power.c \
	$(MCU_DIR)/drivers/fsl_reset.c

INC += \
	$(TOP)/hw/mcu/nxp/lpc_driver/lpc54xxx/CMSIS/Include \
	$(TOP)/$(MCU_DIR) \
	$(TOP)/$(MCU_DIR)/drivers

SRC_S += $(MCU_DIR)/gcc/startup_LPC54114_cm4.S

LIBS += $(TOP)/$(MCU_DIR)/gcc/libpower_cm4_hardabi.a

# For TinyUSB port source
VENDOR = nxp
CHIP_FAMILY = lpc_ip3511

# For freeRTOS port source
FREERTOS_PORT = ARM_CM4

# For flash-jlink target
JLINK_DEVICE = LPC54114J256_M4
JLINK_IF = swd

# flash using pyocd
flash: $(BUILD)/$(BOARD)-firmware.elf
	pyocd flash -v -e auto -t LPC54114 $<
