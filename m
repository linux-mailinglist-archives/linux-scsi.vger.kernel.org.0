Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFF5168B7
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 19:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfEGRGK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 May 2019 13:06:10 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38646 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEGRGK (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 May 2019 13:06:10 -0400
Received: by mail-pl1-f193.google.com with SMTP id a59so8481995pla.5
        for <linux-scsi@vger.kernel.org>; Tue, 07 May 2019 10:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5RuO58GuoMUc6oVDaxjuLHpX5cjztxPWWKuFxLRCDY4=;
        b=glgkhPLHLi8r0H9WmGCdjP7Da257tuMwMRFdkVhhcScRmFvDskqizFextRBtKgBQwn
         NvMEAgCjfKjrB5V5xiE0Ny2iipKYdrq/nImtRS8dZ66s2KCqEu9c83hEE4CJahjyyrrS
         DevaHZfge2Ksa+Q30mP56985yrDdXPKofhPzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5RuO58GuoMUc6oVDaxjuLHpX5cjztxPWWKuFxLRCDY4=;
        b=pFQhr/8s5aRaapwSsyNlU4RADHkCXXT+RlKa1RSHlmEhMJ4b0oXARB8Det134utQ61
         ggLfK4tX5/EKrF5pPGRXCDMv4r5PDPg+x5i3N/V14z5pODZrtKV8ALxjnQI0jQ8Oww9T
         3VI9vP30gtRKxYI/HH42ly4D9B8YqsLtAXfJcYOqOF6QubXPa6I30yK0nCDYV3BaH9Sd
         wdd1likzBvlBHYGrXj/33lJEKmUuKXcvxpC+/pXrNNGpJZixyWvvbxr1IgT6v+zGmoYc
         JoBVzjAvR64mV9zcMAWD3xgdT9Ayfjxd9weSb8OGuv6om6jVaKZphtv3+PWjfYQhkbEe
         NX0A==
X-Gm-Message-State: APjAAAV/c/JQqPzJkSRaxGyooOCYRUswAJmLMafKABVkcXuCxSPpWUoH
        lm3smzn44omlCeMvEOdFmt64RnJt8TitVFfkJRbA9OLUMB16cW6qKLxY+1jrnyCH3k3AhGfEAGt
        RQ23VU1pPzeJu2CaA3z7GBcsmTwBwtl2Vk4HXAvQIFI7dpEXDQsakBVhJRCQ0SU6cXDn8McLjB1
        DD7gFsBpzPNVfhhaLYk7dn
X-Google-Smtp-Source: APXvYqzBD0V1HSyESPq6DVXCFRHHKwQ33BtakBXkKFHZwwbzVPc5/p1G4JPv6U5tEVuvcdL+Np7WuA==
X-Received: by 2002:a17:902:b202:: with SMTP id t2mr14966697plr.69.1557248768845;
        Tue, 07 May 2019 10:06:08 -0700 (PDT)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r74sm17527791pfa.71.2019.05.07.10.06.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:06:07 -0700 (PDT)
From:   Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH v2 00/21] megaraid_sas: Driver updates
Date:   Tue,  7 May 2019 10:05:29 -0700
Message-Id: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Update megaraid_sas to version 07.708.03.00.

The initial patch contains a cleanup of unused variable.
Next four patches contain driver fixes and enhancements.
Patch 6 introduces IRQ polling in megaraid_sas driver to fix
CPU hard/soft lockups that we have seen in the field.
Patch 7 adds load balancing of IO completions across the available
reply queues when combined MSIx mode is disabled in firmware.
Patch 8 onwards adds few enhancements to improve debuggability
of the driver by printing additional information and provding
a debugfs interface to help debug field issues better.

Changes in v2:
- Patch 2: updated applicable kernel versions in stable tag
- Patch 6: Fixed kbuild test robot reported sparse warning
- Patch 11: Fixed kbuild test robot reported sparse warning
- Patch 12: Fixed a sparse warning

Shivasharan S (21):
  megaraid_sas: remove unused variable target_index
  megaraid_sas: Fix calculation of target ID
  megaraid_sas: fw_reset_no_pci_access required for MFI adapters only
  megaraid_sas: rework code around controller reset
  megaraid_sas: Block PCI config space access from userspace during OCR
  megaraid_sas: IRQ poll to avoid CPU hard lockups
  megaraid_sas: Load balance completions across all MSIx
  megaraid_sas: Enhance prints in OCR and TM path
  megaraid_sas: Enhance internal DCMD timeout prints
  megaraid_sas: Add formatting option for megasas_dump
  megaraid_sas: Dump system interface regs from sysfs
  megaraid_sas: Dump system registers for debugging
  megaraid_sas: Print BAR information from driver
  megaraid_sas: Export RAID map id through sysfs
  megaraid_sas: Print FW fault information
  megaraid_sas: Print firmware interrupt status
  megaraid_sas: Add prints in suspend and resume path
  megaraid_sas: Add debug prints for device list
  megaraid_sas: Fix MSI-x vector print
  megaraid_sas: Export RAID map through debugfs
  megaraid_sas: Update driver version to 07.708.03.00

 drivers/scsi/megaraid/Kconfig.megaraid       |   1 +
 drivers/scsi/megaraid/Makefile               |   2 +-
 drivers/scsi/megaraid/megaraid_sas.h         |  27 ++-
 drivers/scsi/megaraid/megaraid_sas_base.c    | 338 +++++++++++++++++++++++----
 drivers/scsi/megaraid/megaraid_sas_debugfs.c | 180 ++++++++++++++
 drivers/scsi/megaraid/megaraid_sas_fp.c      |   1 +
 drivers/scsi/megaraid/megaraid_sas_fusion.c  | 303 +++++++++++++++++-------
 drivers/scsi/megaraid/megaraid_sas_fusion.h  |   6 +-
 8 files changed, 720 insertions(+), 138 deletions(-)
 create mode 100644 drivers/scsi/megaraid/megaraid_sas_debugfs.c

-- 
2.16.1

