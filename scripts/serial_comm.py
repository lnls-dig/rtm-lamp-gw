#!/usr/bin/env python3

import argparse
import serial
import sys
import re


class RS232SysCon:
    """
    Serial communication with RS232 SysCon FPGA module
    """

    OUT_TERMINATOR = "\r"
    IN_TERMINATOR = "\r\n->"

    IN_READ_LINE_PATTERN = "r ([0-9a-fA-F]+)\r\r\n(?:[0-9a-fA-F]+)?\s*(?::)?\s*([0-9a-fA-F]+)?\s*([\w!?]+)\r\n"
    IN_WRITE_LINE_PATTERN = "w ([0-9a-fA-F]+)\s*([0-9a-fA-F]+)\r\r\n\s*([\w!?]+)\r\n"

    RET_CODES = {
        "OK": (0, "Command successfully executed"),
        "?":  (1, "Line length exceeded"),
        "A?": (2, "Address field parsing error"),
        "D?": (3, "Data field parsing error"),
        "Q?": (4, "Quantity field parsing error"),
        "!":  (5, "\"err_i\" or else watchdog timeout before \"ack_i\""),
        "B!": (6, "Watchdog timeout before bus grant"),
    }

    def __init__(self, device, baudrate=115200, timeout=1, write_timeout=1):
        self.device = device
        self.baudrate = baudrate
        self.timeout = timeout
        self.write_timeout = write_timeout
        self.read_patt = re.compile(RS232SysCon.IN_READ_LINE_PATTERN)
        self.write_patt = re.compile(RS232SysCon.IN_WRITE_LINE_PATTERN)

        self.serial = serial.Serial(port=self.device,
                                    baudrate=self.baudrate,
                                    timeout=self.timeout,
                                    writeTimeout=self.write_timeout)

    def write(self, addr, data):
        command = str("w" + " " +
                      hex(addr).replace("0x", "").rstrip("L") + " " +
                      hex(data).replace("0x", "").rstrip("L") +
                      RS232SysCon.OUT_TERMINATOR)
        self.serial.write(str.encode(command))

        line = self.serial.read_until(bytes(RS232SysCon.IN_TERMINATOR,
                                            "ascii")).decode("utf-8")
        match = re.match(self.write_patt, line)

        addr = int(match.groups()[0], base=16)
        data = int(match.groups()[1], base=16)
        ret = match.groups()[2]

        print("match: {}".format(match.groups()))

        ret_code = RS232SysCon.RET_CODES.get(ret,
                                             (7, "Unexpected return code"))

        if ret_code[0]:
            raise ValueError(ret_code)

    def read(self, addr):
        command = str("r" + " " +
                      hex(addr).replace("0x", "").rstrip("L") +
                      RS232SysCon.OUT_TERMINATOR)
        self.serial.write(str.encode(command))

        line = self.serial.read_until(bytes(RS232SysCon.IN_TERMINATOR,
                                            "ascii")).decode("utf-8")
        match = re.match(self.read_patt, line)

        data = 0
        if not match.groups()[1]:
            ret = match.groups()[2]
        else:
            data = int(match.groups()[1], base=16)
            ret = match.groups()[2]

        ret_code = RS232SysCon.RET_CODES.get(ret,
                                             (7, "Unexpected return code"))

        if ret_code[0]:
            raise ValueError(ret_code)

        return hex(data)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Serial communication with RS232 Syscon FPGA module")
    parser.add_argument("device", type=str, help="Device file", default="/dev/ttyUSB1")
    parser.add_argument("--addr", type=str, help="Address of read/write operation")
    parser.add_argument("--data", type=str, help="Data to write to device")
    parser.add_argument("--write", action="store_true", help="Perform write operation", default=False)
    parser.add_argument("--read", action="store_true", help="Perform read operation", default=False)

    args = parser.parse_args()

    try:
        dev = RS232SysCon(args.device)
    except Exception as e:
        raise

    if args.addr:
        addr = int(args.addr, base=16)
    else:
        print("Missing --addr option")
        sys.exit(1)

    if args.write:
        if args.data:
            data = int(args.data, base=16)
        else:
            print("Missing --data option")
            sys.exit(1)

        dev.write(addr, data)

    if args.read:
        result = dev.read(addr)
        print(result)
