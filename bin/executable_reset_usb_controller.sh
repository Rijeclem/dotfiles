#!/bin/bash
CTRL="0000:02:00.0"

# Unbind / bind USB controller
echo -n $CTRL >/sys/bus/pci/drivers/xhci_hcd/unbind
sleep 2
echo -n $CTRL >/sys/bus/pci/drivers/xhci_hcd/bind
