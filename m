Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 334CF8066B
	for <lists+linux-scsi@lfdr.de>; Sat,  3 Aug 2019 16:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391003AbfHCOAK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 3 Aug 2019 10:00:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37106 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387781AbfHCOAK (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 3 Aug 2019 10:00:10 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so34755694plr.4
        for <linux-scsi@vger.kernel.org>; Sat, 03 Aug 2019 07:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3n0RhoSIB7JVRaXi64yidBtGX4+uxR5GGMz8O3mwdM0=;
        b=RJmdxAs4ztfmIuBQd2nQcdNma2LAEbRH7YIjDkBTgqlhgrwPeOy1ix5C4++BA/G641
         5+xGGnOcrng00R1MOoDYbolh6eKsGQOd3OUham534XZluNbmaDLhsvovIFKRqms245LY
         4eTM0iQJ9UJZHpbSpMtf/sMkSEfpSYrGVE+Rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3n0RhoSIB7JVRaXi64yidBtGX4+uxR5GGMz8O3mwdM0=;
        b=ZTLw/4h+yAm82qk5hzQCU4XnmpIucwCxFTWK7XjH/QtpjNJeoJ0lOuWtTi7uJDL+Rf
         O+ZUj7O4h0508hI+FwxsgRkYgaZnDeYqqxTxnVIgFJ25F45hmrTmuDLlwMoY48EVA7r+
         bVQRcE1POy78f/hSjCRPPwkHGo46LUZJstva6T/oCuuHWRyjKyJeUs3qOPMj8WGqylLH
         zCne1IAAk5MdlO9Y8ykYgry9V45W+AMfq85MZ4cdZAFLbrIwREWxbKe+rA8hAsazTGBl
         v6vm2ptEfNIISgp3K/I9QWSXNfqjYjJH5TNNNdGyLPLrc1VFhLTi90SC8M7zCwI+Bznt
         /1OA==
X-Gm-Message-State: APjAAAV/wM/j0c3UqsmzuRqxMnl1qAwRH9GfnL4gmkHx3zc7u1WS14ez
        DF308q3P78goOP5UVu/X0pg7J1lbcSZnq+XxlMHg9ICN3t9NU6+m/P803YGo9VaydRK2cFaSv0E
        GoIVuLIuEUAUNjGFcTVf0sewRhAzB98bznQWkkDCxypZx4nH8OyWz4JFgelopuFimJPxu5Mm12/
        OudrNN4XgEt4KOkrs+tg==
X-Google-Smtp-Source: APXvYqw16k3pyN/RqJk89/FU3AQpMXTxJW0gv0ppY3xAKqi/ZaBTlT3kRkqx23yYD8hXX+wkvCU4VA==
X-Received: by 2002:a17:902:6b07:: with SMTP id o7mr4970779plk.180.1564840809441;
        Sat, 03 Aug 2019 07:00:09 -0700 (PDT)
Received: from dhcp-10-123-20-15.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id c69sm11711615pje.6.2019.08.03.07.00.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 07:00:08 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, kashyap.desai@broadcom.com,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH 00/12] mpt3sas: Features and defect fixes.
Date:   Sat,  3 Aug 2019 09:59:45 -0400
Message-Id: <1564840797-5876-1-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch series includes below Enhancements
and Bug fixes.

Suganath Prabu (12):
  mpt3sas: Add support for PCIe Lane margin
  mpt3sas: memset request frame before reusing
  mpt3sas: Gracefully handle online firmware update
  mpt3sas: Update MPI headers to 2.6.8 spec
  mpt3sas: Enumerate SES of a managed PCIe switch
  mpt3sas: Allow ioctls to blocked access status NVMe
  mpt3sas: Support MEMORY MOVE Tool box command
  mpt3sas: Add sysfs to know supported features
  mpt3sas: Handle fault during HBA initialization
  mpt3sas: Reduce the performance dip
  mpt3sas: Process SAS DEVICE STATUS CHANGE EVENT from ISR
  mpt3sas: Update driver version to 31.100.00.00

 drivers/scsi/mpt3sas/mpi/mpi2.h       |   5 +-
 drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h  |  10 +-
 drivers/scsi/mpt3sas/mpi/mpi2_image.h |  39 ++++----
 drivers/scsi/mpt3sas/mpi/mpi2_pci.h   |  13 +--
 drivers/scsi/mpt3sas/mpi/mpi2_tool.h  |  13 +--
 drivers/scsi/mpt3sas/mpt3sas_base.c   | 175 +++++++++++++++++++++++++++++++---
 drivers/scsi/mpt3sas/mpt3sas_base.h   |  28 +++++-
 drivers/scsi/mpt3sas/mpt3sas_ctl.c    |  59 ++++++++++--
 drivers/scsi/mpt3sas/mpt3sas_scsih.c  | 156 ++++++++++++++++++++----------
 9 files changed, 391 insertions(+), 107 deletions(-)

-- 
1.8.3.1

